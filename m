Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F13C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbiD3ERx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240814AbiD3ERq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:17:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F056F3B02A
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y3so18664886ejo.12
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qIphQNVs8nfUWPJKoherI+7RHJsYeZLgJ+i5HFIOLGg=;
        b=jwQi0ySidkpTqXs/khe0i+KEJ9lH56BtovSmtWYwLz/4CA1a5NH/XFWSgNMQi98kxW
         PqT+IQGQl1AfgOGZt1YnMcW8lLi0Uh0Q7eGsEq+tBXNGHG69PX1FBfs5ECZ1XzWy9JNA
         hZg69MW95oTUZysmfp6T0j8hyBDPrU/TxtXnzv9snlhf8WH61Wa1hi+vJtYJWntqx5lW
         0FEQ4PNI9ID96GUd1qxCNhqtv6MLGuUi6RGdTuKwgtHnQv0qp5N4aCshKuSSF3KR/9F6
         bKFsq/YTXl9e8xsR8/5YZnS0wgyD0x1URPxGqCCBS50lWYeh0vyvh5CtSTJsX/TVbZ9f
         vDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qIphQNVs8nfUWPJKoherI+7RHJsYeZLgJ+i5HFIOLGg=;
        b=3YY4o6kFwDGNs88EyC19uQHXDXkE18mjFEKs5uD5sG0a7o6cSyf87OW+F0FK2QqJep
         u/TTINPtGmbdcHNWaELnoXvGGfrMfW+dDCkp3OQXggk1P18XibgjOy3hAkw+chd9hmti
         RGb8DAnU/pgQJzjLSbarN7zMf3xMc5Kd0Irebn2+wMHjYw02E71OHKtMOSgkK7E91nFC
         j6VBnmy3rCxyZtrmEyLKXOCyFts34UQHakBT0fOowzLu6B+dDDVJhttU+uIz0AyozqLU
         PPrjTyh8eKxOKXXtUlDmWNzCSowGMW3/4lENtfkAUqSxJAFs7nblgFyzzT6jZouU5fg/
         qZyA==
X-Gm-Message-State: AOAM530dinHyeL8R4NOW2rrcFkVkwAXneDXAlqg9DsbEIOufXp2tgKvL
        ajRHCElk/8mE0LWA0ajac/DogsBxBq0=
X-Google-Smtp-Source: ABdhPJwz5sKSC8TuUAwS2IdLVu+SxPgMAS/+RcJhil1CGHntF9pijWsscWOAdZNIKu8chhz4FY2vjg==
X-Received: by 2002:a17:907:7810:b0:6e7:ef73:8326 with SMTP id la16-20020a170907781000b006e7ef738326mr2293541ejc.429.1651292064303;
        Fri, 29 Apr 2022 21:14:24 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:23 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 04/23] blame.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:13:47 +0000
Message-Id: <20220430041406.164719-5-gitter.spiros@gmail.com>
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
 blame.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index 186ad96120..da1052ac94 100644
--- a/blame.c
+++ b/blame.c
@@ -1072,7 +1072,7 @@ static struct blame_entry *blame_merge(struct blame_entry *list1,
 	if (p1->s_lno <= p2->s_lno) {
 		do {
 			tail = &p1->next;
-			if ((p1 = *tail) == NULL) {
+			if (!(p1 = *tail)) {
 				*tail = p2;
 				return list1;
 			}
@@ -1082,7 +1082,7 @@ static struct blame_entry *blame_merge(struct blame_entry *list1,
 		*tail = p2;
 		do {
 			tail = &p2->next;
-			if ((p2 = *tail) == NULL)  {
+			if (!(p2 = *tail))  {
 				*tail = p1;
 				return list1;
 			}
@@ -1090,7 +1090,7 @@ static struct blame_entry *blame_merge(struct blame_entry *list1,
 		*tail = p1;
 		do {
 			tail = &p1->next;
-			if ((p1 = *tail) == NULL) {
+			if (!(p1 = *tail)) {
 				*tail = p2;
 				return list1;
 			}
-- 
2.35.1

