Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6899C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbiD3ERr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiD3ERn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E942E6AC
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id be20so11045305edb.12
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HBcX6rqXtDd+TlP6ia01fBwZnd/wgJlBYpq6GWguoM=;
        b=HMAAEPKoYph6i8YtChpX6/hYPWmavfq7StMOGVw9tDVElSspbg3HEtgvTs9P3bkZKM
         ciXBb9hgx4WGk0abySl+th/Zwf8Bjkjnhq9MkvYRiu7SVV//CIEDByxSa7lec3fNNAjF
         JDmROcT55Q7AqA65Xay3kVkrUdhdc2K0pP3sFu8n3gBAa8+botVhpbAJHjWdR2XrC8yj
         W4kmbqdtUtR61x0xHyQUOI0H16sISNm0/AZzt3t+0sW/cE7j+pgipHPTVYEKQ+S/sHqf
         lk/24SozdT64MmoKl83LHFKQ5dSeAYqSDLcOkP/9kyAr6fbfMELfO7a7GG2aDX3vM7SY
         1I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HBcX6rqXtDd+TlP6ia01fBwZnd/wgJlBYpq6GWguoM=;
        b=XBSBQui2nGT5Cm8Or+C0wxKeDjUsm/nggZmh7pcxlZ8suFCqIR4WkfGqUMhmWmJC1o
         ilm8kmPAApYDZ3zmaAX9to481oLvopqRsKOkQntrLC3B2pbFE2V6k5WAG4sxkZKO3wGd
         xozcG3/f7/HeeZRVbWvD/Z5aeXmD3y8VfkZPrSV5kxjp+cIPQfnxcAloBqeTr3LpTwzk
         kNG1313RgMF97Ms2CNVZCH1oSKzAXYKDXpVvhwz/nTdoxD7FXrq/tMAkZZUATMjEKoo5
         3xjOsDt3h0j+CYIC9xcklhB7xAiU6N5z9AiUmHIzIRpCMrtzdF927raKOxXNNARq7+Gl
         Ts6w==
X-Gm-Message-State: AOAM532nCW8w5q+v/lVoEGDC+93sq2TrwRuzcbSkhuUcw1gzpguoWq4+
        b9Rx4dishYuEPb6rCUgp1nPB+Th4/zY=
X-Google-Smtp-Source: ABdhPJwX9LT9L8VakX69Ap7alap9Tc3AnIxJKd1LfHYkZIDvg/zrXPf05uirUi3CXmhqzjinbFUpIA==
X-Received: by 2002:aa7:d842:0:b0:425:f329:33b1 with SMTP id f2-20020aa7d842000000b00425f32933b1mr2675197eds.74.1651292061884;
        Fri, 29 Apr 2022 21:14:21 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:21 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 02/23] apply.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:45 +0000
Message-Id: <20220430041406.164719-3-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430041406.164719-1-gitter.spiros@gmail.com>
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adhere to the git coding style which requires "Do not explicitly compute an
integral value with constant 0 or '\ 0', or a pointer value with constant NULL."

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 apply.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index d19c26d332..2b7cd930ef 100644
--- a/apply.c
+++ b/apply.c
@@ -3274,11 +3274,11 @@ static struct patch *in_fn_table(struct apply_state *state, const char *name)
 {
 	struct string_list_item *item;
 
-	if (name == NULL)
+	if (!name)
 		return NULL;
 
 	item = string_list_lookup(&state->fn_table, name);
-	if (item != NULL)
+	if (item)
 		return (struct patch *)item->util;
 
 	return NULL;
@@ -3318,7 +3318,7 @@ static void add_to_fn_table(struct apply_state *state, struct patch *patch)
 	 * This should cover the cases for normal diffs,
 	 * file creations and copies
 	 */
-	if (patch->new_name != NULL) {
+	if (patch->new_name) {
 		item = string_list_insert(&state->fn_table, patch->new_name);
 		item->util = patch;
 	}
-- 
2.35.1

