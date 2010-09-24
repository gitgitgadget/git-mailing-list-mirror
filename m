From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/24] t9300 (fast-import): use tabs to indent
Date: Fri, 24 Sep 2010 02:13:50 -0500
Message-ID: <20100924071350.GH4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2WR-0007Kj-B5
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698Ab0IXHQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:16:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:32903 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0IXHQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:16:37 -0400
Received: by iwn5 with SMTP id 5so2158220iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6Gb9x8RbHCM10H3384s7DgXxidl/anIaVLiBmo+IvFo=;
        b=u9pXd82mGQXiPthYP9ZI8e8N331Btuaofr+6BQrMJCha/IWWqFwFzL7Ux9kf7qWlte
         DRipTWqBLTvE6CWyqPpwqXE8P3gBl7JKCRWBWQwTBa/nLT2Kk6YrTSXkY5gfMRmEdiES
         shT6YVOnyxBWQZHl9VRFsZ+1XYWOfGSWvKSGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=u71pdmG+Cb6qWqs60DDPbFNywfbye6Ffk0JwfGgkDw95kRpEBYHwM94hK45yNWNAR8
         m3T7pOpykcXokmM9psakL94RGjmIVtrzuqrjWFj6ltMMxYc0/aGXY4obm6Iv84/jeKGp
         m1uRLEWNqCuKBpI5MX337kWzNqZnOJjJ3kwIc=
Received: by 10.231.16.204 with SMTP id p12mr2765946iba.194.1285312596742;
        Fri, 24 Sep 2010 00:16:36 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm1947120ibe.23.2010.09.24.00.16.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:16:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156941>

The test script mostly uses tabs to indent, but some 4-space indents
snuck in.

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |  118 ++++++++++++++++++++++++------------------------
 1 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 8d418e4..0059298 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -82,8 +82,8 @@ EOF
 
 INPUT_END
 test_expect_success \
-    'A: create pack from stdin' \
-    'git fast-import --export-marks=marks.out <input &&
+	'A: create pack from stdin' \
+	'git fast-import --export-marks=marks.out <input &&
 	 git whatchanged master'
 test_expect_success \
 	'A: verify pack' \
@@ -272,7 +272,7 @@ M 755 0000000000000000000000000000000000000001 zero1
 
 INPUT_END
 test_expect_success 'B: fail on invalid blob sha1' '
-    test_must_fail git fast-import <input
+	test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -287,7 +287,7 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success 'B: fail on invalid branch name ".badbranchname"' '
-    test_must_fail git fast-import <input
+	test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -302,7 +302,7 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success 'B: fail on invalid branch name "bad[branch]name"' '
-    test_must_fail git fast-import <input
+	test_must_fail git fast-import <input
 '
 rm -f .git/objects/pack_* .git/objects/index_*
 
@@ -317,8 +317,8 @@ from refs/heads/master
 
 INPUT_END
 test_expect_success \
-    'B: accept branch name "TEMP_TAG"' \
-    'git fast-import <input &&
+	'B: accept branch name "TEMP_TAG"' \
+	'git fast-import <input &&
 	 test -f .git/TEMP_TAG &&
 	 test `git rev-parse master` = `git rev-parse TEMP_TAG^`'
 rm -f .git/TEMP_TAG
@@ -344,8 +344,8 @@ D file3
 
 INPUT_END
 test_expect_success \
-    'C: incremental import create pack from stdin' \
-    'git fast-import <input &&
+	'C: incremental import create pack from stdin' \
+	'git fast-import <input &&
 	 git whatchanged branch'
 test_expect_success \
 	'C: verify pack' \
@@ -402,8 +402,8 @@ EOF
 
 INPUT_END
 test_expect_success \
-    'D: inline data in commit' \
-    'git fast-import <input &&
+	'D: inline data in commit' \
+	'git fast-import <input &&
 	 git whatchanged branch'
 test_expect_success \
 	'D: verify pack' \
@@ -446,11 +446,11 @@ from refs/heads/branch^0
 
 INPUT_END
 test_expect_success 'E: rfc2822 date, --date-format=raw' '
-    test_must_fail git fast-import --date-format=raw <input
+	test_must_fail git fast-import --date-format=raw <input
 '
 test_expect_success \
-    'E: rfc2822 date, --date-format=rfc2822' \
-    'git fast-import --date-format=rfc2822 <input'
+	'E: rfc2822 date, --date-format=rfc2822' \
+	'git fast-import --date-format=rfc2822 <input'
 test_expect_success \
 	'E: verify pack' \
 	'verify_packs'
@@ -486,8 +486,8 @@ from refs/heads/branch
 
 INPUT_END
 test_expect_success \
-    'F: non-fast-forward update skips' \
-    'if git fast-import <input
+	'F: non-fast-forward update skips' \
+	'if git fast-import <input
 	 then
 		echo BAD gfi did not fail
 		return 1
@@ -536,8 +536,8 @@ from refs/heads/branch~1
 
 INPUT_END
 test_expect_success \
-    'G: non-fast-forward update forced' \
-    'git fast-import --force <input'
+	'G: non-fast-forward update forced' \
+	'git fast-import --force <input'
 test_expect_success \
 	'G: verify pack' \
 	'verify_packs'
@@ -572,8 +572,8 @@ EOF
 
 INPUT_END
 test_expect_success \
-    'H: deletall, add 1' \
-    'git fast-import <input &&
+	'H: deletall, add 1' \
+	'git fast-import <input &&
 	 git whatchanged H'
 test_expect_success \
 	'H: verify pack' \
@@ -612,8 +612,8 @@ from refs/heads/branch
 
 INPUT_END
 test_expect_success \
-    'I: export-pack-edges' \
-    'git fast-import --export-pack-edges=edges.list <input'
+	'I: export-pack-edges' \
+	'git fast-import --export-pack-edges=edges.list <input'
 
 cat >expect <<EOF
 .git/objects/pack/pack-.pack: `git rev-parse --verify export-boundary`
@@ -646,8 +646,8 @@ COMMIT
 
 INPUT_END
 test_expect_success \
-    'J: reset existing branch creates empty commit' \
-    'git fast-import <input'
+	'J: reset existing branch creates empty commit' \
+	'git fast-import <input'
 test_expect_success \
 	'J: branch has 1 commit, empty tree' \
 	'test 1 = `git rev-list J | wc -l` &&
@@ -676,12 +676,12 @@ from refs/heads/branch^1
 
 INPUT_END
 test_expect_success \
-    'K: reinit branch with from' \
-    'git fast-import <input'
+	'K: reinit branch with from' \
+	'git fast-import <input'
 test_expect_success \
-    'K: verify K^1 = branch^1' \
-    'test `git rev-parse --verify branch^1` \
-		= `git rev-parse --verify K^1`'
+	'K: verify K^1 = branch^1' \
+	'test `git rev-parse --verify branch^1` \
+	    = `git rev-parse --verify K^1`'
 
 ###
 ### series L
@@ -751,7 +751,7 @@ cat >expect <<EXPECT_END
 EXPECT_END
 
 test_expect_success \
-    'L: verify internal tree sorting' \
+	'L: verify internal tree sorting' \
 	'git fast-import <input &&
 	 git diff-tree L^ L >output &&
 	 test_cmp expect output'
@@ -1227,7 +1227,7 @@ DATA
 INPUT_END
 
 test_expect_success 'P: fail on inline gitlink' '
-    test_must_fail git fast-import <input'
+	test_must_fail git fast-import <input'
 
 test_tick
 cat >input <<INPUT_END
@@ -1250,7 +1250,7 @@ M 160000 :1 sub
 INPUT_END
 
 test_expect_success 'P: fail on blob mark in gitlink' '
-    test_must_fail git fast-import <input'
+	test_must_fail git fast-import <input'
 
 ###
 ### series Q (notes)
@@ -1598,14 +1598,14 @@ hi
 EOF
 
 test_expect_success \
-    'R: export-marks feature results in a marks file being created' \
-    'cat input | git fast-import &&
-    grep :1 git.marks'
+	'R: export-marks feature results in a marks file being created' \
+	'cat input | git fast-import &&
+	grep :1 git.marks'
 
 test_expect_success \
-    'R: export-marks options can be overriden by commandline options' \
-    'cat input | git fast-import --export-marks=other.marks &&
-    grep :1 other.marks'
+	'R: export-marks options can be overriden by commandline options' \
+	'cat input | git fast-import --export-marks=other.marks &&
+	grep :1 other.marks'
 
 cat >input << EOF
 feature import-marks=marks.out
@@ -1613,9 +1613,9 @@ feature export-marks=marks.new
 EOF
 
 test_expect_success \
-    'R: import to output marks works without any content' \
-    'cat input | git fast-import &&
-    test_cmp marks.out marks.new'
+	'R: import to output marks works without any content' \
+	'cat input | git fast-import &&
+	test_cmp marks.out marks.new'
 
 cat >input <<EOF
 feature import-marks=nonexistant.marks
@@ -1623,9 +1623,9 @@ feature export-marks=marks.new
 EOF
 
 test_expect_success \
-    'R: import marks prefers commandline marks file over the stream' \
-    'cat input | git fast-import --import-marks=marks.out &&
-    test_cmp marks.out marks.new'
+	'R: import marks prefers commandline marks file over the stream' \
+	'cat input | git fast-import --import-marks=marks.out &&
+	test_cmp marks.out marks.new'
 
 
 cat >input <<EOF
@@ -1634,10 +1634,10 @@ feature export-marks=combined.marks
 EOF
 
 test_expect_success 'R: multiple --import-marks= should be honoured' '
-    head -n2 marks.out > one.marks &&
-    tail -n +3 marks.out > two.marks &&
-    git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
-    test_cmp marks.out combined.marks
+	head -n2 marks.out > one.marks &&
+	tail -n +3 marks.out > two.marks &&
+	git fast-import --import-marks=one.marks --import-marks=two.marks <input &&
+	test_cmp marks.out combined.marks
 '
 
 cat >input <<EOF
@@ -1647,10 +1647,10 @@ feature export-marks=relative.out
 EOF
 
 test_expect_success 'R: feature relative-marks should be honoured' '
-    mkdir -p .git/info/fast-import/ &&
-    cp marks.new .git/info/fast-import/relative.in &&
-    git fast-import <input &&
-    test_cmp marks.new .git/info/fast-import/relative.out
+	mkdir -p .git/info/fast-import/ &&
+	cp marks.new .git/info/fast-import/relative.in &&
+	git fast-import <input &&
+	test_cmp marks.new .git/info/fast-import/relative.out
 '
 
 cat >input <<EOF
@@ -1661,8 +1661,8 @@ feature export-marks=non-relative.out
 EOF
 
 test_expect_success 'R: feature no-relative-marks should be honoured' '
-    git fast-import <input &&
-    test_cmp marks.new non-relative.out
+	git fast-import <input &&
+	test_cmp marks.new non-relative.out
 '
 
 cat >input << EOF
@@ -1676,8 +1676,8 @@ EOF
 touch empty
 
 test_expect_success 'R: quiet option results in no stats being output' '
-    cat input | git fast-import 2> output &&
-    test_cmp empty output
+	cat input | git fast-import 2> output &&
+	test_cmp empty output
 '
 
 cat >input <<EOF
@@ -1685,11 +1685,11 @@ option git non-existing-option
 EOF
 
 test_expect_success 'R: die on unknown option' '
-    test_must_fail git fast-import <input
+	test_must_fail git fast-import <input
 '
 
 test_expect_success 'R: unknown commandline options are rejected' '\
-    test_must_fail git fast-import --non-existing-option < /dev/null
+	test_must_fail git fast-import --non-existing-option < /dev/null
 '
 
 cat >input <<EOF
@@ -1697,7 +1697,7 @@ option non-existing-vcs non-existing-option
 EOF
 
 test_expect_success 'R: ignore non-git options' '
-    git fast-import <input
+	git fast-import <input
 '
 
 ##
-- 
1.7.2.3
