From: Jeff King <peff@peff.net>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 22:23:51 -0400
Message-ID: <20130609022351.GA30393@sigill.intra.peff.net>
References: <CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
 <CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
 <CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
 <CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
 <CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
 <CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
 <20130608171513.GA28029@sigill.intra.peff.net>
 <CAMP44s1pkNd1NBM_q8Hb71jDOMXrX7_szQvNudGafYYQpdBt0Q@mail.gmail.com>
 <20130609001025.GB29964@sigill.intra.peff.net>
 <CAMP44s21hyKLw0=hwOzuNzSuQx4qeca2VLnz9Reh5rD7j4oSrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 04:24:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlVIc-0002Jy-Id
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 04:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247Ab3FICX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 22:23:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:58990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab3FICXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 22:23:54 -0400
Received: (qmail 4019 invoked by uid 102); 9 Jun 2013 02:24:43 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Jun 2013 21:24:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Jun 2013 22:23:51 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s21hyKLw0=hwOzuNzSuQx4qeca2VLnz9Reh5rD7j4oSrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226870>

On Sat, Jun 08, 2013 at 08:17:08PM -0500, Felipe Contreras wrote:

> > No, I didn't say that at all.
> 
> Then you truly think libgit2 will ever reach the point where it can
> replace libgit.a?

I don't know. It may. Or something like it may. It is certainly not
ready to do so yet, but perhaps one day it will be.

> It won't.

Oh, I see, you were not actually interested in my answer and were just
being rhetorical.

> But decreeing that both projects should remain isolated, and
> that libgit.a should never be a library, you are effectively
> condemning the effort to fail, knowingly or not.

Huh? When did I decree anything? You asked Duy what kinds of problems
you would run into with running multiple git commands in the same
process space. I answered with concrete examples, and gave my opinions
on what the path of least work would be to reach a re-entrant library.
You don't have to agree (didn't I even say "you don't have to listen to
me" in the last email?).

> How many years has libgit2 been brewing? Do you think it's closer for
> merging so it can be used by Git's core? No, it doesn't, and it will
> not in the future, because it was never meant for that.

There has been about 2 years of active development, and there's been
quite a lot of improvement in that time. Closer than what? Than it was 2
years ago? Yes, I think it is. But it still has a ways to go.

I do not think there will be a flag day where we throw away git.git's
code and start using libgit2. But we could slowly start replacing
underlying bits with libgit2 bits, if that implementation proves to be
robust and clean enough to do so.

> > But hey, you don't need to listen to me. If you think it would be easier
> > to make the git.git code into a library, go ahead and work on it. But I
> > think you will find that there are a large number of hard-to-find bugs
> > caused by implicit assumptions about global state, how file descriptors
> > are used, and so forth.
> 
> That's impossible. Specially since moving irrelevant code out of
> libgit.a is not permitted.

I'm not even sure what your second sentence means.

But it seems to me that the first step would be cleaning up the internal
code so that it is more friendly to library callers (both in interface
and in being re-entrant), with those first sets of callers being the
existing code in git.git. Such cleanups would be a good thing for the
modularity of the code, even without an intended library step.

And then you can start to pull out individual interfaces that are known
to be safe for library use, and think about making a coherent library
out of them.

And please don't tell me about "not permitted". You are free to fork and
work on this. But do not expect people who have already said "that does
not seem like a fruitful path to me" to jump into it with you. If you
think it is worth doing and that you can come up with initial results to
convince others, go for it.

> >> There's a reason why the Git project doesn't use libgit2, and for the
> >> same reason the official Ruby scripts should not use it.
> >
> > What reason is that?
> 
> You tell me. Why isn't Git using libgit2?

Wait, you indicated you had such a reason in mind, but now you won't
tell me? Is it a secret?

> > I think it is a matter of critical mass. If you were to start linking
> > against libgit.a and 90% of it worked, you might have a reason to fix
> > the other 10%. But I suspect it is more the other way around.
> 
> It doesn't matter if it's 90% or 10%, it's the only thing we have.
> 
> Unless you are in favor of including libgit2 and start using it for
> Git's core *right now*, the only way forward is to improve libgit.a.

That seems like a false choice to me. You obviously feel that libgit2 is
some kind of dead end. I don't agree. Whatever.

I have very little interest in discussing this further with you, as it
is not leading in a productive direction. In my opinion, the productive
things to do would be one (or both) of:

  1. Work on libgit2.

  2. Clean up non-reentrant bits of git.git, hopefully making the code
     more readable and more modular (and taking care not to make it
     worse in other ways, like maintainability or performance).

-Peff
