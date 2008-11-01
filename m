From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] Fix error in diff_filepair::status documentation.
Date: Sat, 01 Nov 2008 23:03:14 +0100
Message-ID: <20081101220314.1116.79924.stgit@gandelf.nowhere.earth>
References: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 23:04:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwOaJ-0005Jz-Vx
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYKAWDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYKAWDc
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:03:32 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:53343 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbYKAWDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:03:32 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id F21CE1973D
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:30 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D8BA41973A
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:29 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id BC1D71F0C1
	for <git@vger.kernel.org>; Sat,  1 Nov 2008 23:03:14 +0100 (CET)
In-Reply-To: <20081101215739.1116.59319.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99779>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 diffcore.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diffcore.h b/diffcore.h
index 713cca7..05d0898 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -62,7 +62,7 @@ struct diff_filepair {
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	unsigned short int score;
-	char status; /* M C R N D U (see Documentation/diff-format.txt) */
+	char status; /* M C R A D U etc. (see DIFF_STATUS_* in diff.h) */
 	unsigned broken_pair : 1;
 	unsigned renamed_pair : 1;
 	unsigned is_unmerged : 1;
