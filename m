From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/24] t9300 (fast-import), series H: re-indent
Date: Fri, 24 Sep 2010 02:22:51 -0500
Message-ID: <20100924072251.GO4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:25:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2fC-00025H-Ui
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab0IXHZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:25:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56869 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752613Ab0IXHZn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:25:43 -0400
Received: by iwn5 with SMTP id 5so2164436iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tO8L9z2jlqZSpKR2fcvzqBfljLRa0NnbgYF2JzKPVIU=;
        b=VqtXsmCB+50Z2qVyZuufS5WwtiVdsQ9rOlhnFzq8NnOrMFxTowb8qXAfC0av4UKn7p
         4nsjiLbsv7SV+a7A8GlGvjonbKs5HYidxCeRhEcJMYVCeLa8skz2i37lttjTp6UMVlHU
         dDO5Ec6CY7ghj4sR/lCPAerZGBSEdDV7bCqQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GvSrWZpu6V9ZEk3oxTkWqD8RdMpzfkAtxaZ0wwgPBWFwltC8YRIUrmNSbp+bQVLIej
         dhE+C1DoZVG+bE3fHneIvapyMHaG9wViZJ0h9ALC7ehspdeIvInYviBU2+bnqBMsXjYp
         O//HxOkeiZB2SF69KS29qZfg2VEGVsAsf4iDs=
Received: by 10.231.13.133 with SMTP id c5mr3274831iba.73.1285313142679;
        Fri, 24 Sep 2010 00:25:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm1964695ibh.4.2010.09.24.00.25.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:25:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156949>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ab317d6..875a951 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -573,13 +573,13 @@ $file5_data
 EOF
 
 INPUT_END
-test_expect_success \
-	'H: deletall, add 1' \
-	'git fast-import <input &&
-	 git whatchanged H'
-test_expect_success \
-	'H: verify pack' \
-	'verify_packs'
+test_expect_success 'H: deletall, add 1' '
+	git fast-import <input &&
+	git whatchanged H
+'
+test_expect_success 'H: verify pack' '
+	verify_packs
+'
 
 cat >expect <<EOF
 :100755 000000 $newf $zeroes D	file2/newf
@@ -589,15 +589,15 @@ cat >expect <<EOF
 :100755 000000 $file6_id $zeroes D	newdir/exec.sh
 EOF
 git diff-tree -M -r H^ H >actual
-test_expect_success \
-	'H: validate old files removed, new files added' \
-	'compare_diff_raw expect actual'
+test_expect_success 'H: validate old files removed, new files added' '
+	compare_diff_raw expect actual
+'
 
 echo "$file5_data" >expect
-test_expect_success \
-	'H: verify file' \
-	'git cat-file blob H:h/e/l/lo >actual &&
-	 test_cmp expect actual'
+test_expect_success 'H: verify file' '
+	git cat-file blob H:h/e/l/lo >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series I
-- 
1.7.2.3
