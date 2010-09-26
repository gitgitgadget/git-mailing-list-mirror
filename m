From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 10/15] t6016 (rev-list-graph-simplify-history): add missing &&
Date: Sun, 26 Sep 2010 17:14:34 -0600
Message-ID: <1285542879-16381-11-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Px-0005ch-Mm
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758363Ab0IZXN1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:27 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:45170 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308Ab0IZXNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:24 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1218934pxi.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3x1uCqcrXYeJJnywk0zp7B3cJWFk9h1loQpiyh4Z1x4=;
        b=coypVlDOpZTne00QTtqRPD1dkdGpvEpOBt2K748a3kC+7IQDJzhDsu3Gob/rANgi10
         pcKTxi19evPvJTTkziN6AAv0wK2RDTc4YSOooIQmdwo/A2g7RW3qdxF/H5NILBHsOX5Z
         /CN/eDZ90FoBzBIatbRufiH28kzSo8gEgKMh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=DkF69XCCYPPPoOz+RoSDaVRI3NG6Sqa3hp77loTd70Me6cdsecr9YHPv3YIbej4pF+
         wcB8bilqSX8cmlNYGaoV3y/tW/IfyCKLwPm1jTK1MS83lPZPZ9nGRhUnNO1xZ3Pgml1T
         yF567Q3uV0ksBIda7+xXhPJIfH1V7HD9pYvtQ=
Received: by 10.114.78.11 with SMTP id a11mr7376868wab.4.1285542803783;
        Sun, 26 Sep 2010 16:13:23 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157277>

Also removed several repeated tag and branch deletions, since the tags =
and
branches had already been deleted.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6016-rev-list-graph-simplify-history.sh |   24 ++++++--------------=
----
 1 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-l=
ist-graph-simplify-history.sh
index 27fd52b..e640c41 100755
--- a/t/t6016-rev-list-graph-simplify-history.sh
+++ b/t/t6016-rev-list-graph-simplify-history.sh
@@ -29,7 +29,7 @@ test_expect_success 'set up rev-list --graph test' '
 	# Octopus merge B and C into branch A
 	git checkout A &&
 	git merge B C &&
-	git tag A4
+	git tag A4 &&
=20
 	test_commit A5 bar.txt &&
=20
@@ -39,7 +39,7 @@ test_expect_success 'set up rev-list --graph test' '
 	test_commit C4 bar.txt &&
 	git checkout A &&
 	git merge -s ours C &&
-	git tag A6
+	git tag A6 &&
=20
 	test_commit A7 bar.txt &&
=20
@@ -90,7 +90,7 @@ test_expect_success '--graph --all' '
 # that undecorated merges are interesting, even with --simplify-by-dec=
oration
 test_expect_success '--graph --simplify-by-decoration' '
 	rm -f expected &&
-	git tag -d A4
+	git tag -d A4 &&
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -119,9 +119,9 @@ test_expect_success '--graph --simplify-by-decorati=
on' '
 # Get rid of all decorations on branch B, and graph with it simplified=
 away
 test_expect_success '--graph --simplify-by-decoration prune branch B' =
'
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
+	git tag -d B2 &&
+	git tag -d B1 &&
+	git branch -d B &&
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -143,9 +143,6 @@ test_expect_success '--graph --simplify-by-decorati=
on prune branch B' '
=20
 test_expect_success '--graph --full-history -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -163,9 +160,6 @@ test_expect_success '--graph --full-history -- bar.=
txt' '
=20
 test_expect_success '--graph --full-history --simplify-merges -- bar.t=
xt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "*   $A6" >> expected &&
 	echo "|\\  " >> expected &&
@@ -181,9 +175,6 @@ test_expect_success '--graph --full-history --simpl=
ify-merges -- bar.txt' '
=20
 test_expect_success '--graph -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "* $A5" >> expected &&
 	echo "* $A3" >> expected &&
@@ -196,9 +187,6 @@ test_expect_success '--graph -- bar.txt' '
=20
 test_expect_success '--graph --sparse -- bar.txt' '
 	rm -f expected &&
-	git tag -d B2
-	git tag -d B1
-	git branch -d B
 	echo "* $A7" >> expected &&
 	echo "* $A6" >> expected &&
 	echo "* $A5" >> expected &&
--=20
1.7.3.95.g14291
