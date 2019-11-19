Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2D41F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfKSQtF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:49:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36240 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbfKSQtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:49:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id c22so4540398wmd.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1MERttk1qWaqxfrCV4b8uDP13mKag0juDEFZYceBm7s=;
        b=jBg+/lgbzreERGLwr8mIYK//GkVEzmUhMg53ZZ4r7WDfUMRbZJ05/QD9V38JhcacHO
         C40AIY9I9kHSBF41UMJ6/2Xcp80igp7BwdQstpx2T4kdDIv9kLS7gxM4zBYmXFITKuqL
         NgXRSacuJ79LqyDz6GRhR64IGDums/tQXQk1yj0NpTBK5GyyXOd7ASYv6x56+3aeFJOz
         a+ZbfMJkbQiWwJsclFWDjwplVx3aIS2/xnNYgnRJQCBJVCaaNnfW2p+TIh00XGcE2nGl
         FSeZpLqA3P4A3Zyl3s9e1x/CP4FR9kUEp2LoKefrjI5KZ3JVXrUbh3cyNTOWN+X+J86e
         wOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1MERttk1qWaqxfrCV4b8uDP13mKag0juDEFZYceBm7s=;
        b=QdEdtW6Say6LWvqp6IpSe+4DSZjZGgdo48LUlO3tTyeayueB0KA9sttnRbhc9iEZ3Q
         19esV86hObjdcGTcU1l3/dXPs1Rx4Mcle9SgB2eG/rWhegg9X0Kwh0K2ZXwjVbcg4278
         slwIOyxQQbVj0UGFs83T3vId+MZ0QOaGkte4bik7H7aaDvtdtDAqKarWsZLwt//22xVN
         DzT7/SCvaWX0tYNj8eaxlq9mH12VkejeEc5BwM/efxW6//z5HAGix3f75kIcIgPMWlj1
         EiNB/HyGuolzuxIehooY1koy4DGmzjPQfaljrZ2CKkxphYEcqAET53LaqyQ1FIA52Wvp
         NDIw==
X-Gm-Message-State: APjAAAW8MbontfSCDTNlLw/WaB/PT/FZXoEpFmYc/8aMKU1yZiP7KpKv
        cYJtEEOMrmwAW4D7eo5Hqyk4x1r23uc=
X-Google-Smtp-Source: APXvYqxNIsXnB5AxYjULyh9+U+Z0yKuTyuD5l5NgKt6ImkErcPbwXWNQMMTklTgvPrJrDNf0zjSkdw==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr6852646wml.102.1574182137583;
        Tue, 19 Nov 2019 08:48:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z2sm15932101wrs.89.2019.11.19.08.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:48:57 -0800 (PST)
Message-Id: <19b80326ead8bdc44b5d8ca951feb3d6c1f5493c.1574182135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 16:48:50 +0000
Subject: [PATCH v3 1/6] parse-options.h: add new options
 `--pathspec-from-file`, `--pathspec-file-nul`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Support for various porcelain commands will arrive via additional
patches.

`--pathspec-from-file` solves the problem of commandline length limit
for UIs built on top of git. Plumbing commands are not always a good
fit, for two major reasons:
1) Some UIs show executed commands to user. In this case, porcelain
   commands are expected. One reason for that is letting user learn git
   commands by clicking UI buttons. The other reason is letting user
   study the history of commands in case of any unexpected results. Both
   of these will lose most of their value if UI uses combinations of
   arcane plumbing commands.
2) Some UIs have started and grown with porcelain commands. Replacing
   existing logic with plumbing commands could be cumbersome and prone
   to various new problems.

`--pathspec-from-file` will behave very close to pathspec passed in
commandline args, so that switching from one to another is simple.

`--pathspec-from-file` will read either a specified file or `stdin`
(when file is exactly "-"). Reading from file is a good way to avoid
competing for `stdin`, and also gives some extra flexibility.

`--pathspec-file-nul` switch mirrors `-z` already used in various
places. Some porcelain commands, such as `git commit`, already use
`-z`, therefore it needed a new unambiguous name.

New options do not have shorthands to avoid shorthand conflicts. It is
not expected that they will be typed in console.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 parse-options.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/parse-options.h b/parse-options.h
index 38a33a087e..c6cc01e715 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -330,5 +330,7 @@ int parse_opt_passthru_argv(const struct option *, const char *, int);
 #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_OPT_HIDDEN | PARSE_OPT_NONEG)
 #define OPT_CLEANUP(v) OPT_STRING(0, "cleanup", v, N_("mode"), N_("how to strip spaces and #comments from message"))
+#define OPT_PATHSPEC_FROM_FILE(v) OPT_FILENAME(0, "pathspec-from-file", v, N_("read pathspec from file"))
+#define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
 
 #endif
-- 
gitgitgadget

