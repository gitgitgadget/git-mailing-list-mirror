From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/24] t9300 (fast-import), series J: re-indent
Date: Fri, 24 Sep 2010 02:24:30 -0500
Message-ID: <20100924072430.GQ4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:27:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2gl-0002dl-6v
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab0IXH1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:27:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45431 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178Ab0IXH1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:27:17 -0400
Received: by iwn5 with SMTP id 5so2165462iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yecMKv1theh96WtWdxn4QoRGdEtv+33fKSYysI8jPtw=;
        b=XYHaKUmvf6KBFBYbbYLAwP8gwcmEDRNc15uemQ+g9gn6kgD3ZBcA3mFx+CIEcETNnO
         95rAD6LbZl2+chAh5kXhiuQPEsv4ZPEJTvlPOFI0F3Iis0IiyMTfJZQgZqlqz8WG+sSX
         W7Y27gWr8+Wd22m5W3nlbQITs7snRqU35nytA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QStIiwTunBygGR4KcpyqWsSwhFPXWrINcG24ZoU+/wdZdI2JXE/Xiuvju7owTH0u/5
         xhRrMBVLCsqX+rVe5ZBuMe9voqKvIu7+QawECVer02Fdmboq3xmS549VD5xEa6pMnU6+
         4ZjJRUecPWz3L2itrohhK8RSXY2mBdM+2X7xE=
Received: by 10.231.32.135 with SMTP id c7mr3452648ibd.3.1285313237154;
        Fri, 24 Sep 2010 00:27:17 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id i6sm1963835iba.14.2010.09.24.00.27.16
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:27:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156951>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index fda1911..2a2f969 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -647,13 +647,13 @@ initialize J
 COMMIT
 
 INPUT_END
-test_expect_success \
-	'J: reset existing branch creates empty commit' \
-	'git fast-import <input'
-test_expect_success \
-	'J: branch has 1 commit, empty tree' \
-	'test 1 = `git rev-list J | wc -l` &&
-	 test 0 = `git ls-tree J | wc -l`'
+test_expect_success 'J: reset existing branch creates empty commit' '
+	git fast-import <input
+'
+test_expect_success 'J: branch has 1 commit, empty tree' '
+	test 1 = `git rev-list J | wc -l` &&
+	test 0 = `git ls-tree J | wc -l`
+'
 
 ###
 ### series K
-- 
1.7.2.3
