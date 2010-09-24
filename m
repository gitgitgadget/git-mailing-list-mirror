From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/24] t9300 (fast-import), series N: re-indent
Date: Fri, 24 Sep 2010 02:26:33 -0500
Message-ID: <20100924072633.GU4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:29:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2io-0003QC-37
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755084Ab0IXH3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:29:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35336 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0IXH3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:29:21 -0400
Received: by yxp4 with SMTP id 4so859476yxp.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=h5n8OjpfFzxAX/Tk4qLa/PWtIyas51RtH0xw801szUc=;
        b=crE3Ra+IfRc6iuCFuKH0K/XSRJwyrKHk4NFC2I1lufdRMf3oM8fnBjE6y9p5NKO8tC
         MlCAGU+ojUBsmpNsgv1IEPBiFarX0ZsiHx5aeIVsOd1Yenmw3InBB4a9VWcNklsuxwRx
         rdC+gsxS/JvAfm8VdZFYOuftq/9Gf4zNhuZv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UsIHnBe79wbETXtqWjor4eG0BkrLBAEJEoC8tRzvfSdPYmIStjyfIxoJJCbWkbYmY+
         62sQK762a0WCgQTgxv8PUitoUZ5vxI22M/oRmfjH9gZSAmQO0T2OYdNrepxeIGOfV3gG
         g25mQYHfMlebhiYytH72BenxApyRY0rGb/6F4=
Received: by 10.150.197.14 with SMTP id u14mr4033257ybf.289.1285313360343;
        Fri, 24 Sep 2010 00:29:20 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm1960497ybk.13.2010.09.24.00.29.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:29:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156956>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   60 ++++++++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5237afc..7bd2bd0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -846,11 +846,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 $newf $newf C100	file2/newf	file2/n.e.w.f
 EOF
-test_expect_success \
-	'N: copy file in same subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'N: copy file in same subdirectory' '
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N1^ N1 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/N2
@@ -880,11 +880,11 @@ cat >expect <<EOF
 :100755 100755 $newf $newf C100	file2/newf	file3/newf
 :100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 EOF
-test_expect_success \
-	'N: copy then modify subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'N: copy then modify subdirectory' '
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N2^^ N2 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/N3
@@ -904,19 +904,18 @@ D file2/file5
 
 INPUT_END
 
-test_expect_success \
-	'N: copy dirty subdirectory' \
-	'git fast-import <input &&
-	 test `git rev-parse N2^{tree}` = `git rev-parse N3^{tree}`'
+test_expect_success 'N: copy dirty subdirectory' '
+	git fast-import <input &&
+	test `git rev-parse N2^{tree}` = `git rev-parse N3^{tree}`
+'
 
-test_expect_success \
-	'N: copy directory by id' \
-	'cat >expect <<-EOF &&
+test_expect_success 'N: copy directory by id' '
+	cat >expect <<-EOF &&
 	:100755 100755 $newf $newf C100	file2/newf	file3/newf
 	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
-	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
-	 cat >input <<-INPUT_END &&
+	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N4
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -926,19 +925,19 @@ test_expect_success \
 	from refs/heads/branch^0
 	M 040000 $subdir file3
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
-	 compare_diff_raw expect actual'
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N4^ N4 >actual &&
+	compare_diff_raw expect actual
+'
 
-test_expect_success \
-	'N: modify copied tree' \
-	'cat >expect <<-EOF &&
+test_expect_success 'N: modify copied tree' '
+	cat >expect <<-EOF &&
 	:100644 100644 $file5_id $file5_id C100	newdir/interesting	file3/file5
 	:100755 100755 $newf $newf C100	file2/newf	file3/newf
 	:100644 100644 $oldf $oldf C100	file2/oldf	file3/oldf
 	EOF
-	 subdir=$(git rev-parse refs/heads/branch^0:file2) &&
-	 cat >input <<-INPUT_END &&
+	subdir=$(git rev-parse refs/heads/branch^0:file2) &&
+	cat >input <<-INPUT_END &&
 	commit refs/heads/N5
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 	data <<COMMIT
@@ -959,9 +958,10 @@ test_expect_success \
 	$file5_data
 	EOF
 	INPUT_END
-	 git fast-import <input &&
-	 git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
-	 compare_diff_raw expect actual'
+	git fast-import <input &&
+	git diff-tree -C --find-copies-harder -r N5^^ N5 >actual &&
+	compare_diff_raw expect actual
+'
 
 ###
 ### series O
-- 
1.7.2.3
