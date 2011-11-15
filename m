From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/4] http: remove unused function hex()
Date: Tue, 15 Nov 2011 22:29:36 +0530
Message-ID: <1321376379-31750-2-git-send-email-artagnon@gmail.com>
References: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Cc: Thomas Rast <trast@student.ethz.ch>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 18:01:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQMNy-000256-UL
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 18:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853Ab1KORBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 12:01:18 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:55924 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab1KORBR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 12:01:17 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so16057325pzk.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 09:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=+R67VLXht+l+GOyUJSpidTh/YZahVSwSku9RJiWR4qI=;
        b=OJustJYYcevkOSrPfdOuz3bjFwuhYzYP+SD3BLTNUI1/C8DqBCgfZuYpJc1bAj8wa2
         2hHMXf8HKTxSCJXX6x22ad8LiapA/fdCJKuIFlgR7DL8JpGIILsb3zxYTrnpn/Ruk/ej
         vttne+JeGpq6LJ4TIHMzYbusOH7T/UpZD3ez4=
Received: by 10.68.38.5 with SMTP id c5mr22683214pbk.93.1321376476904;
        Tue, 15 Nov 2011 09:01:16 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id f2sm37889376pbg.14.2011.11.15.09.01.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 09:01:15 -0800 (PST)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1321376379-31750-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185469>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 http.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index 008ad72..e6c7597 100644
--- a/http.c
+++ b/http.c
@@ -747,14 +747,6 @@ static inline int needs_quote(int ch)
 	return 1;
 }
 
-static inline int hex(int v)
-{
-	if (v < 10)
-		return '0' + v;
-	else
-		return 'A' + v - 10;
-}
-
 static char *quote_ref_url(const char *base, const char *ref)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
1.7.6.351.gb35ac.dirty
