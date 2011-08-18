From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: [PATCH 0/10] color and pager improvements
Date: Thu, 18 Aug 2011 23:59:53 +0200
Message-ID: <20110818215953.GA68667@sherwood.local>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 00:00:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAdG-0002Bv-A5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817Ab1HRWAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:00:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47306 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797Ab1HRWAB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:00:01 -0400
Received: by fxh19 with SMTP id 19so1567742fxh.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uJfXi4pG9w6+bY8H2RgarIim55s3KauuEpTwuQkEnnw=;
        b=HInp1vvjqPyTwwH9Jjka109jXGwAOM6IEvuABvHewWZXg8LqFn2qJWFNJURN+kwz42
         TMkX2pocMn+E/7ymbDn+NxBgzAZfsG0swcnAtOI8QM4TDVW0kIwV7O74ho8tvfkxCVwq
         IhxhqgKcxw5g1IzxT1tM2K7N1UPpvaRwmEkp8=
Received: by 10.223.52.132 with SMTP id i4mr1733477fag.107.1313704800694;
        Thu, 18 Aug 2011 15:00:00 -0700 (PDT)
Received: from sherwood.local ([82.113.99.138])
        by mx.google.com with ESMTPS id b13sm199967fak.16.2011.08.18.14.59.58
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 14:59:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179633>

@ Jeff King <peff@peff.net> wrote (2011-08-18 06:58+0200):
> These three fix the problem Steffen mentioned here:

Uuuh, such a shame - you know that it was first noted by
Benjamin Kudria (2008-07-23,
http://marc.info/?l=git&m=121677902502581&w=2).
And it was you who tried to resurrect the same issue last year.
(The thing is: i did not search the archive first because it was
clearly a bug.  I did once you referred to your older patch.)
But great that you actually found the time to fix it!

(I must admit though that i'm currently addicted to the coloured
output, because simply switching between my terms gives a clear
indication of where i'm currently git(1)ing.  :->  And that in
turn is something which gives more and more fun the longer i use
it!  It is *really* fantastic once you get used to it.  And do
gc --aggressive and all your temporary fooling is cleaned up.)

Now it's pretty unfortunate that i cannot offer fixes for
anything.

I have a dumb patch of 'rebase -i' which includes the TODO entry
line ($rest) as a comment in the commit message, which is pretty
useful because i think about the rebase task and can store
comments in that very line.  But it introduces commit
--cleanup=strip and patches commit.c to add a --message-prefix
option.  This is no good yet.

Michael J Gruber's today's shocking exercise on the german
keyboard layout - maybe i should really resurrect parts of that
NBSP series?

And referring to one sentence of yours from the past: no, refspec
stuff *is* that hard: they are not a tree which is created via
'refs_build_tree(); refs_merge_command_line();' upon program
start, with pointers to maybe instantiated .. whatever.
/*
 * Note. This is used only by "push"; refspec matching rules for
 * push and fetch are subtly different, so do not try to reuse it
 * without thinking.
 */
I gave up once i found that (in remote.c).  (AFAIR it seems
refspecs are first build L->R, then pushed, then build again but
in R->L direction.  Which is why without a fetch= the remotes/
ref is not updated after a push.  AFAIK - i gave up ...)

But i'm looking forward and really hope to be able to contribute
some useful and good stuff to great projects in the future.
OpenBSD, for example.  :-)

--Steffen
Ciao, sdaoden(*)(gmail.com)
ASCII ribbon campaign           ( ) More nuclear fission plants
  against HTML e-mail            X    can serve more coloured
    and proprietary attachments / \     and sounding animations
