Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8BCE20248
	for <e@80x24.org>; Sat, 23 Feb 2019 23:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfBWXjK (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 18:39:10 -0500
Received: from mail-oi1-f201.google.com ([209.85.167.201]:35315 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfBWXjK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 18:39:10 -0500
Received: by mail-oi1-f201.google.com with SMTP id k131so2250534oif.2
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 15:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wCVUwNQVo4WMTFNY/XTveqJjtkcujZ4JIRLnyb/al3k=;
        b=doBcs0VKfSzuZbjasAanNwkhbjqcdlrGXz082uYO5GLTXpVLEvgFycE4E2Co4s5r96
         0f03A0sVMT6y3F5fzHMNawy23BOxhK4uYc3Y8EkpTne5PkIC5NJFc6WNnZnIDrzyY1Hd
         Z1tIML75InftU9OaTB+EYc+7l2mcK5YsNy+tukFdMqbC2Qu+gR6metqVI2pkxED0PsOK
         WzUte+7ZQwDqwoZS62Bg6lDNC4lkyb4lopAioaDbuQlywuk5Xqez873dtx++1DYqm0Zs
         CoOI1WfR+LrcXLKhXtAjLJj7Gm7zFj4l5Mx7QCLlM5c+YLb4EK0UPMWkbif4NZNKdNoX
         PLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wCVUwNQVo4WMTFNY/XTveqJjtkcujZ4JIRLnyb/al3k=;
        b=gBTi9Yytf0jetVCD2POE8BP7YNs9idFdAYu6OHRoybIdHPYl+nvi9LNQYRSTtkPydT
         Ea3R35ilAdsEWmEJUppgK+ysQd0QPasXP5wliq2B9XYDfxqShEYRXWX9jJYUmmoVJExn
         Fo7AC/fOHfQ4dl2mTSu7uWmQCpRiCEy7lbt2bKPza/wJPfELl1g0IUNCd+4V0kuVne/w
         4u8civOiPsjpGWdgXD/H7BvcvlCXQLsCOiiEAocnovYPuIJinBhfzPU34Bjh81p45NKu
         1liOq49Fo5fmsAccjB4LCPjccLbgcAYNRvaN5lT3BSulygpIfpbp3l0A+nPj5rCiO8kM
         qZCw==
X-Gm-Message-State: AHQUAuZgtWg67rPMXqi87WLTeOa/ZMlOfZpX0j+CvSUpA+TQUuNW1DKt
        ouMyaeip1CBUYmfbcf6R24z/CBdvuKgtxlBMT8RwE/jzdFJGrR0ybX6NA7qsouyZeB1aJfQjnGf
        b/4CjPbI80u0SaOyZINKCSHHQmj7HczLiANMRTKOGLDMc6/ui3FVivCe2EqA1CP9+kRxxOAzYj1
        oW
X-Google-Smtp-Source: AHgI3Ib/TjnRDlHpdkXKzMI/DuqN2KdyS95ybiLkjie6tUq2Xwl3GLR+B9vMG0nYH0HXVYqoYRGxOEON/s8kD8+FnFOZ
X-Received: by 2002:a9d:4913:: with SMTP id e19mr6993208otf.67.1550965149132;
 Sat, 23 Feb 2019 15:39:09 -0800 (PST)
Date:   Sat, 23 Feb 2019 15:38:56 -0800
In-Reply-To: <cover.1550963965.git.jonathantanmy@google.com>
Message-Id: <3304894f269fae63b6cb9d3f2c81906236556e86.1550963965.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 2/7] http: improve documentation of http_pack_request
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

struct http_pack_request and the functions that use it will be modified
in a subsequent patch. Using it is complicated (to use, call the
initialization function, then set some but not all fields in the
returned struct), so add some documentation to help future users.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 http.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/http.h b/http.h
index 20d1c85d0b..1aa556257e 100644
--- a/http.h
+++ b/http.h
@@ -202,14 +202,31 @@ extern int http_get_info_packs(const char *base_url,
 	struct packed_git **packs_head);
 
 struct http_pack_request {
+	/*
+	 * Initialized by new_http_pack_request().
+	 */
 	char *url;
 	struct packed_git *target;
+	struct active_request_slot *slot;
+
+	/*
+	 * After calling new_http_pack_request(), point lst to the head of the
+	 * pack list that target is in. finish_http_pack_request() will remove
+	 * target from lst and call install_packed_git() on target.
+	 */
 	struct packed_git **lst;
+
+	/*
+	 * State managed by functions in http.c.
+	 */
 	FILE *packfile;
 	struct strbuf tmpfile;
-	struct active_request_slot *slot;
 };
 
+/*
+ * target must be an element in a pack list obtained from
+ * http_get_info_packs().
+ */
 extern struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
 int finish_http_pack_request(struct http_pack_request *preq, char **lockfile);
-- 
2.19.0.271.gfe8321ec05.dirty

