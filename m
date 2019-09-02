Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 253401F461
	for <e@80x24.org>; Mon,  2 Sep 2019 14:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfIBOBo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 10:01:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbfIBOBo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 10:01:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so14143978wrd.7
        for <git@vger.kernel.org>; Mon, 02 Sep 2019 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=4n0KzmTPKE/1fVq3NZeDQYOS5nIVAjrXVLKVgK+DY50=;
        b=nCPvpuRoZRPJeT9W/6HUb4hVErW1jQQclFA9nBeijBEQAwh4InV7ZlCd28AMADhjX9
         /JXXMkYHWRukN7nlZUCvVpdfs5pRRRkEOi1PvZkBU3BwVXjmFsx9MzrscZf2TT4Uek3g
         2cpeMEEldUbDLJdC1MNJT6R8LTYmVOehS5Z9i8jiR71/8Iij27EkFloFgV51gGKrZY1B
         3F7cu6KzviRj4oZ3okHjvJ433CXBkcO99L+vGsmB4FrFpeGHhXPveU6Xcf543pMXBarc
         5NJebPKEGFXIkhf5W6035b5vr3tlrQ8+iNzVY606bYllbgAh5WB7vAWhrmS5yH0CGgUc
         3wEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=4n0KzmTPKE/1fVq3NZeDQYOS5nIVAjrXVLKVgK+DY50=;
        b=ZpTKsGi8e+YsVjieLfNH3HykoC3MFxI9PbBSjf2WqmEV7wnXEYMum3EX017vJRzEeL
         bl/RP6AfrDIVdbXFktEhSnw9f7Hf5vJ89xT81K3KIvaYJ5HoRrcQv9xwI7BTfVYJwKsG
         j7fiymwXwBl04+vOaqd8NGevaqNqJInhmtse8kCC8WfDNW0xibS6Fkt69EjqbNeayyor
         BgXO1mGHK7ENVx4Cmy1BMEajipR9ZqmsB6lMQfhTHJmhOZDKiltk2U/ROJPAU/3FBU3U
         b/3BN1zZovO3GXL3Ah+IL723U6CWiC5zAqqtpnQwIaoVG6C8XHgyeLobEKFY89i/MZl2
         FuLA==
X-Gm-Message-State: APjAAAU6vO0cZUrUikI8tBDFD2iUM0De50DyZ2rZGufa1hshhRQzVNTp
        ZRZXJWon7+sy+JfzpUyj8HYNyUUe
X-Google-Smtp-Source: APXvYqx2flv51DXef2/W7Y+Gn8Pd9vQJQu/kvM+93MxLmu9bklPB94V30SpwljQoqoVIz96nYwJRhQ==
X-Received: by 2002:a5d:6049:: with SMTP id j9mr11633546wrt.213.1567432902201;
        Mon, 02 Sep 2019 07:01:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm13862175wrt.68.2019.09.02.07.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Sep 2019 07:01:41 -0700 (PDT)
Date:   Mon, 02 Sep 2019 07:01:41 -0700 (PDT)
X-Google-Original-Date: Mon, 02 Sep 2019 14:01:39 GMT
Message-Id: <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.327.git.gitgitgadget@gmail.com>
References: <pull.327.git.gitgitgadget@gmail.com>
From:   "Matt R via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] rebase -r: let `label` generate safer labels
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Matt R <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt R <mattr94@gmail.com>

The `label` todo command in interactive rebases creates temporary refs
in the `refs/rewritten/` namespace. These refs are stored as loose refs,
i.e. as files in `.git/refs/rewritten/`, therefore they have to conform
with file name limitations on the current filesystem.

This poses a problem in particular on NTFS/FAT, where e.g. the colon
character is not a valid part of a file name.

Let's safeguard against this by replacing not only white-space
characters by dashes, but all non-alpha-numeric ones.

However, we exempt non-ASCII UTF-8 characters from that, as it should be
quite possible to reflect branch names such as `↯↯↯` in refs/file names.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 12 +++++++++++-
 t/t3430-rebase-merges.sh |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 34ebf8ed94..23f4a0876a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4635,8 +4635,18 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		else
 			strbuf_addbuf(&label, &oneline);
 
+		/*
+		 * Sanitize labels by replacing non-alpha-numeric characters
+		 * (including white-space ones) by dashes, as they might be
+		 * illegal in file names (and hence in ref names).
+		 *
+		 * Note that we retain non-ASCII UTF-8 characters (identified
+		 * via the most significant bit). They should be all acceptable
+		 * in file names. We do not validate the UTF-8 here, that's not
+		 * the job of this function.
+		 */
 		for (p1 = label.buf; *p1; p1++)
-			if (isspace(*p1))
+			if (!(*p1 & 0x80) && !isalnum(*p1))
 				*(char *)p1 = '-';
 
 		strbuf_reset(&buf);
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 7b6c4847ad..737396f944 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -441,4 +441,9 @@ test_expect_success '--continue after resolving conflicts after a merge' '
 	test_path_is_missing .git/MERGE_HEAD
 '
 
+test_expect_success '--rebase-merges with commit that can generate bad characters for filename' '
+	git checkout -b colon-in-label E &&
+	git merge -m "colon: this should work" G &&
+	git rebase --rebase-merges --force-rebase E
+'
 test_done
-- 
gitgitgadget
