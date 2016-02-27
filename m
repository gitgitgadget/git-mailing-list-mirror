From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/22] run-command.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:07 +0700
Message-ID: <1456555333-5853-17-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:43:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYbS-0003ij-I8
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088AbcB0Gnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:43:43 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34191 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0Gnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:43:42 -0500
Received: by mail-pa0-f44.google.com with SMTP id fy10so62467767pac.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1bhW64SWkIvLVbBumyCDtT4aHuA9Y0dyiMVc77jRGE=;
        b=FI1wvvuLH9hK61BtN/buIxzBXbujC9LhuBD7nczXyCE1y6HzKoWq+bhNV0qCG1XQ/e
         JxloI5oKvrJ1yqGazTRJwaGcVGx/4wsMVUQXh7+3mbtsxeOIjq/VnC+OFfv/3CiIS8n4
         e6H+48hDLR3baTVY0AwdX++gik9jWyS3Oe3vIqMIUCanIqmIw6nnA/wygAAbayNjZ9c7
         K3voWyCtsI+LVzfFKjNbTL4xJstNz619irucNvbHGIhh8mljrQFb9sZcWWFEbbvWZxn0
         JgSKNnVxznZl54L8O5uxuGmAAUuBrMsjzazf09XqigQjFvTb7jO74avs5T+qLJufB0c4
         BwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1bhW64SWkIvLVbBumyCDtT4aHuA9Y0dyiMVc77jRGE=;
        b=myIk40uKLtM7a+klX3RP021Rg2PnGQAgnGSd3Txb+2Aite+43GYgZ6p58+k1Z2Fq1L
         Fr7a+bE7kGtdv5LA42+wKuWgSfuRU4oRl/Ljh46Oruhp8D9SFtpEbQJjiJHQIfG31z+K
         QHUTxgDzsp1djgHwhP+o5gtYvmmW4z4tekrW00unyN5BNbf50aFtDADnW9ymLniWyHrJ
         v77qQKVM+WmyiJbFBAwIrqJ0ZZqjrFO98zOzKbJvx59XlohW79T70PEE+lk9LkCYOLyX
         Des7l451LuiV2CML96OUEtHyg3UHU4Gj6Ymlp4wl0aD3fV9+3Eyn3SJDTCSv4U4X1FLP
         pUBQ==
X-Gm-Message-State: AD7BkJL8xxvF8StdGRH5Shmzmte0/Sz3vHvnKg4Q0O+P9ENHceI2zo1fDWpIeVD30j8nlg==
X-Received: by 10.66.252.100 with SMTP id zr4mr7403453pac.111.1456555421688;
        Fri, 26 Feb 2016 22:43:41 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id g74sm23508144pfj.1.2016.02.26.22.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:15 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287677>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 run-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index 863dad5..1ee2357 100644
--- a/run-command.c
+++ b/run-command.c
@@ -909,7 +909,7 @@ static int default_start_failure(struct child_proce=
ss *cp,
 {
 	int i;
=20
-	strbuf_addstr(err, "Starting a child failed:");
+	strbuf_addstr(err, _("Starting a child failed:"));
 	for (i =3D 0; cp->argv[i]; i++)
 		strbuf_addf(err, " %s", cp->argv[i]);
=20
@@ -927,7 +927,7 @@ static int default_task_finished(int result,
 	if (!result)
 		return 0;
=20
-	strbuf_addf(err, "A child failed with return code %d:", result);
+	strbuf_addf(err, _("A child failed with return code %d:"), result);
 	for (i =3D 0; cp->argv[i]; i++)
 		strbuf_addf(err, " %s", cp->argv[i]);
=20
--=20
2.8.0.rc0.205.g7ec8cf1
