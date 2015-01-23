From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/7] clone: minor style fix
Date: Fri, 23 Jan 2015 17:08:00 +0600
Message-ID: <1422011280-4007-1-git-send-email-kuleshovmail@gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:08:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc6T-0001pq-PD
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbbAWLIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:08:39 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:48786 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbbAWLIG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:08:06 -0500
Received: by mail-lb0-f174.google.com with SMTP id f15so6447069lbj.5
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S2x6uHJqBMxukXUk5nc2XeZRKXLqpBv929TNXvbJZL8=;
        b=PMYlBf9IjD+fYILAcFXavpEhQ8uXLo3ZTZo9K4W4y8KChWrcj+z6c5AFSnjb5gMNlZ
         b2msvipKrPZs/amO4q1RBM0Hj9VjKi9tnnTjftus6oNVKtLY/UjR7GlAp1+v58PRGDtb
         9aHr00qHvKFIUnKyfy1C+QClqaZB/MU3pYdbTzzJcowyO8Q8aNrtceXxQkAwXBfCcte9
         m7Rfz4qptbYp9fC7y6sjG9pjChU6tthCPeT7tVsovZqqov36aYM49g1ocKxhXnMhUjLb
         OFjvi8Szm0N4KddFlYihUAiIrIbYHVaB2Jz8ESPZkCBH4MMAe9QZiag4R214BPNO4aGn
         LRkg==
X-Received: by 10.112.129.228 with SMTP id nz4mr6665275lbb.8.1422011284909;
        Fri, 23 Jan 2015 03:08:04 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id v4sm370543lbz.12.2015.01.23.03.08.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:08:04 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262911>

Asterisk must be next with variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index d262a4d..a1ca780 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -741,7 +741,7 @@ static void write_refspec_config(const char *src_ref_prefix,

 static void dissociate_from_references(void)
 {
-	static const char* argv[] = { "repack", "-a", "-d", NULL };
+	static const char *argv[] = { "repack", "-a", "-d", NULL };

 	if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
 		die(_("cannot repack to clean up"));
--
2.3.0.rc1.275.g028c360
