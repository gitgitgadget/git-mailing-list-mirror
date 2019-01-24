Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA3B61F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfAXVwH (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:52:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45964 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbfAXVwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:52:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so5800033edb.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=phXU1dpxUp62jnnpSRXnqeaYcnvYczZREKAHf4PRcNs=;
        b=lrPbSCJ7JrvKA9V6fSqYz+P3IkGOxjlpbW/H+ITRrdCQGrumPgr4J6UQ2NYXt0ql27
         lL4OxXQoEympNVvPVyHWx0XMwdgo36ECdX8wKK2bOLTK8qnusjZoUnbhEc3CSVlBm/2Q
         +M4QOgy4BpgEjrd+ahKEG79z/eIhiDaCAAbtqYio9i230xwGAHa4mjx8nOzMKHckid0I
         x+iKyLRihBmVh63caQSmKBZalY/n02AVInTY0gWJusP1k62EoVLoPaKVFxPR/B6mIh5P
         qvjhjxfpCqSaigNbksGY1kwLZ4U6XD7DFgYao6OXhOhB7BlGavMt3zzLeqMBOYOV2+4O
         cxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=phXU1dpxUp62jnnpSRXnqeaYcnvYczZREKAHf4PRcNs=;
        b=Gc2SUf4CGbjyiPGY8MiodE1hBQs8UZav7zIN8/yVvoTq0sQojlO0jAMoA1K/V7UtYd
         8X6loNTWASI647opeHM2Lc5j/5ZtWZyyeAzCa/zZbYuLZ1qAAdcCY8q21Qpr2o2sFrz4
         G6HjheUMfrN3t97YH7vw3EjL7ZgWsvrJBXdnBdO1kNhKPGr9Omz1GzIaSX/A9rrmNMxV
         VGlon+vwWYDLligmI51Mx2h5hgxrYUJoK4nahtSo7GD+s4mi2jtPoXmfrDsGwhr7eoRV
         XrQCz0TvLft9TZbCGNZxz52aTbQ9LW8jSD6McUIBaaU4+YMYXDLNcLNlWYgYSPpUc96r
         XGjA==
X-Gm-Message-State: AJcUukdc96GMBzp0u97O4GKSVJli5zHBRckbclZQZ36BLhyRmbs1fHf6
        OeHU3qbMRO6vXcJsGs1nO60lEVlp
X-Google-Smtp-Source: ALg8bN7kC280x0eKhUk3NqPQYbDHcvzmWMSVm5rL3Up4EogSHwAyE0YdWw79sbC9m+EAor9R0famuA==
X-Received: by 2002:aa7:c594:: with SMTP id g20mr7780751edq.79.1548366722790;
        Thu, 24 Jan 2019 13:52:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k26-v6sm6333185ejv.59.2019.01.24.13.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:52:02 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:52:02 -0800 (PST)
X-Google-Original-Date: Thu, 24 Jan 2019 21:51:53 GMT
Message-Id: <481b08890fa633a61995300b7dd47979a0db53dd.1548366713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 10/10] midx: add test that 'expire' respects .keep files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git multi-pack-index expire' subcommand may delete packs that
are not needed from the perspective of the multi-pack-index. If
a pack has a .keep file, then we should not delete that pack. Add
a test that ensures we preserve a pack that would otherwise be
expired. First, create a new pack that contains every object in
the repo, then add it to the multi-pack-index. Then create a .keep
file for a pack starting with "a-pack" that was added in the
previous test. Finally, expire and verify that the pack remains
and the other packs were expired.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 19b769eea0..bcfa520401 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -495,4 +495,22 @@ test_expect_success 'expire works when adding new packs' '
 	)
 '
 
+test_expect_success 'expire respects .keep files' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-all <<-EOF &&
+		refs/heads/A
+		EOF
+		git multi-pack-index write &&
+		PACKA=$(ls .git/objects/pack/a-pack*\.pack | sed s/\.pack\$//) &&
+		touch $PACKA.keep &&
+		git multi-pack-index expire &&
+		ls -S .git/objects/pack/a-pack* | grep $PACKA >a-pack-files &&
+		test_line_count = 3 a-pack-files &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 2 midx-list
+	)
+'
+
+
 test_done
-- 
gitgitgadget
