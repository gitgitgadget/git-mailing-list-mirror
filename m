From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/16] shortlog: add missing declaration
Date: Thu, 31 Oct 2013 03:25:37 -0600
Message-ID: <1383211547-9145-7-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbocR-00087Y-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644Ab3JaJcp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:45 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:56501 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3JaJco (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:44 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so2738687obc.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q1xqmEKhP/laqz6hAmwNVC6Vgt2VI4P9dBxWwVqRywk=;
        b=jpi9qcBq9yZxZsoGfcR7udQTEVBRZuG9aKPtOV1/L1MFUNKt2oC0b67BqBxwZXKicI
         J6/cicgamqZltjPjfCWEIKLPnwz9XphujKzXrrJYaO61/oA/pTu5Y0fEuxzrui/YKtKr
         PAQVNdnoaHYE3lxzSGRgjW9IrQ83THtV+ekbz1T21z9nWV+gLu0uWsmJlcMoGPn7+wGO
         vGfYi+sgPXwHk1KHqyKZWPW7eVwQeX/q/5mXUJUWcWrRPUnZeFPEAgvRukWM4n56a16z
         DRcnke3svuix9irL5zAbkh5FB9DzeNG6i+0HHtfBQDT9RV2zBWRXwKAT6V9qSOWUpJIZ
         uPmw==
X-Received: by 10.182.80.196 with SMTP id t4mr1854913obx.1.1383211963573;
        Thu, 31 Oct 2013 02:32:43 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm4461908obb.11.2013.10.31.02.32.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237088>

Otherwise we would have to include commit.h.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 shortlog.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/shortlog.h b/shortlog.h
index de4f86f..54bc07c 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -19,6 +19,8 @@ struct shortlog {
 	struct string_list mailmap;
 };
 
+struct commit;
+
 void shortlog_init(struct shortlog *log);
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit);
-- 
1.8.4.2+fc1
