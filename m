From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/24] t9300 (fast-import), series F: re-indent
Date: Fri, 24 Sep 2010 02:22:15 -0500
Message-ID: <20100924072215.GN4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2ed-0001uD-Au
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab0IXHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:25:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61813 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab0IXHZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:25:03 -0400
Received: by iwn5 with SMTP id 5so2163953iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9BIGcQjFaO4eB376VXdfNwWVRSvgHGxNK0qOctomS3E=;
        b=JV8Yb350EquLAp/2NiAyYEPTCzg+bkdBDTwbSXM6XolWMCaFnBUGERJXq6aLX2T2Or
         6mc+CkxU9dJ2VQ25IhDbjDlkKE1I0NyylCz0WGk5gak4zNstDr9o0F89tyPqGrSEqJ4I
         YAjUGTE3oZbONywuQZO5iZF+CIYGlLVlXdO6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yCsVuGSXCjOHgy11usgoIh9cYz+aFv81TbhhDMkMh/DwEjENm87Wm20hmmwjRaI5YQ
         Z1TN2xbYgphTKmqEpXAd8D+k0Y0fOlfuizRHECFkG2Gdg77vmmJYc7mDEcJPPHWFE7V0
         yLsuI6eersM+FyqMn1+F4QNYtV5iRKUiYKCdQ=
Received: by 10.231.147.131 with SMTP id l3mr3439314ibv.74.1285313102478;
        Fri, 24 Sep 2010 00:25:02 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id o4sm1966493iba.0.2010.09.24.00.25.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:25:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156948>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   47 +++++++++++++++++++++++------------------------
 1 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 1324157..ab317d6 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -488,13 +488,12 @@ reset refs/heads/other
 from refs/heads/branch
 
 INPUT_END
-test_expect_success \
-	'F: non-fast-forward update skips' \
-	'if git fast-import <input
-	 then
+test_expect_success 'F: non-fast-forward update skips' '
+	if git fast-import <input
+	then
 		echo BAD gfi did not fail
 		return 1
-	 else
+	else
 		if test $old_branch = `git rev-parse --verify branch^0`
 		then
 			: branch unaffected and failure returned
@@ -503,11 +502,11 @@ test_expect_success \
 			echo BAD gfi changed branch $old_branch
 			return 1
 		fi
-	 fi
-	'
-test_expect_success \
-	'F: verify pack' \
-	'verify_packs'
+	fi
+'
+test_expect_success 'F: verify pack' '
+	verify_packs
+'
 
 cat >expect <<EOF
 tree `git rev-parse branch~1^{tree}`
@@ -517,10 +516,10 @@ committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
 
 losing things already?
 EOF
-test_expect_success \
-	'F: verify other commit' \
-	'git cat-file commit other >actual &&
-	test_cmp expect actual'
+test_expect_success 'F: verify other commit' '
+	git cat-file commit other >actual &&
+	test_cmp expect actual
+'
 
 ###
 ### series G
@@ -538,16 +537,16 @@ COMMIT
 from refs/heads/branch~1
 
 INPUT_END
-test_expect_success \
-	'G: non-fast-forward update forced' \
-	'git fast-import --force <input'
-test_expect_success \
-	'G: verify pack' \
-	'verify_packs'
-test_expect_success \
-	'G: branch changed, but logged' \
-	'test $old_branch != `git rev-parse --verify branch^0` &&
-	 test $old_branch = `git rev-parse --verify branch@{1}`'
+test_expect_success 'G: non-fast-forward update forced' '
+	git fast-import --force <input
+'
+test_expect_success 'G: verify pack' '
+	verify_packs
+'
+test_expect_success 'G: branch changed, but logged' '
+	test $old_branch != `git rev-parse --verify branch^0` &&
+	test $old_branch = `git rev-parse --verify branch@{1}`
+'
 
 ###
 ### series H
-- 
1.7.2.3
