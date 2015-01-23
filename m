From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 3/7] test-hashmap: minor style fix
Date: Fri, 23 Jan 2015 17:08:08 +0600
Message-ID: <1422011288-4062-1-git-send-email-kuleshovmail@gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:08:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc69-0001cE-UE
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318AbbAWLIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:08:17 -0500
Received: from mail-la0-f45.google.com ([209.85.215.45]:54802 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbbAWLIO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:08:14 -0500
Received: by mail-la0-f45.google.com with SMTP id gd6so6658250lab.4
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cI4KBP3NGcQnRjhxuTpwvQfI2oeLr/+pqadpIvu0k/c=;
        b=uY6qcb5hH+AY3TsZ3LT9g9pdYz8x12CaB3wcaIWBYjcJpafXr1fpKcVMy4EV/vxAbr
         eG63h1n3Ch6tg3zXAahSuJ/P88ij1ItWkrWcuIL6Ii9/U0aJ4H/NcKkgMdUyP+euPSKZ
         sp48MduV0utYb+0u7Mv/giXiO+qF9hjTwmJ4I/g+hhc+wbw8+VlnTtqBXq0Z3qnCCUs3
         NFZ/74+7Jll48MxAqSlPlNl+TwwfrEH2wMVv2k0o2a/y5S01czP98OrXg+WV5te5gt8F
         o7BpboN44gzqJWMy06oYK/rmWQNCyeO5XJMgYPy5eNGXY6b0eyPxStXW+RDi4NxVPxRx
         3PQQ==
X-Received: by 10.112.167.136 with SMTP id zo8mr6731614lbb.17.1422011293174;
        Fri, 23 Jan 2015 03:08:13 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id o1sm365065laj.29.2015.01.23.03.08.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:08:12 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262908>

Asterisk must be next with variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 test-hashmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test-hashmap.c b/test-hashmap.c
index cc2891d..5f67120 100644
--- a/test-hashmap.c
+++ b/test-hashmap.c
@@ -14,13 +14,13 @@ static const char *get_value(const struct test_entry *e)
 }

 static int test_entry_cmp(const struct test_entry *e1,
-		const struct test_entry *e2, const char* key)
+		const struct test_entry *e2, const char *key)
 {
 	return strcmp(e1->key, key ? key : e2->key);
 }

 static int test_entry_cmp_icase(const struct test_entry *e1,
-		const struct test_entry *e2, const char* key)
+		const struct test_entry *e2, const char *key)
 {
 	return strcasecmp(e1->key, key ? key : e2->key);
 }
--
2.3.0.rc1.275.g028c360
