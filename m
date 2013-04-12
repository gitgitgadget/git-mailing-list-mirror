From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/10] precompose-utf8: fix spelling of "want" in error
 message
Date: Fri, 12 Apr 2013 00:07:40 -0700
Message-ID: <20130412070740.GH5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
 <20130412064837.GA5710@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 09:07:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQY5O-0005oA-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 09:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752397Ab3DLHHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 03:07:46 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:61304 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773Ab3DLHHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 03:07:45 -0400
Received: by mail-pd0-f179.google.com with SMTP id x11so1259980pdj.38
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4Mls4LZ3HlK1WUx1uMm75M1y69ojcKXrIVO7nKK4jxQ=;
        b=nADf4k5NHe7iwE3jMYJAbMbwlKcT6NbEF2uKMMoE2XTKGWv51tnrW76w3asibX721z
         yvLzxYnLT2YD9OedhFoqoHIVIFGGTZuB4cR66wixQVsl510ZZjlgQ/HQKacEVPvT/uKL
         FrXfQIUSavJwQ1xEayFNXOLfiabiNa+sp9+t8CNTCELJnFDJyRRbUL0AszDGBPgLVK02
         b/bzmX2ltWV4FHnxcIXFZcLnyxMRD4F5lFaWNz6u7fMf/ptgInKg6sgYkDNOIiK7pKWL
         EqStEzJc5qUY8OCSm97o7spKf0/OojgW9s1ua0T9hTyWRW4Up9LbBsQoN11nwHVmHRLF
         /e3g==
X-Received: by 10.68.90.36 with SMTP id bt4mr13120771pbb.42.1365750465413;
        Fri, 12 Apr 2013 00:07:45 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id t1sm8310917pab.12.2013.04.12.00.07.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 00:07:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130412064837.GA5710@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220965>

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Date: Fri, 12 Apr 2013 00:36:10 +0200

Noticed using Lucas De Marchi's codespell tool.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 compat/precompose_utf8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 8cf59558..030174db 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -134,7 +134,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 			if (prec_dir->ic_precompose == (iconv_t)-1) {
 				die("iconv_open(%s,%s) failed, but needed:\n"
 						"    precomposed unicode is not supported.\n"
-						"    If you wnat to use decomposed unicode, run\n"
+						"    If you want to use decomposed unicode, run\n"
 						"    \"git config core.precomposeunicode false\"\n",
 						repo_encoding, path_encoding);
 			} else {
-- 
1.8.2.1
