From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: [StGit PATCH rev3] contrib/stgit-completion.bash: Remove add/applied/cp/rm/unapplied
Date: Sat, 06 Sep 2008 02:16:22 +0900
Message-ID: <48C16966.90009@ruby.dti.ne.jp>
References: <48B9A37B.4060001@ruby.dti.ne.jp> <48B9AE01.1010804@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Fri Sep 05 19:17:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbewI-0008Q8-1c
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 19:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbYIERQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbYIERQg
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 13:16:36 -0400
Received: from smtp14.dti.ne.jp ([202.216.231.189]:62923 "EHLO
	smtp14.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYIERQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 13:16:35 -0400
Received: from [192.168.1.3] (PPPa881.tokyo-ip.dti.ne.jp [210.159.215.131]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id m85HGN4N003273;Sat, 6 Sep 2008 02:16:25 +0900 (JST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <48B9AE01.1010804@ruby.dti.ne.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95025>

These commands are no longer available.

Signed-off-by: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
---

Shinya Kuribayashi wrote:
> > "stg add" was dropped several months ago.
> 
> Hm, I should have removed applied/unapplied entries also.

Sorry for the noise, again.  I've still missed `cp' and `rm', sigh.
Hope this one is finally get merged.  Thanks!

  Shinya

 contrib/stgit-completion.bash |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 1867e6b..1467c28 100644
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
@@ -20,7 +18,6 @@ _stg_commands="
     clone
     coalesce
     commit
-    cp
     edit
     export
     files
@@ -44,14 +41,12 @@ _stg_commands="
     rename
     repair
     resolved
-    rm
     series
     show
     sink
     status
     sync
     top
-    unapplied
     uncommit
     unhide
 "
@@ -264,8 +259,6 @@ _stg ()
         # working-copy commands
         diff)   _stg_patches_options $command _applied_patches "-r --range" ;;
 	resolved) _complete_files $command "$(_conflicting_files)" ;;
-	add)	_complete_files $command "$(_unknown_files)" ;;
-#	rm)	_complete_files $command "$(_known_files)" ;;
 	# commands that usually raher accept branches
 	branch) _complete_branch $command _all_branches ;;
 	rebase) _complete_branch $command _all_branches ;;
