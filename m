From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFC 1/2] is_url: Remove redundant assignment
Date: Sun, 25 Sep 2011 13:06:21 +0800
Message-ID: <1316927182-14212-2-git-send-email-pangyanhan@gmail.com>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 07:09:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7gyS-0002qh-Mg
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 07:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab1IYFJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Sep 2011 01:09:52 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:54715 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab1IYFJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2011 01:09:51 -0400
Received: by gwb15 with SMTP id 15so4604213gwb.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 22:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2L0zNEqQI09qVVn7/rPvS/5CAhjc3tzygieI6Y0ZhCM=;
        b=hrqfOKJQs3+nPYlSP0OZDJSERc3ZZoa22LVy46W/Qwb8k87fqSFdzilkdGwv/lN9E9
         izq98k5rR1KbGWznpUMvsFjoLqGVOipiGPqg0wSdnkvpX/mklTfJrBuyGYLAXibKub+O
         68dU7Ueh4vuRv/I9gawIiXmy6wG4STrLY3Kgg=
Received: by 10.68.11.138 with SMTP id q10mr20466462pbb.37.1316927390562;
        Sat, 24 Sep 2011 22:09:50 -0700 (PDT)
Received: from localhost (bb116-14-45-233.singnet.com.sg. [116.14.45.233])
        by mx.google.com with ESMTPS id 2sm42045806pbu.1.2011.09.24.22.09.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 22:09:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc3.2.g6432
In-Reply-To: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182057>

Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 url.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/url.c b/url.c
index 3e06fd3..d2e17e6 100644
--- a/url.c
+++ b/url.c
@@ -22,7 +22,6 @@ int is_url(const char *url)
 
 	if (!url)
 		return 0;
-	url2 = url;
 	first_slash = strchr(url, '/');
 
 	/* Input with no slash at all or slash first can't be URL. */
-- 
1.7.7.rc3.2.g29f2e6
