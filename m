Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8F7C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 04:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382280AbiD3ESx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 00:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382200AbiD3ESU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 00:18:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22526EC4C
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so18705092ejd.9
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 21:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QE/YLZL58y62duz985hH08qBW8eN5v7mL80zpClgAcA=;
        b=MGF4MS9HuHWocS3CLOFeKl/koXPJb0JWX88KSQGm7ldARv2s1jQ2POwjYUsFgRPcDr
         94TIJA4SqXZDm1EvgPFPzm0Meigih+tfqEszqnF0mbnl7wZJGtfVfKrbTwY8vQdw860B
         JEbAq+JQwCQnTI+w9qTfP2WXm2hpclMQKI9Xo2ZTZRwToLOv/ZZua7PkU7eyFmSqMD/q
         chTsRaK8g6IC6Sgh0Jq089626HZpWVA2FmSotyNY/rIDj/B3O4H9TLUXzYO1oQlSCVEe
         WsBAsneIE7Y3dIWkz3GRRtpVoQEbN6GRGV5IiE2tCG4Ko+qDRT7Xbj60uR5s+eD9LNFg
         bPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QE/YLZL58y62duz985hH08qBW8eN5v7mL80zpClgAcA=;
        b=khQn8tkKZLYcyRk1zj/OYVdSnTH3WByqZSOgoX9+GH+0Utbm8pubKjaUwJLelV80Sa
         PYguoUVyf6BgYnM+wBsYojjbXDqR/8xVlJk1Lgu8gKlXJ4qPklGUF54lFPQm4hFXzt91
         NmsUsbTr115/V2xZujxC3U7dFoBLENmj9SeLj2sjpg9WDlU6ZGqkM0uNra5q/bApHYDJ
         K1FQpNQ5IaRy0ljtXmggKc38lskdy1UEXj2ZsFy9ObHo+WTym46l+iqI82bBfSFnKWGB
         3fL5dTGJgL+ZO2hkrk8reVDcvdpz3KnMgeAi4uMm3gf7ibTek0HD6vff50oOV0tTSzkw
         7kpA==
X-Gm-Message-State: AOAM531Ykh0RgzWiCTgrs0188liAteJYMyaa3kD0nEX4xxIo51HGb+3q
        K7qlFGhWGGxiOKiHcNlZaU4k6Ehj5qg=
X-Google-Smtp-Source: ABdhPJwOenkdHiFmc+GG/myEtbCT1fxxJDsa2Hjn8fKRr8ZsGZZxUKEaEGZxCyRSqvW8gHJhSfdFoQ==
X-Received: by 2002:a17:907:3f1c:b0:6f3:98ab:4735 with SMTP id hq28-20020a1709073f1c00b006f398ab4735mr2357205ejc.547.1651292082992;
        Fri, 29 Apr 2022 21:14:42 -0700 (PDT)
Received: from fedora35.example.com ([151.27.248.133])
        by smtp.gmail.com with ESMTPSA id og47-20020a1709071def00b006f3ef214e79sm1243586ejc.223.2022.04.29.21.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 21:14:42 -0700 (PDT)
From:   Elia Pinto <gitter.spiros@gmail.com>
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 21/23] builtin/tag.c: Fix coding style
Date:   Sat, 30 Apr 2022 04:14:04 +0000
Message-Id: <20220430041406.164719-22-gitter.spiros@gmail.com>
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
 builtin/tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index e5a8f85693..75dece0e4f 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -364,7 +364,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		strbuf_addstr(sb, "object of unknown type");
 		break;
 	case OBJ_COMMIT:
-		if ((buf = read_object_file(oid, &type, &size)) != NULL) {
+		if ((buf = read_object_file(oid, &type, &size))) {
 			subject_len = find_commit_subject(buf, &subject_start);
 			strbuf_insert(sb, sb->len, subject_start, subject_len);
 		} else {
@@ -372,7 +372,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		}
 		free(buf);
 
-		if ((c = lookup_commit_reference(the_repository, oid)) != NULL)
+		if ((c = lookup_commit_reference(the_repository, oid)))
 			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
-- 
2.35.1

