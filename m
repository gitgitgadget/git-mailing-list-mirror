Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EF11F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 01:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfH1Bnd (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 21:43:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53532 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfH1Bnc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 21:43:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so956275wmp.3
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VoA3/1ekUbnnzxIt+TuVbhfhub7U8UKuBQ9h9U7VCfU=;
        b=WTwAd+YgH1PW7nU/sGo8YI1/BkVO1cbGjF30OzeaTpSbB2J8UdGSv96v/DbchfQnlS
         +oM6fSXDlN8qrdzj6Gn2t31K9oJmRWvS8vlT6yJRHzl2zqmWCZp1/l2ivpq7PTPx1+oW
         jFrZZv3HHM0SA47Cdw3McjsWy9pFdquP7HdOhdYqxQ4H4hjg/omz1K5UQ1snpt6H+9Fd
         5OCg20y5PjeBxBD+Y68yyp/UTYGFaWXz2Qm3IL7HZ3JaPtEjwQqaaX4wYL9M2ZFWX9F9
         ktmHFeBugwy8FLbxIeGBJyYo9sfeJvgYObMzBrqqA7nCAqgfCau/KPKdSJXnqHpWgnLP
         MKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VoA3/1ekUbnnzxIt+TuVbhfhub7U8UKuBQ9h9U7VCfU=;
        b=Ndgqtnqlhe5izPSBZPZHwJ+2+DQ4Z2FjN83XgaUoeV9sX3KfCaY1e6unraXHwBZozy
         6eH+MMVhFpvOXFy1SPHFjIms+7wd6TOOxPGJaQxcSBRS+w2rTFdRWjsEozoSGcNoqBLh
         NY4tJO2v6x7xCK1iYPMBfDXwnFosmxSUhw4S+CoRD4LSQZFHfitC6xDQ6oGcCH+lh5HW
         SdNNZkPvWJbKsegxmSIVgvz5kPfdk0M618Co9vyHU/Abk6uZ3jgcDTVjV5Zals1aYXDO
         hjq4Ts54vtINRUnVueflmxgVnqY3v1S5dqlaPv2FbJu5bcvkTaXsVYZCh7F9SCD+iUzG
         NxuA==
X-Gm-Message-State: APjAAAVYjiv0vdz41SujGDrCKvYkIJZLMhZlPdSMCcP0CYFtiDrfgKX8
        n8GEzv2Bj+H/NEPe/0FkhT519hY5
X-Google-Smtp-Source: APXvYqxFGVzjc7x/4Ln7nkQWCVSZgnPR7BVo64McsBr0uKPTHC73DBd3vzvj17B5/F9YqQ9g+uZ88A==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr1277841wme.134.1566956610256;
        Tue, 27 Aug 2019 18:43:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8sm762617wmi.7.2019.08.27.18.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 18:43:29 -0700 (PDT)
Date:   Tue, 27 Aug 2019 18:43:29 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Aug 2019 01:43:28 GMT
Message-Id: <5c313aba7e97cb93e7d07f6d5dfaf0febe8a2f8b.1566956608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.324.git.gitgitgadget@gmail.com>
References: <pull.324.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] upload-pack: fix race condition in error messages
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Test t5516-fetch-push.sh has a test 'deny fetch unreachable SHA1,
allowtipsha1inwant=true' that checks stderr for a specific error
string from the remote. In some build environments the error sent
over the remote connection gets mingled with the error from the
die() statement. Since both signals are being output to the same
file descriptor (but from parent and child processes), the output
we are matching with grep gets split.

To reduce the risk of this failure, follow this process instead:

1. Write an error message to stderr.
2. Write an error message across the connection.
3. exit(1).

This reorders the events so the error is written entirely before
the client receives a message from the remote, removing the race
condition.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 upload-pack.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 222cd3ad89..b0d3e028d1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -613,11 +613,12 @@ static void check_non_tip(struct object_array *want_obj,
 	for (i = 0; i < want_obj->nr; i++) {
 		struct object *o = want_obj->objects[i].item;
 		if (!is_our_ref(o)) {
+			warning("git upload-pack: not our ref %s",
+				oid_to_hex(&o->oid));
 			packet_writer_error(writer,
 					    "upload-pack: not our ref %s",
 					    oid_to_hex(&o->oid));
-			die("git upload-pack: not our ref %s",
-			    oid_to_hex(&o->oid));
+			exit(1);
 		}
 	}
 }
-- 
gitgitgadget
