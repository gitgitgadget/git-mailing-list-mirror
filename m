Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D258C19F2C
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiHAVEu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiHAVEt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:04:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC8537FAA
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:04:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j1so7199467wrw.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VAR9UTHwFlEDWsA+8b607AMTcpq+aL4eWw4TCj4lINA=;
        b=Eo5MJ5ZK4X21Cszbbr148w3K42cRrNu8jSC0olHN920Kb4lG2OAnnu9/5okdlCEsYL
         9JEX5t5qARPA48XWp8C8rUwlyABDGdxT10HB9tSRf35IiAOb7C6nYgY5G+ZEriGfLKht
         RNTMMEZvjI0SKpOcSVZ6YKq2Z4FTofFxcLJBFJp/mV/JerRiAom4DSHNRfjjJw60t8dx
         SqgfUf6NVh1yoJtLR3EQMadU+5FDy//sa5uUwmX63bROc+67nk+ljbHj43KCO0VtDRf+
         XUbVDBOiw86K1mnJzUBY43HAjqYJR+XH9VkQun4DZTgaJ+Ry/oxQWAJg1A4dLb/SUC20
         gkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VAR9UTHwFlEDWsA+8b607AMTcpq+aL4eWw4TCj4lINA=;
        b=00bAibGcAt0Eu5/zcFB8mo9pVNwT6bwsKNSxPwRKUo0k1HPqiVKmzd8GxTCmW+u5Kx
         LxTnmc7I0oa2EZmmFTYWwh3bZdPLZMPc84jNT3ThAGxnBDKevCgp5lAUiTSHbjTdxs5m
         faIrgyNjw2qLsOUfndn3uC/86QgpGkp/YnHz6L+MJPJeaH8di/x5vvGxKtXWNe8KXTsw
         y9+Ft+INBtN3delKwBlIah6Vc2yRAHKAH4YFifiLjZcTwQT9Gn/W6DC7648oyxPlan/7
         kXD/YrdIZOg+OLZdMc7K+zandp8tc3aCOBPlLJKZBl/4HubAauotvF6b0BLBo3uYxe0J
         gkzg==
X-Gm-Message-State: ACgBeo2zdAAUo7SlYvOUt3euwyyw3553uR568NuUcgH8HFKpFLE/xC+V
        U+j+j9kp6bwNcf5ZQS9Rm/tzKODz8sc=
X-Google-Smtp-Source: AA6agR5GSccZ345yu1tqGFnhYxvyaddAmSGWEvXRx5QUzlfx3tHVae6+fRqHPh2G3pxs74mDlUaB5A==
X-Received: by 2002:a5d:49cd:0:b0:21e:f8f6:5405 with SMTP id t13-20020a5d49cd000000b0021ef8f65405mr11211725wrs.451.1659387886984;
        Mon, 01 Aug 2022 14:04:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14-20020adfef8e000000b0021d6dad334bsm13069369wro.4.2022.08.01.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:04:46 -0700 (PDT)
Message-Id: <pull.1304.git.git.1659387885711.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:04:45 +0000
Subject: [PATCH] Documentation/git-reflog: remove unneeded \ from \{
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

There are some inconsistencies with how different asciidoc environments
handle different combinations of "\{<>}", e.g. these results were
observed with asciidoc on two different environments:

  | Input     | Output (env A) | Output (env B)   | same/different |
  |-----------+----------------+------------------+----------------|
  | \{<foo>\} | {&lt;foo&gt;}  | \{&lt;foo&gt;}^M | different      |
  | {<foo>}   | {&lt;foo&gt;}  | {&lt;foo&gt;}    | same           |
  | \{<foo>}  | {&lt;foo&gt;}  | \{&lt;foo&gt;}^M | different      |
  | \{foo\}   | {foo}          | {foo}            | same           |
  | \{\}      | {}             | \{}^M            | different      |
  | \{}       | {}             | {}               | same           |
  | {\}       | {}             | {}               | same           |

The only instance of this biting us is "@\{<specifier>\}" in
Documentation/git-reflog.txt; all other combinations of "\{<>}" (e.g. in
Documentation/revisions.txt) seem to render consistently.

Fix this inconsistent rendering by removing the unnecessary "\" in
Documentation/git-reflog.txt.

Signed-off-by: Glen Choo <chooglen@google.com>
---
    Documentation/git-reflog: remove unneeded \ from {
    
    I noticed this inconsistency as I was trying to build Git docs with
    Google's internal build system. This string seems particularly
    problematic e.g. you can see unnecessary "\" on
    https://git-scm.com/docs/git-reflog#_description.
    
    I'm not proficient in asciidoc at all, but I suspect that this isn't
    tied to the asciidoc version; I initially observed these differences in
    environments with different versions of asciidoc (9.0.0 and 10.2.0) but
    I can't reproduce this at all on my Mac using different versions of
    asciidoc and asciidoctor from Homebrew. Perhaps the issue is in some
    underlying library?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1304%2Fchooglen%2Fdocumentation%2Fbackslash-brace-asciidoc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1304/chooglen/documentation/backslash-brace-asciidoc-v1
Pull-Request: https://github.com/git/git/pull/1304

 Documentation/git-reflog.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 5ced7ad4f8b..db9d46edfa9 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -22,7 +22,7 @@ depending on the subcommand:
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
 'git reflog delete' [--rewrite] [--updateref]
-	[--dry-run | -n] [--verbose] <ref>@\{<specifier>\}...
+	[--dry-run | -n] [--verbose] <ref>@{<specifier>}...
 'git reflog exists' <ref>
 
 Reference logs, or "reflogs", record when the tips of branches and

base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
-- 
gitgitgadget
