From: "Benjamin Sandeen" <benjaminsandeen2016@u.northwestern.edu>
Subject: Bug Report
Date: Sat, 2 Apr 2016 19:25:17 -0500
Message-ID: <04bf01d18d3f$4ce38410$e6aa8c30$@u.northwestern.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 03 02:24:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amVqB-0005mv-IM
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 02:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbcDCAYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 20:24:11 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33124 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbcDCAYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 20:24:10 -0400
Received: by mail-ig0-f169.google.com with SMTP id ma7so40924786igc.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=Q8XgL5++meRVI+00UtdEfqAUmBc5k6n87+Hn5DSiARs=;
        b=uZEi9vTrOjuHf9qRf2asyYShgl4o7HndB4HfqTfHfGpYEfucerO+W1WHmaztEDQ9Ur
         Sy2CXhLfryW45B9I266xTpKJujmKDcqsxmOnTn7ZNMbIIdQJjaxZ9HULlrV0a4D2lZW5
         e01NOD05u63/Os1AwX4X6CsQVPoy1HS0iY4drEwPqR6JA7iO1rZ9K1DHyibUtby2341O
         gUMQhr1LDs4x6/ZTXfapJEPuT7zeKdWqqVCqMwMo3eV5wFcssPdDobSmcVVVxWNeheg9
         SsE1X148Um2gxfpxY3aahS0WYdBtLIElK/8U0T2jCQgZQmnJHK1bl+vUdG8hnfHmCYiF
         RWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=Q8XgL5++meRVI+00UtdEfqAUmBc5k6n87+Hn5DSiARs=;
        b=LTsKkrzjvlx+1Aw5SIY5ecNZfk3QMYixg6bU3tp0G1yaM8XFX//PQ3XIsgqPmR2MSJ
         LHTjs60Opl1udhsUqWjwG/Io7XlfArgFpq06RXjX5tlTdjBjn3GB7qKFy+UcnT/COGBe
         WP5XSJGn67Zoad8OI+9SqQyJz0MNYOU+0YoZ/qZ/FeapG9lWFG07W2EQIWqdx/shlYlI
         bH5HLNVqa7vWcqMfU0KEiOw50aqNB655qpVH9UWd1y9nGGqzq9o0qhUNw0/Pll3aYubm
         8Lnu0FYqqu3WVbU9O21H+aZRalVg/DqZDQqHY26a3e+njkCI0qO59Ye2SrRCwXyk1qZA
         DJpg==
X-Gm-Message-State: AD7BkJLtA21AvzG+kS+eAi/XYVBKYcJjGD6HRNR9nMw5zHALjf7XvrPTouqLPzCUiRVRffnE
X-Received: by 10.107.19.42 with SMTP id b42mr13410753ioj.75.1459643050099;
        Sat, 02 Apr 2016 17:24:10 -0700 (PDT)
Received: from Sparta (dhcp-199-74-103-76.res-hall.northwestern.edu. [199.74.103.76])
        by smtp.gmail.com with ESMTPSA id v100sm3078956ioi.23.2016.04.02.17.24.09
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Apr 2016 17:24:09 -0700 (PDT)
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdGNPz+uqeg3lH5yQZ68UNVJAoYXjA==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290618>

Today, I managed to create a duplicate branch in a git repository.  While
this may not be a bug per se, I do think that it is confusing and some way
of preventing such issues in the future may be helpful.

I first cloned the repository:

$ git clone https://github.com/CodeForChicago/superclass.git

Then, I created a new branch (or so I thought):

$ git checkout -b lesson_page

However, this branch has already existed for about 4 weeks, without my
knowledge.  I proceeded to do some work on the files it contained, and when
it came time to commit and push, and when I pushed, I got the following
message:

To https://github.com/CodeForChicago/superclass.git
 ! [rejected]        lesson_page -> lesson_page (non-fast-forward)
error: failed to push some refs to '
https://github.com/CodeForChicago/superclass.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.

Given that I had believed that I had created the branch just a few hours
prior and was the first to attempt to push to it, this error was
consternating.

I may be wrong (I am aware that my understanding of git is limited), but I
believe that the git checkout -b command is simply supposed to create a new
branch and then switch to it (I'm not aware of any subtle behavior that goes
on behind the scenes if the "new" branch that the user is attempting to
create already exists).  This is why I said it "may not be a bug per se".
However, I expect most people who use git to expect this command to create a
new branch and then switch to it (this is what most sources online will tell
users to do to create a new branch), and as such, it would be extremely
beneficial if git were to, at the very least, alert the user to the conflict
in some way or another.

Thanks,
Ben

Lead Consultant, Northwestern University Information Technology
Research Assistant, Center for Interdisciplinary Exploration and Research in
Astrophysics at Northwestern University
Phsyics, Weinberg College of Arts and Sciences
Computer Science, Weinberg College of Arts and Sciences
Classics, Weinberg College of Arts and Sciences
