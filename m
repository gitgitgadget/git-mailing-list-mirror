From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 10/10] transport: update flags to be in running order
Date: Thu, 18 Feb 2010 20:37:11 +0800
Message-ID: <1266496631-3980-11-git-send-email-rctay89@gmail.com>
References: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Cc: "Jeff King" <peff@peff.net>,
	"Sebastian Thiel" <byronimo@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 13:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ni5e6-0004Ez-PG
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 13:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229Ab0BRMiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 07:38:11 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:41364 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758183Ab0BRMiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 07:38:09 -0500
Received: by gxk27 with SMTP id 27so2566648gxk.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 04:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kfZZp3KN71j1zi77sDh4vnAbzHBqwy8nRvwgM00Y0fs=;
        b=mW/q8NR17cFLKkkU5wsk+jAwMMLCVvc6oXqZXuZCeep32ff8N8i1YIkejAgyYQSIIS
         CYpk2SIOKm6iYddiVhWGLGEcpCkXYlwaIaWmHZJZBNMFvlPyIgOLUMBColbeBfNUG9uV
         GdoHyhQDSSaXXdAPwS8qv5jDse6gWqz6GmxLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Nv7sOiTrCCZgaiToT8MPjsPDrs6+iHYr2hQbO2aVSWuM7dVWO9vYUEOZoz2BmzjRPP
         Lv0VDMoSG2qkJRmhWKV4Z3LiALC+Wly6UUoPjKAfa4K/GReJWpzoP3hq1F//FfcyZte3
         bxntyBo7/BIPQ3SHA10iok9agWN1azUNjiCTs=
Received: by 10.151.87.14 with SMTP id p14mr3495675ybl.195.1266496687272;
        Thu, 18 Feb 2010 04:38:07 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 21sm381013ywh.17.2010.02.18.04.38.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 04:38:06 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266496631-3980-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140328>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 transport.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.h b/transport.h
index de2745a..d9bbabb 100644
--- a/transport.h
+++ b/transport.h
@@ -93,8 +93,8 @@ struct transport {
 #define TRANSPORT_PUSH_FORCE 2
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
-#define TRANSPORT_PUSH_PORCELAIN 32
-#define TRANSPORT_PUSH_SET_UPSTREAM 128
+#define TRANSPORT_PUSH_PORCELAIN 16
+#define TRANSPORT_PUSH_SET_UPSTREAM 32
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.7.0.27.g5d71b
