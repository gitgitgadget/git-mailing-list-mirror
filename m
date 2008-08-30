From: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
Subject: [StGit PATCH] Remove 'add' command entries from stgit-completion.bash
Date: Sun, 31 Aug 2008 04:46:03 +0900
Message-ID: <48B9A37B.4060001@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Aug 30 22:07:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWid-0001J1-SE
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbYH3UFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbYH3UFm
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:05:42 -0400
Received: from smtp14.dti.ne.jp ([202.216.231.189]:45894 "EHLO
	smtp14.dti.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbYH3UFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:05:42 -0400
X-Greylist: delayed 1174 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Aug 2008 16:05:41 EDT
Received: from [192.168.1.3] (PPPa881.tokyo-ip.dti.ne.jp [210.159.215.131]) by smtp14.dti.ne.jp (3.11s) with ESMTP AUTH id m7UJk43V025199;Sun, 31 Aug 2008 04:46:04 +0900 (JST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94413>

"stg add" was dropped several months ago.

Signed-off-by: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
---
contrib/stgit-completion.bash |    2 --
1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 1867e6b..a25a603 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -11,7 +11,6 @@
#         . ~/.stgit-completion.bash

_stg_commands="
-    add
    applied
    branch
    delete
@@ -264,7 +263,6 @@ _stg ()
        # working-copy commands
        diff)   _stg_patches_options $command _applied_patches "-r --range" ;;
	resolved) _complete_files $command "$(_conflicting_files)" ;;
-	add)	_complete_files $command "$(_unknown_files)" ;;
#	rm)	_complete_files $command "$(_known_files)" ;;
	# commands that usually raher accept branches
	branch) _complete_branch $command _all_branches ;;
