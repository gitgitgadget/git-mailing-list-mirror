From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git/cogito usage scenarios for CVS refugee
Date: Wed, 8 Jun 2005 21:51:17 +1200
Message-ID: <46a038f9050608025152af4163@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Jun 08 11:48:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dfx9q-0006xK-Qi
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 11:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVFHJvV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 05:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVFHJvV
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 05:51:21 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:42256 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262126AbVFHJvR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 05:51:17 -0400
Received: by rproxy.gmail.com with SMTP id i8so226021rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 02:51:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jN+1FmN1C79mHAoD3nAYnCXmniaOZQzOsq10cT+iCtel5jmhcJ3qqeB0bXUBExgyKFUq453u64Cj/QfP3tLRQy/kG59QSkoHMdA3LujPJKiIAGn+lie0UdfmGWweibmZEI7M0PtBESFAKJaKJ4m5icCfyydZrMWs/7AONpRL5qs=
Received: by 10.38.104.24 with SMTP id b24mr3585907rnc;
        Wed, 08 Jun 2005 02:51:17 -0700 (PDT)
Received: by 10.38.101.46 with HTTP; Wed, 8 Jun 2005 02:51:17 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Trying to get my head around what usage patterns the git
infrastructure supports. I'm interested in exploring more git-centric
approaches...

For a project that uses CVS with a classic HEAD and FOO_15_STABLE
approach, where FOO_15_STABLE gets only fixes -- how do I manage HEAD
and XX_STABLE where some patches that work well in HEAD I may decide
to merge into XX_STABLE, and some security patch may be applied first
to XX_STABLE and then to HEAD? I can apply the patch on both branches
-- yep. But does git help me in keeping track of what's been merged?

Does git help in any way to keep track of patches across 2.6.11.12 and
2.6.12rc5 ?

In a git-based project, one developer is about to merge from someone
else's tree, are there any tools to review the patchlog that is about
to be applied (or replayed?) against his tree? Is there any way to say
"of the 20 commits that I'm about to merge, hold off 2" other than
letting git apply them ... and backing them out right next?

And generally, is there any long-lived branch support? If I am to run
a "local branch" of the Linux kernel, does git help me at all?

So far I think the answer is "no -- you'll need to keep track of your
damn patches somewhere else" ;-) but there's a lot about the git
mindset I don't quite understand yet. And I'm sure that the workflow
of the Linux team must have some ancillary tools & strategies to keep
track of this.

cheers,


martin
