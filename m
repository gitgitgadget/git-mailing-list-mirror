From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 24/24] t9300 (fast-import), series R: re-indent
Date: Fri, 24 Sep 2010 02:30:06 -0500
Message-ID: <20100924073006.GY4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2mS-00051F-5H
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab0IXHcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:32:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59974 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab0IXHcy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:32:54 -0400
Received: by iwn5 with SMTP id 5so2169260iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6Q/iGu9F88XxvpxTOSfpws0AMFXUoRW6IOtfpG6+p5A=;
        b=C2P8QEbenRhUIMloaP8FuroLBU31ByS+RG3aK94m4v812QU7eZEcZ9dBNTw7xgG1I5
         Rbx+FuLDv5GXOPHsyFiH7q6tKYTyOJEo83wLhzjjwX67ygiaVbX2RqwVX1dG1Af2kCZ7
         GR7xtb20vD8x0MIuBX/5go9eR2QX+FVN9C0DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yGGoocLmQZr7BENxJX8/G2Pk07mVV8NqJyAb3CHVRGJHeykIpbPgPU6QXdKsTIskhZ
         ZPIJpI9/FwYvduU7rFMm+dAs+N2fMpvshoD9XTBOrVvsKWF80oaIutg6ww3mjYHft+w3
         8OVLGRRhPnkysUk3Iof1vcG/2rH9yhh1yvUZc=
Received: by 10.231.145.16 with SMTP id b16mr3307888ibv.198.1285313573237;
        Fri, 24 Sep 2010 00:32:53 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm1968079ibh.22.2010.09.24.00.32.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:32:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156960>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
That's all for now.  Sorry for the dull read.

Be seeing you,
Jonathan

 t/t9300-fast-import.sh |   72 ++++++++++++++++++++++++------------------------
 1 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 970f594..6c629b4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1609,35 +1609,35 @@ hi
 
 EOF
 
-test_expect_success \
-	'R: export-marks feature results in a marks file being created' \
-	'cat input | git fast-import &&
-	grep :1 git.marks'
+test_expect_success 'R: export-marks feature results in a marks file being created' '
+	cat input | git fast-import &&
+	grep :1 git.marks
+'
 
-test_expect_success \
-	'R: export-marks options can be overriden by commandline options' \
-	'cat input | git fast-import --export-marks=other.marks &&
-	grep :1 other.marks'
+test_expect_success 'R: export-marks options can be overriden by commandline options' '
+	cat input | git fast-import --export-marks=other.marks &&
+	grep :1 other.marks
+'
 
 cat >input << EOF
 feature import-marks=marks.out
 feature export-marks=marks.new
 EOF
 
-test_expect_success \
-	'R: import to output marks works without any content' \
-	'cat input | git fast-import &&
-	test_cmp marks.out marks.new'
+test_expect_success 'R: import to output marks works without any content' '
+	cat input | git fast-import &&
+	test_cmp marks.out marks.new
+'
 
 cat >input <<EOF
 feature import-marks=nonexistant.marks
 feature export-marks=marks.new
 EOF
 
-test_expect_success \
-	'R: import marks prefers commandline marks file over the stream' \
-	'cat input | git fast-import --import-marks=marks.out &&
-	test_cmp marks.out marks.new'
+test_expect_success 'R: import marks prefers commandline marks file over the stream' '
+	cat input | git fast-import --import-marks=marks.out &&
+	test_cmp marks.out marks.new
+'
 
 
 cat >input <<EOF
@@ -1700,7 +1700,7 @@ test_expect_success 'R: die on unknown option' '
 	test_must_fail git fast-import <input
 '
 
-test_expect_success 'R: unknown commandline options are rejected' '\
+test_expect_success 'R: unknown commandline options are rejected' '
 	test_must_fail git fast-import --non-existing-option < /dev/null
 '
 
@@ -1735,29 +1735,29 @@ INPUT_END
 cat expect >>input
 echo >>input
 
-test_expect_success \
-	'R: blob bigger than threshold' \
-	'test_create_repo R &&
-	 git --git-dir=R/.git fast-import --big-file-threshold=1 <input'
-test_expect_success \
-	'R: verify created pack' \
-	'(
+test_expect_success 'R: blob bigger than threshold' '
+	test_create_repo R &&
+	git --git-dir=R/.git fast-import --big-file-threshold=1 <input
+'
+test_expect_success 'R: verify created pack' '
+	(
 		for p in R/.git/objects/pack/*.pack
 		do
 			git verify-pack -v $p ||
 			exit
 		done
+	) >verify
+'
-	 ) >verify'
-test_expect_success \
-	'R: verify written objects' \
-	'git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
-	 test_cmp expect actual &&
-	 a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
-	 b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
-	 test $a = $b'
-test_expect_success \
-	'R: blob appears only once' \
-	'n=$(grep $a verify | wc -l) &&
-	 test 1 = $n'
+test_expect_success 'R: verify written objects' '
+	git --git-dir=R/.git cat-file blob big-file:big1 >actual &&
+	test_cmp expect actual &&
+	a=$(git --git-dir=R/.git rev-parse big-file:big1) &&
+	b=$(git --git-dir=R/.git rev-parse big-file:big2) &&
+	test $a = $b
+'
+test_expect_success 'R: blob appears only once' '
+	n=$(grep $a verify | wc -l) &&
+	test 1 = $n
+'
 
 test_done
-- 
1.7.2.3
