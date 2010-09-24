From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/24] t9300 (fast-import), series C: re-indent
Date: Fri, 24 Sep 2010 02:19:09 -0500
Message-ID: <20100924071909.GK4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:22:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2bZ-0000ok-Nq
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756734Ab0IXHV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:21:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47747 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab0IXHV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:21:56 -0400
Received: by iwn5 with SMTP id 5so2161744iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DsW1a4Nf4LSzG06X+r2MGoW23heQtUpeBfOT05ToBcA=;
        b=l5hETskcHusFFnVMtcEJ7npbR8JfSeCNmcinV8gMXb0XkzQzBC7BpvglEWK7NU+sLs
         xJDRDIRiMzOqlu/ksOFDzxItKlvexWh6y4zP4MfunfYnBCCoYMTPPKxodFI2xK90nYA3
         PjIPF8jIV1TPGY51xeW23deh6rjtzN1w5pASY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AOisvx1sbFcAYJtRil8xnhfokaNtZ4AfTPDXMG6eSyV6U4P8wsrfM4YnzfYQoR6BWU
         Y5y+Y+ofyaQSXaqT/h5bO8lhxci31Xp3/p4/K/HfIzKsjYxwbpKznmauMq6RgB9Tg3nv
         fkwlY/Y32ts1vPzcyBtAdvWvkbLW1GiRpIrT0=
Received: by 10.231.148.85 with SMTP id o21mr3480992ibv.26.1285312915963;
        Fri, 24 Sep 2010 00:21:55 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm1957489ibk.13.2010.09.24.00.21.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:21:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156944>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index a2b8950..f8856b4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -346,17 +346,17 @@ M 755 $newf file2/newf
 D file3
 
 INPUT_END
-test_expect_success \
-	'C: incremental import create pack from stdin' \
-	'git fast-import <input &&
-	 git whatchanged branch'
-test_expect_success \
-	'C: verify pack' \
-	'verify_packs'
-test_expect_success \
-	'C: validate reuse existing blob' \
-	'test $newf = `git rev-parse --verify branch:file2/newf`
-	 test $oldf = `git rev-parse --verify branch:file2/oldf`'
+test_expect_success 'C: incremental import create pack from stdin' '
+	git fast-import <input &&
+	git whatchanged branch
+'
+test_expect_success 'C: verify pack' '
+	verify_packs
+'
+test_expect_success 'C: validate reuse existing blob' '
+	test $newf = `git rev-parse --verify branch:file2/newf`
+	test $oldf = `git rev-parse --verify branch:file2/oldf`
+'
 
 cat >expect <<EOF
 parent `git rev-parse --verify master^0`
@@ -365,10 +365,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 second
 EOF
-test_expect_success \
-	'C: verify commit' \
-	'git cat-file commit branch | sed 1d >actual &&
-	 test_cmp expect actual'
+test_expect_success 'C: verify commit' '
+	git cat-file commit branch | sed 1d >actual &&
+	test_cmp expect actual
+'
 
 cat >expect <<EOF
 :000000 100755 $zeroes $newf A	file2/newf
@@ -376,9 +376,9 @@ cat >expect <<EOF
 :100644 000000 $file3_id $zeroes D	file3
 EOF
 git diff-tree -M -r master branch >actual
-test_expect_success \
-	'C: validate rename result' \
-	'compare_diff_raw expect actual'
+test_expect_success 'C: validate rename result' '
+	compare_diff_raw expect actual
+'
 
 ###
 ### series D
-- 
1.7.2.3
