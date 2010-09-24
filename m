From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/24] t9300 (fast-import), series D: re-indent
Date: Fri, 24 Sep 2010 02:19:59 -0500
Message-ID: <20100924071959.GL4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:22:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2cT-00018H-1W
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab0IXHWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:22:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48867 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab0IXHWv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:22:51 -0400
Received: by iwn5 with SMTP id 5so2162462iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XGUGTh1inv+QJhQh4aof7I8lyrAGwXgsx4skTmP4hXY=;
        b=qD7hb8OW9B0FBWnOqDiT3r6B0LzIqb2wmf9tYQK8IKHUiFNgnZ/07IF99JsZUGz5+B
         m6YB7lpCzCmHBLPkWEumGmlDafP+hceF5w/4spFF0gmsoqmv2COBIoR/AAZilV5RoehC
         xSBM1KH/kdt1mCN1WTon4YSHuINlaiOywhMss=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mtkv8QHtOw6Iiqxds3xA/ziPudjE8QX0JYiwgkOv4Wcl+BIISpbUZFWx0ctIAM76fD
         CLIWgGKGtmSwn+tmakakBeUnBwS5i8gYrp7UjYZ5HqgDANsJRbG3xUbr9mwzl/TEDQF0
         HVLLe3Mnu8GL7/SxfHOmoWA7voyjxnVVeRifM=
Received: by 10.231.33.76 with SMTP id g12mr3228826ibd.174.1285312971274;
        Fri, 24 Sep 2010 00:22:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i6sm1957796iba.14.2010.09.24.00.22.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:22:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156945>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f8856b4..78ea775 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -404,34 +404,34 @@ $file6_data
 EOF
 
 INPUT_END
-test_expect_success \
-	'D: inline data in commit' \
-	'git fast-import <input &&
-	 git whatchanged branch'
-test_expect_success \
-	'D: verify pack' \
-	'verify_packs'
+test_expect_success 'D: inline data in commit' '
+	git fast-import <input &&
+	git whatchanged branch
+'
+test_expect_success 'D: verify pack' '
+	verify_packs
+'
 
 cat >expect <<EOF
 :000000 100755 $zeroes $file6_id A	newdir/exec.sh
 :000000 100644 $zeroes $file5_id A	newdir/interesting
 EOF
 git diff-tree -M -r branch^ branch >actual
-test_expect_success \
-	'D: validate new files added' \
-	'compare_diff_raw expect actual'
+test_expect_success 'D: validate new files added' '
+	compare_diff_raw expect actual
+'
 
 echo "$file5_data" >expect
-test_expect_success \
-	'D: verify file5' \
-	'git cat-file blob branch:newdir/interesting >actual &&
-	 test_cmp expect actual'
+test_expect_success 'D: verify file5' '
+	git cat-file blob branch:newdir/interesting >actual &&
+	test_cmp expect actual
+'
 
 echo "$file6_data" >expect
-test_expect_success \
-	'D: verify file6' \
-	'git cat-file blob branch:newdir/exec.sh >actual &&
-	 test_cmp expect actual'
+test_expect_success 'D: verify file6' '
+	git cat-file blob branch:newdir/exec.sh >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series E
-- 
1.7.2.3
