From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: portability fix: don't use reserved word function
Date: Thu, 29 Mar 2007 11:44:19 -0400
Message-ID: <11751830651361-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <11751830653157-git-send-email-tytso@mit.edu> <1175183065710-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoJ-0004BP-Op
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbXC2Poj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXC2Poi
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:38 -0400
Received: from thunk.org ([69.25.196.29]:36597 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932478AbXC2Poa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:30 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwte-0007J3-QZ; Thu, 29 Mar 2007 11:50:43 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xe-GB; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <1175183065710-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43450>

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7d2dadd..8a87f5e 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -14,19 +14,19 @@ SUBDIRECTORY_OK=Yes
 require_work_tree
 
 # Returns true if the mode reflects a symlink
-function is_symlink () {
+is_symlink () {
     test "$1" = 120000
 }
 
-function local_present () {
+local_present () {
     test -n "$local_mode"
 }
 
-function remote_present () {
+remote_present () {
     test -n "$remote_mode"
 }
 
-function base_present () {
+base_present () {
     test -n "$base_mode"
 }
 
@@ -39,7 +39,7 @@ cleanup_temp_files () {
     fi
 }
 
-function describe_file () {
+describe_file () {
     mode="$1"
     branch="$2"
     file="$3"
-- 
1.5.1.rc2.1.g8afe-dirty
