Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB921F453
	for <e@80x24.org>; Tue,  6 Nov 2018 20:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbeKGGBt (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 01:01:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39203 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeKGGBs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 01:01:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so6749900pla.6
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 12:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OFmGrLCIj1kK2xRSNxHeh9T1AFomugvdYUBce4XI3x0=;
        b=oKyBOA8QvcBsjHQp/tKZhLc5YgNLz+5gUz/9Bb2V6okT9DA2izlcVuI9V25qY5ym6E
         Yk4/u7h3CarhlHTT41ISHYaOY2YYpBoG/ikGLLkvbUtEnZkR7YsElwTJgl1WeoJxr/r2
         Fh+q5baA8IQz2eH1yyPAMnEt648W8M26qVFMgVNFh7vL3Zex5mHxIwEpMfGIQIoZsa0N
         uwKmbbFDnVWrY8zbRxlLgttuqeQKI8z6YyBmCNYLNlztLHf3nWPOa1bGCFygR9oFL1Fq
         ykjjZKtHXWkmV0X5Ceju+c17bZpr/z7Y/hjl/4Mjexqf6t1mIdjMVn9uhYfzVXXzkFmG
         P3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OFmGrLCIj1kK2xRSNxHeh9T1AFomugvdYUBce4XI3x0=;
        b=dsZqasIQjKtFFO6u2iBkTxqvx6rezixqr7f18A7PdEEmEyKvZDsH87EjctL5b15yhU
         B6xwVbUTvMiZ74XIFOWXC1DovUcODti5o1CpZdNh+hUJLa75ac1b6i1vA+ohnd6ycbzY
         mDKguuuO3yf5oP3f+iC/OYeH/ZEgAHVxLLmQ+ZaR79RNdhsQlEdJo2avi0zc9zviugFw
         AIdklMEBaYjxQ7rrdWxzVb0OL0Efm0ihLmewwsNVFsX1Rs5x8KG9TWJZoREvppUybGOM
         KJ4yt3lrIjw2RwWVnnGJrsq4QFS0XRpmXw1RCrc/zoEO3IxDHxNS+7JKB6/fQ6CP8YrE
         aN1w==
X-Gm-Message-State: AGRZ1gIjDsRRjzLGfnx09uzlFXZCiKUvXEBBnf3/1ef7nw/44gU+q3md
        Ot5dazTzpAggaDzSMcD29sm58wULHVk=
X-Google-Smtp-Source: AJdET5cHJTxBGy6lYkWls1GOv3n+OncJ3Vzn3QeuZSTaEDHCa4G+XAZs4oGxZcW+KtzhjPsaIJn+EQ==
X-Received: by 2002:a17:902:e207:: with SMTP id ce7-v6mr2728702plb.47.1541536488284;
        Tue, 06 Nov 2018 12:34:48 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id b69-v6sm43005762pfc.150.2018.11.06.12.34.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 12:34:47 -0800 (PST)
Date:   Tue, 06 Nov 2018 12:34:47 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 20:34:44 GMT
Message-Id: <002868ee6bec3dac38749d0f05bf2db8da0969a5.1541536484.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.68.v2.git.gitgitgadget@gmail.com>
References: <pull.68.git.gitgitgadget@gmail.com>
        <pull.68.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] pack-objects: ignore ambiguous object warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

A git push process runs several processes during its run, but one
includes git send-pack which calls git pack-objects and passes
the known have/wants into stdin using object ids. However, the
default setting for core.warnAmbiguousRefs requires git pack-objects
to check for ref names matching the ref_rev_parse_rules array in
refs.c. This means that every object is triggering at least six
"file exists?" queries.  When there are a lot of refs, this can
add up significantly! I observed a simple push spending three
seconds checking these paths.

The fix here is similar to 4c30d50 "rev-list: disable object/refname
ambiguity check with --stdin". Save the value of the global
warn_on_object_refname_ambiguity variable (which is usually set to
the boolean config variable core.warnAmbiguousRefs) and change the
state to false. Do this only during the get_object_list() method
which reads the objects from stdin.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d1144a8f7e..f703e6df9b 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2988,6 +2988,7 @@ static void get_object_list(int ac, const char **av)
 	struct rev_info revs;
 	char line[1000];
 	int flags = 0;
+	int save_warning;
 
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
@@ -2996,6 +2997,9 @@ static void get_object_list(int ac, const char **av)
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
+	save_warning = warn_on_object_refname_ambiguity;
+	warn_on_object_refname_ambiguity = 0;
+
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
 		if (len && line[len - 1] == '\n')
@@ -3022,6 +3026,8 @@ static void get_object_list(int ac, const char **av)
 			die(_("bad revision '%s'"), line);
 	}
 
+	warn_on_object_refname_ambiguity = save_warning;
+
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
 		return;
 
-- 
gitgitgadget
