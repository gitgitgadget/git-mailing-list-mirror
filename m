From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/24] t9300 (fast-import), series E: re-indent
Date: Fri, 24 Sep 2010 02:21:15 -0500
Message-ID: <20100924072115.GM4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:24:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2de-0001UB-2A
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab0IXHYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:24:04 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47512 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab0IXHYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:24:03 -0400
Received: by gwj17 with SMTP id 17so858804gwj.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3qR1oQjL773g4j8Qu4ngaSO6bhsWrUpVYVZgz4WxY/U=;
        b=SjJ186e2fX/LaHFsMrjuTWIflCe75r8vckFNIfcdQs0GnLQCQB8vIcxVc0U7rsmz2r
         DEhPDihykoprFCja3Uln2P5Nn7SgDS1UCRpVbJB9W2HR0LuPv4p/OROGP/Pt4dUF9+FM
         LIqRb6V2IocCOnjDT2SxILaemURg4G/SfJOxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IJrk1ryB9+aRhaR5A1pDRRTFGkMpPNyRbIZ+/9a7rfnnuBjxC7vm6CTkZ2Aas17k34
         b4PvrGHxhgtqaPPANmjtPU+DJd1g4qLC2bxgrcfPzWS9Cv7xKCJHLWwbj6WRXd4NsbAi
         DaJ2uvmIjX4TWQHXZ1G4z2ahz+lSCagEOHGQ4=
Received: by 10.151.48.3 with SMTP id a3mr4153422ybk.427.1285313042394;
        Fri, 24 Sep 2010 00:24:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q25sm1955285ybk.18.2010.09.24.00.24.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:24:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156947>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 78ea775..1324157 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -451,12 +451,12 @@ INPUT_END
 test_expect_success 'E: rfc2822 date, --date-format=raw' '
 	test_must_fail git fast-import --date-format=raw <input
 '
-test_expect_success \
-	'E: rfc2822 date, --date-format=rfc2822' \
-	'git fast-import --date-format=rfc2822 <input'
-test_expect_success \
-	'E: verify pack' \
-	'verify_packs'
+test_expect_success 'E: rfc2822 date, --date-format=rfc2822' '
+	git fast-import --date-format=rfc2822 <input
+'
+test_expect_success 'E: verify pack' '
+	verify_packs
+'
 
 cat >expect <<EOF
 author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 1170778938 -0500
@@ -464,10 +464,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1170783302 -0500
 
 RFC 2822 type date
 EOF
-test_expect_success \
-	'E: verify commit' \
-	'git cat-file commit branch | sed 1,2d >actual &&
-	test_cmp expect actual'
+test_expect_success 'E: verify commit' '
+	git cat-file commit branch | sed 1,2d >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series F
-- 
1.7.2.3
