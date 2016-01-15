From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 05/11] update-index: move 'uc' var declaration
Date: Fri, 15 Jan 2016 07:59:46 +0100
Message-ID: <1452841192-620-6-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:00:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyNN-00050u-5V
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbcAOHAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:00:44 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36976 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336AbcAOHAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:36 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so10166315wmf.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u3kjS26z/GytTliBYDoXfMIuHjxH5jriuIndKgMr578=;
        b=kEaVy84M05U/MA3nL+S/mBsEz6I2I9yeGarHYkLenzqwZVupCcu8HxlCKeYrdiDtvP
         a7x6eHP9Ouv2cbaDPw3WozjIrU0NUnJTxi38U3yVzJ1X008k4kK6YezkAhT4/hL98+yh
         yazS6jvlSHTCdO6Kj7YUcK0DjYGO7hIfVs2/6OLBfSE8j0V4cpQfQqeKY23juYfqB10W
         ztH+kkfbZTDuuLGg3GGkxd8lUBZ2kCJpJ36i6QlH4Pb+ZY9IHfBMM67bYeZVAOQ2tKQK
         TAl1yD9xLfuziL57thu2vePoTDURmoLuOhdqpd+Noh/UjuhRhPkZO7SeipKrUrgdWvPE
         CcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u3kjS26z/GytTliBYDoXfMIuHjxH5jriuIndKgMr578=;
        b=lGEskvRl7/HteYluB7rwRVlbUvIOmGw6piDVAu6lf0qwZZPTdohTAOpCmepCTQ1pCL
         uzr3U3k1WY1LqYFjjn2zAPG50V7tV6xp0htFE17JHTKbvJD1ckmFtuRLSiSukGIgilkp
         GJ9Md8D3YFvPWyShdDk9IPbtmEW+26DJO/v1JnbGfot2yz5nWkq55rh9JTKRZs7fJyAo
         iYuw8UUJw+WdjLkz41PKTMf2aX4m8vdnyNTVDbMsBQJlJKh/RFDBIWNcy6q6uyH3aql0
         l5i7UnC/L80I9JRf+Iz747Vy29OPAE//Rhf3AqvdSIpNXhxLNaQ8DceG5+KgA1FbOMvt
         nhSQ==
X-Gm-Message-State: AG10YORzmWHEssVlGU9YFSRXe2oSceNwgyQejLHasq+QJlMZu8bjW+oL3n6A/EUsbd8wRA==
X-Received: by 10.28.127.85 with SMTP id a82mr1633459wmd.48.1452841235554;
        Thu, 14 Jan 2016 23:00:35 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:34 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284145>

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
2.7.0.36.g20612a7
