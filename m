From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Sat, 8 Jun 2013 20:17:08 -0500
Message-ID: <CAMP44s21hyKLw0=hwOzuNzSuQx4qeca2VLnz9Reh5rD7j4oSrw@mail.gmail.com>
References: <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CACsJy8BMrxLZFGQfUN1YCG+qkAj-91aYkc54R5O4iqgXUNeQOw@mail.gmail.com>
	<CAMP44s08V1=nVbeo6r8UVT3Fd0=iSpRohinqf77Tmu4=xpDHeg@mail.gmail.com>
	<CACsJy8DTKr5Fy3-+8ShUrWQrKC2_7EmLHwyVgQ9Aq5JDOFBAqA@mail.gmail.com>
	<CAMP44s0GUrQqXCj97Ay+0CsA1z=96BPYfyADbTaHH7fc7HL0sQ@mail.gmail.com>
	<CACsJy8D8xD3mdC2gsBpU74Faa+CUfEWEgh5fhwPoRjz46-hjcw@mail.gmail.com>
	<CAMP44s192hzh8AWU-Eg1VVVXjZ9qyNqHw99X6y48MXJn3DHw+Q@mail.gmail.com>
	<20130608171513.GA28029@sigill.intra.peff.net>
	<CAMP44s1pkNd1NBM_q8Hb71jDOMXrX7_szQvNudGafYYQpdBt0Q@mail.gmail.com>
	<20130609001025.GB29964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 03:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlUG4-00008p-F2
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 03:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab3FIBRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 21:17:12 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:57800 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab3FIBRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 21:17:11 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so2091697lba.30
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 18:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NS0fLcIydHswX1+VttQWmfzD77mJVEtCKIsov8vzDKQ=;
        b=HBpctX3dWGIC9gHoLDfGqILaDQnG+QNRwdY9ct/48mBaYIaUdjgaVixcT4iSlTTTdv
         q5npRIQjTxZwZcM7P+a54uiWWPSg/9rzUJ7AjF+QQE3+b81RKRtVa4Hs0bhbnqWAk6T3
         YJH/JNMryoHG1xUkoye6QZNnjU81bXGwmo/Q7hCcSzWNKa/QqllwnZ2uae/8zc8pX3mx
         orhf9QQMvyFL7gjzrGzsJ6F8TPzb2Dh4YnncxkE8P5x8cRHH+paH2zeYbDsFuixq3kvw
         jDWLRJSFdQSQ3qFqnRDLSpeyjLOW9qLy68VhO2azEv1B6pByUrWUvWs65EEUWvrPWv0F
         IHxA==
X-Received: by 10.152.43.136 with SMTP id w8mr2166573lal.63.1370740628946;
 Sat, 08 Jun 2013 18:17:08 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 18:17:08 -0700 (PDT)
In-Reply-To: <20130609001025.GB29964@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226866>

On Sat, Jun 8, 2013 at 7:10 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 08, 2013 at 12:40:19PM -0500, Felipe Contreras wrote:
>
>> > These are problems that can be solved. But there is a lot of work
>> > involved in finding these subtle bugs and coming up with fixes. I think
>> > you would be better off working on an implementation of git that was
>> > designed from scratch to work in-process, like libgit2.
>>
>> So you are in favor of never ever having an official Git library. Got it.
>
> No, I didn't say that at all.

Then you truly think libgit2 will ever reach the point where it can
replace libgit.a?

It won't. But decreeing that both projects should remain isolated, and
that libgit.a should never be a library, you are effectively
condemning the effort to fail, knowingly or not.

How many years has libgit2 been brewing? Do you think it's closer for
merging so it can be used by Git's core? No, it doesn't, and it will
not in the future, because it was never meant for that.

> I do think that it would be more work to try to slowly massage the git
> code into a library-ready form than it would be to simply start with
> more library-friendly code and pull in bits of git.git as appropriate.

It might be more effort, but the results are guaranteed by our
extensive testing infrastructure and huge user-base. Slowly but
steadily we'll get there.

Waiting for libgit2 to switch directions and reach some hypothetical
point is waiting for hell to freeze.

It won't happen. There's no incentive nor reason for it to happen.

> That is what the libgit2 project is doing.  Perhaps one day that project
> will reach a point where we start building git.git commands off of it or
> sometihng like it (for that matter, there is no reason you could not
> build external commands off of libgit2 right now).  Would it be the
> "official" Git library then? I don't know. It is not clear to me what
> that even means.

It means 'make install' installs a shared library with a clearly
defined and stable API that other projects can depend on, and it can
be used for all sort of purposes, including the git binary, and it's
builtins.

> In the meantime, I think it cannot be a bad thing for libgit2 to proceed
> along its path, and I don't see a good reason for people not to use it.

Its path will never end as an official Git library, not unless we do something.

> But hey, you don't need to listen to me. If you think it would be easier
> to make the git.git code into a library, go ahead and work on it. But I
> think you will find that there are a large number of hard-to-find bugs
> caused by implicit assumptions about global state, how file descriptors
> are used, and so forth.

That's impossible. Specially since moving irrelevant code out of
libgit.a is not permitted.

>> There's a reason why the Git project doesn't use libgit2, and for the
>> same reason the official Ruby scripts should not use it.
>
> What reason is that?

You tell me. Why isn't Git using libgit2?

>> As history indicates, the Git project will never have any pressure to
>> fix it's re-entrancy and re-run issues, so these issues will remain
>> there forever.
>>
>> Only if you allow code that exposes those issues will there ever be
>> any pressure to fix them.
>
> I think it is a matter of critical mass. If you were to start linking
> against libgit.a and 90% of it worked, you might have a reason to fix
> the other 10%. But I suspect it is more the other way around.

It doesn't matter if it's 90% or 10%, it's the only thing we have.

Unless you are in favor of including libgit2 and start using it for
Git's core *right now*, the only way forward is to improve libgit.a.

-- 
Felipe Contreras
