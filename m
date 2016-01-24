From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 05/11] update-index: move 'uc' var declaration
Date: Sun, 24 Jan 2016 16:28:18 +0100
Message-ID: <1453649304-18121-6-git-send-email-chriscool@tuxfamily.org>
References: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbg-0000zo-2K
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbcAXP3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:29:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36302 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbcAXP2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:49 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so6785571wmf.3
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GuZrc5rauXIK2ruihj8DbSC+5GkcSmvyk6iH9Yp/eIQ=;
        b=bxdgtHI5b6e34tm2pekQXJIopiTu6tMkWv5lZrQjD6kKIA4Hr8Ice4m1nzjUIz86Jw
         ozE09k1rkz0dL+sqElOb23esCKvRoLfo5Y1yFBRBPNTQmza0irECbRPmc5vAu5RBP1+9
         xnBKwo91mbpiP7Ot9X40zkqVTPfoFr4z+O2ij2i0fR4NKpUTkllFSemN0Y+Jb59QA3Dg
         kWWbJm2Gr5QN8la3/V42Komvt9yB9hH8H4RUyUn+9xW3gogmnsua1BCPoTo2r8HKjLcq
         Wndj48+Kv17F80fzOpSymQ6olTKstgTaz3xHEeDNLYyTqKJQNnojkIm4C3yumfYEefXV
         D/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GuZrc5rauXIK2ruihj8DbSC+5GkcSmvyk6iH9Yp/eIQ=;
        b=d8lf3/GNfWBBd9JT4TlZlZdi4T0xq5rNuca4vARrcFLu8xPG+yHL9MddNJgWrSTC2B
         TCVsyLGzmQVgeH3km4LtDAo/2UblYwweViUTg8qzdORIv2oEh+bY9vDqeTukpjgYg2ij
         2pLQG0A2AJieNN6/CMmchGeZsLj6a4IrkOROJNrWWIT1qLl7RJqhJpNkH3J3Rzc9Y+5z
         FBybeM0ahtuikfzr7f3SSLPQLK7tsTVyehUE59Vcbul4QBWavfETmPopVTLlzrjZdWGC
         LhkSkFLNwh3cVNe84hwKtcg/wtNMrGvPur57GbJhtMgO8eyxPq+aGEL5SQ0CwQP+VJXh
         jhYA==
X-Gm-Message-State: AG10YOQv1CWpKP+7z1vN4YZfUr2BhiYyqxI7KmhbYvYs2TTRezRlal7H4m7IbC4oOp6HlA==
X-Received: by 10.28.90.133 with SMTP id o127mr14517934wmb.101.1453649328337;
        Sun, 24 Jan 2016 07:28:48 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:47 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
In-Reply-To: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284656>

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
2.7.0.181.gd7ef666.dirty
