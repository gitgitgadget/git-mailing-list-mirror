From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: [StGit PATCH revised] Remove add/applied/unapplied bash completion
 entries
Date: Sun, 31 Aug 2008 05:30:57 +0900
Message-ID: <48B9AE01.1010804@ruby.dti.ne.jp>
References: <48B9A37B.4060001@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 30 22:32:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZX7E-00071q-ST
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbYH3UbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753827AbYH3UbG
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:31:06 -0400
Received: from smtp14.dti.ne.jp ([202.216.231.189]:45919 "EHLO
	smtp14.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYH3UbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:31:05 -0400
Received: from [192.168.1.3] (PPPa881.tokyo-ip.dti.ne.jp [210.159.215.131]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id m7UKUwZf025604;Sun, 31 Aug 2008 05:31:01 +0900 (JST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48B9A37B.4060001@ruby.dti.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94418>

These commands are not available any more.

Signed-off-by: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
---
Shinya Kuribayashi wrote:
> "stg add" was dropped several months ago.

Hm, I should have removed applied/unapplied entries also.

thanks,

  Shinya

 contrib/stgit-completion.bash |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 1867e6b..ac868e7 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -11,8 +11,6 @@
 #         . ~/.stgit-completion.bash
 
 _stg_commands="
-    add
-    applied
     branch
     delete
     diff
@@ -51,7 +49,6 @@ _stg_commands="
     status
     sync
     top
-    unapplied
     uncommit
     unhide
 "
@@ -264,7 +261,6 @@ _stg ()
         # working-copy commands
         diff)   _stg_patches_options $command _applied_patches "-r --range" ;;
 	resolved) _complete_files $command "$(_conflicting_files)" ;;
-	add)	_complete_files $command "$(_unknown_files)" ;;
 #	rm)	_complete_files $command "$(_known_files)" ;;
 	# commands that usually raher accept branches
 	branch) _complete_branch $command _all_branches ;;
