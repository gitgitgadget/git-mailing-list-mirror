From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/24] t9300 (fast-import), series L: re-indent
Date: Fri, 24 Sep 2010 02:25:32 -0500
Message-ID: <20100924072532.GS4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:28:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2ht-00037N-UG
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907Ab0IXH2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:28:25 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58627 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754644Ab0IXH2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:28:24 -0400
Received: by iwn5 with SMTP id 5so2166215iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=B37i8k4q2yHk41p1iD1d0yssVjWbfPV1Tky8F2ovxUI=;
        b=tgWVAENQ+pHH1DhE7AWU5Q+dIQhjXo/labeJNeZg96X6wD51IBXujBDTRpXFErFN0g
         KzMRMPFWuto2rcyVJHSp2CeoOEHwXkmMSj69Xs4OjKcpCD+wOXnRPe3sTRP30vB4tciH
         O8h95numP+qerHWtNo7dznWm9cO/zeERLDM0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lyMW4USkpARe1PWcrzlQAFKLXf9hpyOetv6YGGMNdFO7UIfk1yQgDbaXDGBVxM2wud
         2li0F24v2JXD8/k05Oa3GMI+99Fdi2+kyehgW1PkjZ0g5pIjTAlS6cLjgXxkCkKXRXan
         y2rf5nTvAffEwIZFLY9EYr3M0YVzph55aLAwg=
Received: by 10.231.183.10 with SMTP id ce10mr3416195ibb.96.1285313303974;
        Fri, 24 Sep 2010 00:28:23 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm1964275ibe.17.2010.09.24.00.28.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:28:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156954>

See "t9300 (fast-import), series A: re-indent".

Cc: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 82647f8..614c5b5 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -752,11 +752,11 @@ cat >expect <<EXPECT_END
 :100644 100644 $some_data $other_data M	ba
 EXPECT_END
 
-test_expect_success \
-	'L: verify internal tree sorting' \
-	'git fast-import <input &&
-	 git diff-tree L^ L >output &&
-	 test_cmp expect output'
+test_expect_success 'L: verify internal tree sorting' '
+	git fast-import <input &&
+	git diff-tree L^ L >output &&
+	test_cmp expect output
+'
 
 ###
 ### series M
-- 
1.7.2.3
