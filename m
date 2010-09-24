From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 19/24] t9300 (fast-import), series M: re-indent
Date: Fri, 24 Sep 2010 02:26:04 -0500
Message-ID: <20100924072604.GT4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:28:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2iI-0003HV-EQ
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab0IXH2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:28:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58627 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0IXH2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:28:51 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so2166215iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JrNS17xaaCvRMwAs5PxdFojGYwPmmW4MrUr16HWpJZ4=;
        b=Z6GtjeoRhz58xUk/2EimqHTjy+/zHu9m/X/2IslgiuDNZqy8iJzsxHlicmWYZW/Pnz
         zWbfhLpLCEIFSSznSf2FObTB8rgtCTCzHWcfUETB328gQI7MQcd4IJKypoSEVt3jxi6Z
         YEaS4uReweUXcCx7RdA8FC2SNSd9Pf3FT07gY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FQyPNVSSCmfb7U5VPOJ051TnkqX3dXIfWtq011h0dk9Ko6X3RGIdLzX7eTwDbSr8+Y
         uyhFFr8qZSNGhyCHUTSQE8EflS+4jUjWNSvvDTR+ZLM79ZZTAMApG+F1AUzkhUyC0Ulb
         6V8C9gAVMgSzK6mSggOSh90ZFs+SxFGQE5ibA=
Received: by 10.231.35.138 with SMTP id p10mr3436184ibd.33.1285313331213;
        Fri, 24 Sep 2010 00:28:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm1965963ibk.15.2010.09.24.00.28.50
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:28:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156955>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 614c5b5..5237afc 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -778,11 +778,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 $newf $newf R100	file2/newf	file2/n.e.w.f
 EOF
-test_expect_success \
-	'M: rename file in same subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M1^ M1 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'M: rename file in same subdirectory' '
+	git fast-import <input &&
+	git diff-tree -M -r M1^ M1 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/M2
@@ -799,11 +799,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 $newf $newf R100	file2/newf	i/am/new/to/you
 EOF
-test_expect_success \
-	'M: rename file to new subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M2^ M2 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'M: rename file to new subdirectory' '
+	git fast-import <input &&
+	git diff-tree -M -r M2^ M2 >actual &&
+	compare_diff_raw expect actual
+'
 
 cat >input <<INPUT_END
 commit refs/heads/M3
@@ -820,11 +820,11 @@ INPUT_END
 cat >expect <<EOF
 :100755 100755 $newf $newf R100	i/am/new/to/you	other/sub/am/new/to/you
 EOF
-test_expect_success \
-	'M: rename subdirectory to new subdirectory' \
-	'git fast-import <input &&
-	 git diff-tree -M -r M3^ M3 >actual &&
-	 compare_diff_raw expect actual'
+test_expect_success 'M: rename subdirectory to new subdirectory' '
+	git fast-import <input &&
+	git diff-tree -M -r M3^ M3 >actual &&
+	compare_diff_raw expect actual
+'
 
 ###
 ### series N
-- 
1.7.2.3
