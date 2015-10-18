From: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
Subject: git worktree help inconsistent
Date: Sun, 18 Oct 2015 12:10:52 +0800
Message-ID: <CAHtLG6S6VZLRhqEzHF6Qt+-NnqT3M_Spnk7UbRo1jxDb8NUGoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 18 06:11:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnfJF-0007Pd-JP
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 06:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbbJREKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 00:10:55 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33268 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932746AbbJREKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 00:10:53 -0400
Received: by vkaw128 with SMTP id w128so88219056vka.0
        for <git@vger.kernel.org>; Sat, 17 Oct 2015 21:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=f8BNkoo+ofXSM1t9aRKHNASwYZclzguriptANGCa5as=;
        b=ekU4KpMrpQqAHR56VerhHZkJA7xRkHs+XrA1jl9U/z9AVHdZm//qcT3d+vN2mUjJbn
         UF/cmCK411GZ0F8z6MdVCunZDFN61vWQoSeEY/P2EyAivWr8VVQyvKNACq1UVcNAk8Ob
         TmorG1Tlyj3PrqHxLIpbtK2O8xIE6X+2O1kNmJ3hJAOwu21LdmTOob6yqiIZAtB8Pv0M
         t15WXv8m1xZSQxCbcA3WT+hS/R5NMkdVsW2VV+M9RbtZRCFUhI9DEk0LEl7upxr05puu
         QAPMXx+WnBIXQXmXjnNs1Sx4Ylt9ewZ87HgI57cjfALzl5WEDI+EgVWtnGdU64KAsf3e
         xh9w==
X-Received: by 10.31.159.208 with SMTP id i199mr7574589vke.74.1445141452684;
 Sat, 17 Oct 2015 21:10:52 -0700 (PDT)
Received: by 10.31.9.133 with HTTP; Sat, 17 Oct 2015 21:10:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279799>

Using git 2.6.1

In git command line usage, Please mark <branch> optional, the man page
is correct.

$ git worktree add
usage: git worktree add [<options>] <path> <branch>
   or: git worktree prune [<options>]

    -f, --force           checkout <branch> even if already checked
out in other worktree
    -b <branch>           create a new branch
    -B <branch>           create or reset a branch
    --detach              detach HEAD at named commit

But in man page,
git worktree add [-f] [--detach] [-b <new-branch>] <path> [<branch>]
git worktree prune [-n] [-v] [--expire <expire>]
