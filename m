From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] gitweb: fix spelling errors in comments
Date: Sun, 27 Sep 2009 01:32:33 +0200
Message-ID: <1254007953-1961-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 01:35:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrgnq-0006SG-1v
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 01:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbZIZXb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 19:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZIZXbz
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 19:31:55 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:56897 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbZIZXbz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 19:31:55 -0400
Received: from vmobile.example.net (catv-89-134-193-228.catv.broadband.hu [89.134.193.228])
	by yugo.frugalware.org (Postfix) with ESMTPA id D82661A405
	for <git@vger.kernel.org>; Sun, 27 Sep 2009 01:31:58 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 77E06183FAE; Sun, 27 Sep 2009 01:32:34 +0200 (CEST)
X-Mailer: git-send-email 1.6.5.rc1.44.ga1675.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129187>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 gitweb/gitweb.perl |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

The plural form of "id" is "ids", not "id's", right?

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..b66c4d0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4949,7 +4949,7 @@ sub git_blob_plain {
 			die_error(400, "No file name defined");
 		}
 	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		# blobs defined by non-textual hash id's can be cached
+		# blobs defined by non-textual hash ids can be cached
 		$expires = "+1d";
 	}
 
@@ -5001,7 +5001,7 @@ sub git_blob {
 			die_error(400, "No file name defined");
 		}
 	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		# blobs defined by non-textual hash id's can be cached
+		# blobs defined by non-textual hash ids can be cached
 		$expires = "+1d";
 	}
 
@@ -5346,7 +5346,7 @@ sub git_commit {
 	@difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(404, "Reading git-diff-tree failed");
 
-	# non-textual hash id's can be cached
+	# non-textual hash ids can be cached
 	my $expires;
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		$expires = "+1d";
@@ -5513,7 +5513,7 @@ sub git_blobdiff {
 		$hash_parent ||= $diffinfo{'from_id'};
 		$hash        ||= $diffinfo{'to_id'};
 
-		# non-textual hash id's can be cached
+		# non-textual hash ids can be cached
 		if ($hash_base =~ m/^[0-9a-fA-F]{40}$/ &&
 		    $hash_parent_base =~ m/^[0-9a-fA-F]{40}$/) {
 			$expires = '+1d';
@@ -5733,7 +5733,7 @@ sub git_commitdiff {
 		die_error(400, "Unknown commitdiff format");
 	}
 
-	# non-textual hash id's can be cached
+	# non-textual hash ids can be cached
 	my $expires;
 	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		$expires = "+1d";
-- 
1.6.5.rc1.44.ga1675.dirty
