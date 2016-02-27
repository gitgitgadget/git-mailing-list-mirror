From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/22] trailer.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:10 +0700
Message-ID: <1456555333-5853-20-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:44:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYbl-0003un-ON
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbcB0GoB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:44:01 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34913 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbcB0GoA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:44:00 -0500
Received: by mail-pf0-f172.google.com with SMTP id w128so16222701pfb.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uy44i+mRVTkQPRkni6Uz2538Gb2Q79gpGo7v91+dWRM=;
        b=NOaOM3iX3BWHnePXje9H8lB9+cVzY01hZmKGki/NZ/oHkCd4qklG9dcOSkffui3P+Q
         DOo7bYUo/lz23vokTmEdeCE/eVGJRFL7wR0pzcmEKlBBx9yCi1fE0FiGzaNoXeTYGvYp
         cSS6wwaUbB7cNxcMmpdfUFqIoAdJvY/wHwQCq5xINUn2FqO3Hzr/F0+aSZVcB93SnhY5
         GK8QyqZV4F2pS6d+P4OsYHaKXKhnJ0JCFJMNA4TBO83dv6eoWfyirzlhLIjFRM3un2os
         w0aB5Jmaiqtx3FxY1Hv/ay1ida9FnV8ANdfD+2guiF05C4V1KH5W0ovzduUtbDKOvCrx
         DoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uy44i+mRVTkQPRkni6Uz2538Gb2Q79gpGo7v91+dWRM=;
        b=ffsAU7xiYJSekuJZJ3As3+suzEZqG8yTQa4IVleuKMLtWejLw7PcZHZ1KHvtPdR3p4
         EcWPpegd1/IArKGKGfXkmL155DCiD7pFwdNYmq1uxnfLLCyrtJxE9PFH3ponACkJNQNZ
         epejDccR2lWeALzvdHBuL7Ul51bHpFnm0sFWuKRWfds5vg18+u3Qg3XHFePyrtoK88Nn
         eJfex4J3MXaV+tHxHAc9Y4AfeOtFRI4Vrn8aWCieMU7DqhElrzCEWROSh0HwYokxEijP
         t49vrMdqVf9jOlD6n9G/N8DUreGdaOUcEjia6MoLQm6I7Fr9jL3ej0RG18Azpf0rC9A1
         7T/w==
X-Gm-Message-State: AD7BkJJquhm8n5HZhsklb8/Rn5Yny4jVwPe14jpkoejoVSqs3IhjoPEH/tw89i4YG+UMTw==
X-Received: by 10.98.74.202 with SMTP id c71mr7633957pfj.25.1456555439657;
        Fri, 26 Feb 2016 22:43:59 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id c9sm23463044pfd.90.2016.02.26.22.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:43:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:32 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287680>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 trailer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index 94b387b..8e48a5c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -234,7 +234,7 @@ static const char *apply_command(const char *comman=
d, const char *arg)
 	cp.use_shell =3D 1;
=20
 	if (capture_command(&cp, &buf, 1024)) {
-		error("running trailer command '%s' failed", cmd.buf);
+		error(_("running trailer command '%s' failed"), cmd.buf);
 		strbuf_release(&buf);
 		result =3D xstrdup("");
 	} else {
--=20
2.8.0.rc0.205.g7ec8cf1
