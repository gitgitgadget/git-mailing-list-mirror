From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: portability fix: don't assume true is in /bin
Date: Thu, 29 Mar 2007 11:44:18 -0400
Message-ID: <1175183065710-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <11751830653157-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwnj-0003tu-KG
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbXC2Poc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXC2Poc
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:32 -0400
Received: from thunk.org ([69.25.196.29]:36584 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932465AbXC2Po3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:29 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwtd-0007J2-Se; Thu, 29 Mar 2007 11:50:42 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xb-FV; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830653157-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43443>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9d959a9..7d2dadd 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -63,7 +63,7 @@ function describe_file () {
 
 
 resolve_symlink_merge () {
-    while /bin/true; do
+    while true; do
 	printf "Use (r)emote or (l)ocal, or (a)bort? "
 	read ans
 	case "$ans" in
@@ -87,7 +87,7 @@ resolve_symlink_merge () {
 }
 
 resolve_deleted_merge () {
-    while /bin/true; do
+    while true; do
 	printf "Use (m)odified or (d)eleted file, or (a)bort? "
 	read ans
 	case "$ans" in
-- 
1.5.1.rc2.1.g8afe-dirty
