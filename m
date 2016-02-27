From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/22] builtin/config.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:41:56 +0700
Message-ID: <1456555333-5853-6-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYa7-0002uC-B2
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:42:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942AbcB0GmT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:42:19 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34234 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914AbcB0GmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:42:18 -0500
Received: by mail-pf0-f176.google.com with SMTP id x65so63880576pfb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ye4ev7PyXKXBBhrM4dvyn1wZsXZ8R/OLVOqnnGboqnI=;
        b=zf81AZ7AJJTwAHT0wEiRn6YjoxIDzKuO953LCOWUj1eFlJ/+W1KvhSDVbzT+/6KwWu
         hIFhFwPiv1V0rZb2gOzYpYtOrSsoNeK7taU2ycOtl8hjXD5O1MJNtJ795EeyLxzb+/X7
         3kgi1SKCi+m+pIUHDV91J1b2knAoZUPWUsessp2U9+3oasfBv1K30zHYnXRyZogplO8V
         2XJiOjexsZMSdxKyU5gCAy2b7izObTcNv7wTm4lcbXldPCfR8Rmw+auvC4itRP/Gqxhi
         vgV1QwQUXRitjbOhMjNEQ0D11W0uoacvZgr2s9rZC4kZj48ElgubNmVHkoxhIqOYs266
         u7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ye4ev7PyXKXBBhrM4dvyn1wZsXZ8R/OLVOqnnGboqnI=;
        b=AiZvNMvLJILf6KyZSCuUqLdoB72SP2P/ZKTtH5pVJDot4BRSk1jY5jh2h5f/NEOagy
         /Ohrymnjf/YTeZGSMD++NO5vqnBqTw+kq3ionNP9DrJuwKUej9USDY1BTPeTUmxPzBii
         l9m364DoscJPMUgO6BWIQONzP+oUAgOXSCZSTw+ysFIRM1ldctSiJ5NphUyw1bPtWYoE
         wPDcDcKRKP0+heFDjUBDr7JRwcxiOWHOWgfPAy8NmlvXuAR9fTr9vDaTJNsoRMrw5QtD
         JqANZw4R5UgCmq3IRapnwt+4XcYw4/QJKPkq/MeLz4SHHNUbyxax62q0I4C5KSeY9zji
         JVog==
X-Gm-Message-State: AD7BkJKevHrWQS1N6A1/YuvLvGzMl0hqI1oUOq68OFPkLv8E5NLIlzXLc0kCIKhvHNY0Dw==
X-Received: by 10.98.11.134 with SMTP id 6mr7705925pfl.109.1456555337672;
        Fri, 26 Feb 2016 22:42:17 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id t29sm23501879pfi.8.2016.02.26.22.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:42:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:42:50 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287666>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index ca9f834..98ca43d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -378,7 +378,7 @@ static int get_colorbool(const char *var, int print=
)
 static void check_write(void)
 {
 	if (!given_config_source.file && !startup_info->have_repository)
-		die("not in a git directory");
+		die(_("not in a git directory"));
=20
 	if (given_config_source.use_stdin)
 		die("writing to stdin is not supported");
--=20
2.8.0.rc0.205.g7ec8cf1
