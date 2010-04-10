From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] guilt: Add support for git version 1.7.x.y
Date: Sat, 10 Apr 2010 10:10:31 -0400
Message-ID: <1270908631-5263-1-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Sat Apr 10 16:11:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0bOk-00008D-DH
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab0DJOKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:10:42 -0400
Received: from smtp-out.google.com ([74.125.121.35]:17289 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab0DJOKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:10:41 -0400
Received: from hpaq14.eem.corp.google.com (hpaq14.eem.corp.google.com [10.3.21.14])
	by smtp-out.google.com with ESMTP id o3AEAY7Y000820;
	Sat, 10 Apr 2010 16:10:35 +0200
Received: from tsx-11.cam.corp.google.com (tsx-11.cam.corp.google.com [172.31.196.108])
	by hpaq14.eem.corp.google.com with ESMTP id o3AEAW4M023680;
	Sat, 10 Apr 2010 16:10:32 +0200
Received: by tsx-11.cam.corp.google.com (Postfix, from userid 102944)
	id EA89211C443; Sat, 10 Apr 2010 10:10:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.1
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144549>

The regression tests pass, so let's add support for
git 1.7.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/guilt b/guilt
index 485710b..43fea8e 100755
--- a/guilt
+++ b/guilt
@@ -32,6 +32,7 @@ gitver=`git --version | cut -d' ' -f3 | sed -e 's/^debian\.//'`
 case "$gitver" in
 	1.5.*)	;; # git config
 	1.6.*)	;; # git config
+	1.7.*)	;; # git config
 	*)	die "Unsupported version of git ($gitver)" ;;
 esac
 
-- 
1.7.0.1
