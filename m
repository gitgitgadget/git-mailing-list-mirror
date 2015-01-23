From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 7/7] fast-import: minor style fix
Date: Fri, 23 Jan 2015 17:08:43 +0600
Message-ID: <1422011323-4278-1-git-send-email-kuleshovmail@gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:08:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc6g-0001yf-I5
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:08:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbbAWLIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:08:51 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:63449 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbbAWLIt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:08:49 -0500
Received: by mail-lb0-f180.google.com with SMTP id b6so6396794lbj.11
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xX8MA9yJuPMgS5WZIQ+jV05yUbqe4QJxLAuSP2Zay0Y=;
        b=BS/mKAmFH/EFYy4cJRyrD6oF/gaWIGlzzZiOeG20amiUlwiIgET6IGv+JcwTTbWLFw
         58OM9NL7a/jihUyvGldH6snZ2QFkTTU4HjRdGuBjUqyYuU/wu6Ez5nIdbLDrM8SNbvct
         5FbUZfQRhs0E+6iTgCZW+kOLbTuep5JTkejo6fXkHD6iTjKsXJ8b8XTfN3s7dXevU93X
         /9eYaxITueMK8YqMKH04uYRLtcZQw15u5wArsCU2fjtJ3zTJekIn9hFivsdIqB6v5jMh
         TwgtqBiaeaQcIbaCayNebFRuIPT0awxcR1yWCKICG3V3j2yupenGa2fmGqV1Oa0bnO3z
         ycfg==
X-Received: by 10.152.203.201 with SMTP id ks9mr6501745lac.57.1422011328216;
        Fri, 23 Jan 2015 03:08:48 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id bx11sm370073lbb.14.2015.01.23.03.08.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:08:47 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262913>

Asterisk must be next with variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 1b50923..fec67ca 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3110,7 +3110,7 @@ static void parse_progress(void)
 	skip_optional_lf();
 }

-static char* make_fast_import_path(const char *path)
+static char *make_fast_import_path(const char *path)
 {
 	if (!relative_marks_paths || is_absolute_path(path))
 		return xstrdup(path);
--
2.3.0.rc1.275.g028c360
