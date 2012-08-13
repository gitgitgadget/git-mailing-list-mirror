From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Your branch and 'origin/master' have diverged
Date: Mon, 13 Aug 2012 12:58:40 -0700
Message-ID: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 21:59:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T10n7-0007PL-FB
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 21:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241Ab2HMT7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 15:59:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42305 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab2HMT7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 15:59:01 -0400
Received: by bkwj10 with SMTP id j10so1471565bkw.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=w9XuCcKBmOQHytgrv10aFY1lr+bSOSqhe+ZZPzAa0ho=;
        b=QsahwnbNPxFb8anWzK3WxNpQP/9E2LysXJkd2O6yn/eV1XYSoMo+Neam1GGr3F1pjo
         zXvy3JJSHLRwZl+7DnUhBhrIaOhZK0SzPIk5gUm06VcvppeLf3WclLuvBeD4kZUGJCL/
         +d2+h8gWnMwf8mY8eR70fzac8iq6uR0QXARAxyNdXzi8PoAeovoMgHpf/tAyN5F5kOtK
         1M6aV1V8EBX1J9B88+OfJo2RhvDJDp6czyf7Js/VGs+Ey4nPhkxtGZOVUSvsK9fTt62u
         a7ezHAU8xXnoVF5Wi3F5ijjJNDqFRyJIV9Ymi+LRbPlTyW14sXM6WguB40zcJ+SenwYq
         N8gQ==
Received: by 10.204.152.27 with SMTP id e27mr4905054bkw.56.1344887940521; Mon,
 13 Aug 2012 12:59:00 -0700 (PDT)
Received: by 10.204.132.72 with HTTP; Mon, 13 Aug 2012 12:58:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203357>

Hi all,

A colleague of mine (after a relatively long absence) noticed the
following when running "git status":

# On branch master
# Your branch and 'origin/master' have diverged,
# and have 250 and 19 different commit(s) each, respectively.
#
nothing to commit (working directory clean)

He asked me what to do and I told him to do what has always worked for
me in the past when something like this happened: gitk, "reset master
branch to here" (to a commit before the divergence and using --hard),
git pull origin master. Problem solved.

Well, not this one. This one is persistent. :-) I am at a loss what to
do. "master" and "origin/master" do *not* point at the same commit.
Even after the "git reset --hard ..." and "git pull". Running my
silver bullet solution gets us in the same situation every time.

I checked his .git/config and it looks fine.

Any ideas? What information should I provide that might make it
possible for you to help me?

Cheers,
Hilco
