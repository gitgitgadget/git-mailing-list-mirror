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
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C471F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfKFPvX (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:51:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51725 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKFPvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:51:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id q70so4106219wme.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1MERttk1qWaqxfrCV4b8uDP13mKag0juDEFZYceBm7s=;
        b=oqACggT9ofSgkODLwSNJ9WdBHNuSvfXqxR15PrjMN4GtEIQUXnWge+G7Pu1OC3FaWS
         lOUXS3G12nvdg1jQnLIUTHYyfUms3EaKCmWa3xadCTWk2xlej9J6hXgudGWVuZ1bP8IH
         WZJnlw6YPCRZcfblTUYpte3ZirzZFS/TMXeTsbP64nS5mOCf/fRifn12j6hDgpPy0hxb
         aEdjDuBKkIF0b6PQmDqkmc7RihPYCE/b4O5NiAr12D30l/7Qo+luhNkPKxHuELbp4Fxm
         5Qmte0p0e5oyxLag7y/m4zfT+Nry5SVuuVkLWbJPYZ0sf1an/FqI8Rzze4F6K/y4yjfV
         wxug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1MERttk1qWaqxfrCV4b8uDP13mKag0juDEFZYceBm7s=;
        b=DsQmg8UXuS2w3stfL/JV/543rfveilZ3h6o9R2io8TohQzLxhm8gAm3HGMtZTTP1Mg
         e7BRa00Xe/RCQDtmVHk8Fo+s6DESwPVFk0IQkVERy56mhY3VIpB95QJoPsl+8jGS7fpo
         iN0YqG+RjAN/rzqB4Aj6oam1vbqhX6o4JrFPIJgGtfXmXPKfpi3OZ5ljcbKJT1hV71ue
         nerg7YwiEztT0FQhEFJUHem+SOEwQ21r/c/jJ/NculhAW6mxYSW+TRGaZRs+hOOejA44
         dvZMZsG9sldg/ypXvcLxLx8QP2OXonNX28nJFeCT6OMwQRW6eO+XFO9vaoSCa2+0fpVQ
         0V1w==
X-Gm-Message-State: APjAAAWppcEnk+44Xlx4hAAke1GXDSq1UfymDdPAYeOCPDMHtOg2jzZo
        GdRrAZ+a4dnfx0n1qg26c5KojZgd
X-Google-Smtp-Source: APXvYqzwG9/Pidka5lnWF2Uz3XeThvfgI/WT8E4vqp6JPeSAVaKFzVZxyFlFgxYIMaMBTXh8WhfMdQ==
X-Received: by 2002:a05:600c:12:: with SMTP id g18mr3364719wmc.44.1573055480330;
        Wed, 06 Nov 2019 07:51:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q17sm2831663wmj.12.2019.11.06.07.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:51:20 -0800 (PST)
Message-Id: <2dfaccf0d5c7b24f522a9b215f4a6f1f31f85253.1573055478.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 15:51:13 +0000
Subject: [PATCH v2 1/6] parse-options.h: add new options
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

