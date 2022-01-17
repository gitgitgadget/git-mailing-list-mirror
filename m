Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78B7C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 18:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiAQSSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiAQSSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 13:18:16 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7362AC061574
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 10:18:15 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso25720597wmj.0
        for <git@vger.kernel.org>; Mon, 17 Jan 2022 10:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gE7sJmn+R0d0ZBuSPuj+dMnfevdpYIn8250Ksupi5eM=;
        b=O5ff4taGK4SQeDx7qHeOUK5Fo3+OLv50vmgP/D6rLAiZAr5CX8y6Jw0Jk1FIUnkeBu
         +sAtt6XecOEwyqSSm304rQ6bGJTT5qtgNza7N0vcaV1dQp9E2hwsvwxjYO5qDzyHCTXR
         t73K/DH9q8W9LCkzh6yXYMmz6wXndam/PY4dn3/0vpvh04dS3SbN7/n1pcZA/0sDQ0fq
         RB51/FdaKKnSDyDv241IaX81E3vPhkgLYfjlGDi4KC8ivpTEFaP+CKDoxgN/Etvryg+l
         rf80dujp2mRcBUF32pTXjz5PUtQ1tTqPnQWsNa4iWoMMmmBu/F+3KsNQyLkMNGY3qsap
         LNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gE7sJmn+R0d0ZBuSPuj+dMnfevdpYIn8250Ksupi5eM=;
        b=4XP5vapUMv4fxIWv0UJXPWjl5cMjIDJUxgTQPZrpHOpHQQa41/VnO7VGWvHLGUVyPf
         Jlg1b7OdDuB32W3TkcwbjFBvB3BSWrjnKChAXnszO+dPnh3YA4WqQyw22mdkNahYdBZO
         SUuaNykl1vvNlcOjBY0CNVYuhdQc8/dZg0h763YtuKYn9jdFFRz5VV0nLHbFISK+2Y1F
         NRIbIGytI2sx41mgzF2rsDytNdDZPbYGNwRZRF/hCXq7goVHZTMwULeSMaMGv9AeiISy
         yDnhbvj2rmCV8zhqlEjC/+FhyIN/RSSKR8sLpke9NhPbkTTOG2ytL5Iz0OcZj5sJixvu
         O9cQ==
X-Gm-Message-State: AOAM530KwpEunG5FnSc9XBTtRiA7i6CSyGIUn0y5Pza5ZsF1QEZ+Au8A
        6bYULktoWG6ECZEL1MWq3IUzExwYL2k=
X-Google-Smtp-Source: ABdhPJz2SgKQqFAGdXMgH4fNgUq5hA78+M3g0MLn8aHY/7WZBDvmIhFXcA8X0tzczHd6W6h0D2qVsQ==
X-Received: by 2002:adf:d1ec:: with SMTP id g12mr13004082wrd.210.1642443493503;
        Mon, 17 Jan 2022 10:18:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm9026609wrs.97.2022.01.17.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 10:18:12 -0800 (PST)
Message-Id: <pull.1115.v3.git.1642443491609.gitgitgadget@gmail.com>
In-Reply-To: <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
References: <pull.1115.v2.git.1642349490723.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Jan 2022 18:18:11 +0000
Subject: [PATCH v3] README.md: add CodingGuidelines and a link for Translators
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.email>

Before being told how to submit patches, new contributors need
to be told how to code for, or how to contribute translation to,
the project.  Add references to the CodingGuidelines and the
README document on localization.

Also, split out the instructions to join the list and clarify
that subscription is via the majordomo address.

We use GitHub Markdown reference [2,3] with trailing empty square
brackets, to match existing text in the file.  On GitHub/GitLab
pages, the footer references matching the empty [] are not shown
on the web page. We could switch to using [text](url) form [1]
if we wanted to, but that is not done as part of this patch.

[1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
[2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links
[3] https://github.github.com/gfm/#example-561 (and the para aboveit)

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
    README.md: add CodingGuidelines and a link for Translators
    
    Also space out the list joining instructions and clarify the
    subscription via the majordomo address.
    
    Signed-off-by: Philip Oakley philipoakley@iee.email
    
    cc: Philip Oakley philipoakley@iee.email cc: Junio C Hamano
    gitster@pobox.com cc: Jiang Xin worldhello.net@gmail.com cc: Bagas
    Sanjaya bagasdotme@gmail.com
    
    changes since V2:
    
     * extended the translation 'messages' description
     * updated commit message based on Junio's suggestion
    
    changes since v1:
    
     * Used reference style links, rather than lnk [url] style.
    
     * added Jiang as L10 coordinator.
    
     * note: Patch is a response to a user question on the "Git for Human
       Beings" git-users list
       https://groups.google.com/d/msgid/git-users/aa68b9c8-4cf4-4193-8af3-79d7e3feafbbn%40googlegroups.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1115%2FPhilipOakley%2FReadme-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1115/PhilipOakley/Readme-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1115

Range-diff vs v2:

 1:  48cc30b7cc8 ! 1:  953a38091ac README.md: add CodingGuidelines and a link for Translators
     @@ Metadata
       ## Commit message ##
          README.md: add CodingGuidelines and a link for Translators
      
     -    The README.md does not use the GitHub Markdown URL links [1] of
     -    [txt](url), rather the reference method [2] of trailing empty square
     -    brackets. The references themselves are listed at the foot of the
     -    document. Those footers are not shown by GitHub/GitLab rendering.
     +    Before being told how to submit patches, new contributors need
     +    to be told how to code for, or how to contribute translation to,
     +    the project.  Add references to the CodingGuidelines and the
     +    README document on localization.
      
     -    Also space out the list joining instructions and clarify that
     -    subscription is via the majordomo address.
     +    Also, split out the instructions to join the list and clarify
     +    that subscription is via the majordomo address.
     +
     +    We use GitHub Markdown reference [2,3] with trailing empty square
     +    brackets, to match existing text in the file.  On GitHub/GitLab
     +    pages, the footer references matching the empty [] are not shown
     +    on the web page. We could switch to using [text](url) form [1]
     +    if we wanted to, but that is not done as part of this patch.
      
          [1] https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#links
          [2] https://gist.github.com/ChrisTollefson/a3af6d902a74a0afd1c2d79aadc9bb3f#reference-links
     +    [3] https://github.github.com/gfm/#example-561 (and the para aboveit)
      
          Signed-off-by: Philip Oakley <philipoakley@iee.email>
      
     @@ README.md: installed).
      +[Documentation/SubmittingPatches][] for instructions on patch submission
      +and [Documentation/CodingGuidelines][]).
      +
     -+Those wishing to help with error message translation (localization L10)
     -+should see [po/README.md][] (a `po` file is a Portable Object file that
     -+holds the translations).
     ++Those wishing to help with error message, usage and informational message
     ++string translations (localization l10) should see [po/README.md][]
     ++(a `po` file is a Portable Object file that holds the translations).
      +
       To subscribe to the list, send an email with just "subscribe git" in
      -the body to majordomo@vger.kernel.org. The mailing list archives are
     @@ README.md: and the name as (depending on your mood):
       [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
      +[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
      +[po/README.md]: po/README.md
     - \ No newline at end of file


 README.md | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index f6f43e78deb..7ce4f05bae8 100644
--- a/README.md
+++ b/README.md
@@ -32,10 +32,16 @@ installed).
 The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
 requests, comments and patches to git@vger.kernel.org (read
-[Documentation/SubmittingPatches][] for instructions on patch submission).
+[Documentation/SubmittingPatches][] for instructions on patch submission
+and [Documentation/CodingGuidelines][]).
+
+Those wishing to help with error message, usage and informational message
+string translations (localization l10) should see [po/README.md][]
+(a `po` file is a Portable Object file that holds the translations).
+
 To subscribe to the list, send an email with just "subscribe git" in
-the body to majordomo@vger.kernel.org. The mailing list archives are
-available at <https://lore.kernel.org/git/>,
+the body to majordomo@vger.kernel.org (not the Git list). The mailing
+list archives are available at <https://lore.kernel.org/git/>,
 <http://marc.info/?l=git> and other archival sites.
 
 Issues which are security relevant should be disclosed privately to
@@ -64,3 +70,5 @@ and the name as (depending on your mood):
 [Documentation/giteveryday.txt]: Documentation/giteveryday.txt
 [Documentation/gitcvs-migration.txt]: Documentation/gitcvs-migration.txt
 [Documentation/SubmittingPatches]: Documentation/SubmittingPatches
+[Documentation/CodingGuidelines]: Documentation/CodingGuidelines
+[po/README.md]: po/README.md

base-commit: 1ffcbaa1a5f10c9f706314d77f88de20a4a498c2
-- 
gitgitgadget
