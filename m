From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 03/12] MinGW: Convert CR/LF to LF in tag signatures
Date: Wed,  2 Jul 2008 10:32:03 +0200
Message-ID: <1214987532-23640-3-git-send-email-prohaska@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de>
Reply-To: prohaska@zib.de
Cc: git@vger.kernel.org, msysgit@googlegroups.com, Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <johannes.schindelin@gmx.de>, Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 10:33:31 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.24])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxmD-0001FL-0t
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 10:33:21 +0200
Received: by yw-out-2122.google.com with SMTP id 8so2058156yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        bh=mqKIjfTk2lACfTGsoWyWnv+3WqPGms/X3AyFs+hh/9s=;
        b=K3h8ykO/Lvf0RAvhEAhJstoUYCJH8ygCrRcm5267pzU5/N7bKTU4jvY2FUdCFdTR3k
         likpt7rVVhKTU8IPh+uDW8nEG8BXsMp+pndHlu7nOCxu3UCKfvDzYzsmd31UnBMONz9s
         SqxukBGHE+PlN9B5JdyiZXTcjHGbm2ViNfS5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        b=x5KSpNV8kxKEInb1ZVEnKrQs17HCr57UoERGvlhWfyObu8gqMvRbAW2kOhyLdoFwOC
         1SNg7K3LKlMb/4jpvdvNxiEdZCyS/XIYZyzJC6xePzyUKhaB4ZiB11V6I2ZrCeGKGZYb
         qQtjPt2YLGDsaw26DCZljdiYmJOKqIc4UURMk=
Received: by 10.142.48.14 with SMTP id v14mr270859wfv.17.1214987541348;
        Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
Received: by 10.106.79.1 with SMTP id c1gr2546prb.0;
	Wed, 02 Jul 2008 01:32:21 -0700 (PDT)
X-Sender: prohaska@zib.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.79.17 with SMTP id c17mr8826077agb.24.1214987540746; Wed, 02 Jul 2008 01:32:20 -0700 (PDT)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 7si7856891yxg.1.2008.07.02.01.32.18; Wed, 02 Jul 2008 01:32:20 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska@zib.de designates 130.73.108.11 as permitted sender) smtp.mail=prohaska@zib.de
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m628WCGC019112; Wed, 2 Jul 2008 10:32:17 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7]) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m628WC0K017527; Wed, 2 Jul 2008 10:32:12 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1214987532-23640-2-git-send-email-prohaska@zib.de>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87110>


From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, gpg outputs CR/LF signatures.  But since the tag
messages are already stripped of the CR by stripspace(), it is
arguably nicer to do the same for the tag signature.  Actually,
this patch does not look for CR/LF, but strips all CRs
from the signature.

[ spr: ported code to use strbuf ]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-tag.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index e675206..77977ba 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -241,6 +241,20 @@ static int do_sign(struct strbuf *buffer)
 	if (finish_command(&gpg) || !len || len < 0)
 		return error("gpg failed to sign the tag");
 
+#ifdef __MINGW32__
+	/* strip CR from the line endings */
+	{
+		int i, j;
+		for (i = j = 0; i < buffer->len; i++)
+			if (buffer->buf[i] != '\r') {
+				if (i != j)
+					buffer->buf[j] = buffer->buf[i];
+				j++;
+			}
+		strbuf_setlen(buffer, j);
+	}
+#endif
+
 	return 0;
 }
 
-- 
1.5.6.1.255.g32571
