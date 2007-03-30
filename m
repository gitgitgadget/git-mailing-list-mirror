From: Jeff King <peff@peff.net>
Subject: [PATCH] git-mergetool: de-bashify function declarations
Date: Thu, 29 Mar 2007 23:26:45 -0400
Message-ID: <20070330032645.GA6876@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 05:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX7lZ-0001dp-Ty
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 05:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbXC3D0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 23:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbXC3D0s
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 23:26:48 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1768 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812AbXC3D0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 23:26:47 -0400
Received: (qmail 21089 invoked from network); 30 Mar 2007 03:27:18 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 30 Mar 2007 03:27:18 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Mar 2007 23:26:45 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43492>


Signed-off-by: Jeff King <peff@peff.net>
---
Works fine otherwise for me using dash as /bin/sh...

 git-mergetool.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 7942fd0..68b35d3 100755
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
1.5.1.rc2.638.g85e08-dirty
