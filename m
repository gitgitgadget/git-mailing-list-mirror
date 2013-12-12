From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Wed, 11 Dec 2013 23:26:24 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131212042624.GB8909@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 05:26:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqxr6-0004wr-3U
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 05:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab3LLE00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 23:26:26 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:34955
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3LLE0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 23:26:25 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 9C2973805F8; Wed, 11 Dec 2013 23:26:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239225>

Martin Langhoff <martin.langhoff@gmail.com>:
> On Wed, Dec 11, 2013 at 7:17 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> > I tried very hard to salvage this program - the ability to
> > remote-fetch CVS repos without rsync access was appealing
> 
> Is that the only thing we lose, if we abandon cusps? More to the
> point, is there today an incremental import option, outside of
> git-cvsimport+cvsps?

You'll have to remind me what you mean by "incremental" here. Possibly
it's something cvs-fast-export could support.

But what I'm trying to tell you is that, even after I've done a dozen
releases and fixed the worst problems I could find, cvsps is far too
likely to mangle anything that passes through it.  The idea that you
are preserving *anything* valuable by sticking with it is a mirage.

"That bear trap!  It's mangling your leg!"  "But it's so *shiny*..."

> [ I am a bit out of touch with the current codebase but I coded and
> maintained a good part of it back in the day. However naive/limited
> the cvsps parser was, it did help a lot of projects make the leap to
> git... ]

I fear those "lots of projects" have subtly damaged repository
histories, then.  I warned about this problem a year ago; today I
found out it is much worse than I knew then, in fact so bad that I
cannot responsibly do anything but try to get cvsps turfed out of use
*as soon as possible*.

And no, that should *not* wait on cvs-fast-export getting better 
support for "incremental" or any other legacy feature.  Every week
that cvsps remains the git project's choice is another week in which
somebody's project history is likely to get trashed.

This feels very strange and unpleasant.  I've never had to shoot one
of my own projects through the head before.

I blogged about it: http://esr.ibiblio.org/?p=5167

Ignore the malware warning. It's triggered by something else on ibiblio.org;
they're fixing it.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
