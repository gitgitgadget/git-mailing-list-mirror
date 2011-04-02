From: Laszlo Papp <djszapi@archlinux.us>
Subject: git commit fails under some circumstances
Date: Sat, 2 Apr 2011 17:18:54 +0200
Message-ID: <AANLkTikHRM10p9e8XCzuiih7cYtQRG7Az2Qn5qtPzhZJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 17:19:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q62ba-0005iA-Kp
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 17:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab1DBPS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 11:18:56 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50735 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab1DBPSz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 11:18:55 -0400
Received: by qyg14 with SMTP id 14so3015439qyg.19
        for <git@vger.kernel.org>; Sat, 02 Apr 2011 08:18:54 -0700 (PDT)
Received: by 10.229.76.205 with SMTP id d13mr4559927qck.133.1301757534722;
 Sat, 02 Apr 2011 08:18:54 -0700 (PDT)
Received: by 10.229.214.209 with HTTP; Sat, 2 Apr 2011 08:18:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170651>

Hi,

There are 2 bugs and 1 wish in this case:
1) It says "Changes to be committed:", but they are actually not
committed, there cannot even be committed since they were not added
"properly". This output is bogus
2) error: Error building trees
---
3) It would be nice to have one command (with no (git) alias for sure)
to see the difference like "git diff" but also the new files.

Best Regards,
Laszlo Papp

========

root /home/djszapi/Projects/kde/attica/build #  git add -N
../lib/achievement.cpp ../lib/achievement.h
../lib/achievementparser.cpp ../lib/achievementparser.h
root /home/djszapi/Projects/kde/attica/build #  git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   ../lib/achievement.cpp
#       new file:   ../lib/achievement.h
#       new file:   ../lib/achievementparser.cpp
#       new file:   ../lib/achievementparser.h
#
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   ../lib/CMakeLists.txt
#       modified:   ../lib/achievement.cpp
#       modified:   ../lib/achievement.h
#       modified:   ../lib/achievementparser.cpp
#       modified:   ../lib/achievementparser.h
#       modified:   ../lib/listjob_inst.cpp
#       modified:   ../lib/provider.cpp
#       modified:   ../lib/provider.h
#       modified:   ../lib/providermanager.cpp
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       ./
root /home/djszapi/Projects/kde/attica/build #  gc
lib/achievement.cpp: not added yet
lib/achievement.h: not added yet
lib/achievementparser.cpp: not added yet
lib/achievementparser.h: not added yet
error: Error building trees
root /home/djszapi/Projects/kde/attica/build #  alias gc
alias gc='git commit --author="Laszlo Papp <djszapi@archlinux.us>"'
root /home/djszapi/Projects/kde/attica/build
