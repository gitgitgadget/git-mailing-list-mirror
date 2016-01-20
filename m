From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 05/11] update-index: move 'uc' var declaration
Date: Wed, 20 Jan 2016 10:59:38 +0100
Message-ID: <1453283984-8979-6-git-send-email-chriscool@tuxfamily.org>
References: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpej-0007tL-Qm
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933795AbcATKGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:21 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36055 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758229AbcATKGN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:13 -0500
Received: by mail-wm0-f49.google.com with SMTP id l65so172188909wmf.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FeCUmZot09gaPMNEbIyNpDxeOcdptaf3rWSqS6FJDn4=;
        b=KfOnVIHHxgq6k/KRAGjyjv+Yfv1q8WD31jh0uRb0XPmpPeaSJ+fYc3K7OBWHBbT2xL
         RufWs4KH3Vf68nm79gUsG+OE0HY3B7bjItOI5FS1Xb2ySWbcuLUjdw1/s2i14lqs+gf+
         sKV5jqZRjFnIB+VYmh6XzN2Cz994s2zmNklxApte6iraClpaCxHBvbe9VahqDyjHHyFg
         7nhRGyD69isbmlf/QP3qasHnUi5HO6f5hTtzMhHBe5jTUXkGCxX3rgsCnzkPEIjF13FF
         vYwPYIBqA7eF7EwAmKXJI7QyL7vJ/9hQdAEQymLO/aSrFDKl7iF4N1n1POk7Krmxn+r1
         d6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FeCUmZot09gaPMNEbIyNpDxeOcdptaf3rWSqS6FJDn4=;
        b=h6NxrBwWm4aS+f0mljk19xpOJI1+3Gpo5Od/WmMmbs6BatfkiPBkBEiehFHWc3o9Kw
         mQrDjD/NjPzOZz4x2EBJGmHIG7Ojb77tofdyCZjrPRwdESmjh7wd0omMi+UnBWQK55+U
         b1+7uqn46jKHwTgo3Tnt6waxecyJOaaSFKjooyoXnwz/BTGXYc2OFDeEaujxLkZTQlG9
         Oi6DJWKogThhQrOoc9hmZ7UJnTRsM/zHcu6f60+cBgdhZ1HRPkUk+vA20L1EOggAp+oB
         GaBL2z2qpTQCHUTmZHuQIa11N0Sin8Q6f25WXzL0CzjRCEjfIqhq1jdeXG1n+ZB7H6qP
         Dfaw==
X-Gm-Message-State: AG10YORwiC91Hrvk3kPJRTWMOTbdVrXTwncvzDmluw/SznkT1F/KtaJO7PAwqlMh6o+QOg==
X-Received: by 10.28.189.11 with SMTP id n11mr3159253wmf.3.1453284372722;
        Wed, 20 Jan 2016 02:06:12 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:06:11 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
In-Reply-To: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284436>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 369c207..fe7aaa3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1116,8 +1116,6 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
 	if (untracked_cache > UC_DISABLE) {
-		struct untracked_cache *uc;
-
 		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
@@ -1126,7 +1124,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				return 0;
 		}
 		if (!the_index.untracked) {
-			uc = xcalloc(1, sizeof(*uc));
+			struct untracked_cache *uc = xcalloc(1, sizeof(*uc));
 			strbuf_init(&uc->ident, 100);
 			uc->exclude_per_dir = ".gitignore";
 			/* should be the same flags used by git-status */
-- 
2.7.0.36.g6be5eef
