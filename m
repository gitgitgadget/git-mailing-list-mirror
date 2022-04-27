Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11ACC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 19:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiD0TQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiD0TOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 15:14:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4B8F1B4
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:54 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v12so3766008wrv.10
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qMzPqCYiUBQQGIgQIGR8vgq8/L7GJ52bPFf1vWQ6S00=;
        b=aEEUy2X30AvwjCJol4UVO8G2qeSullXzjREJCBKumHUS1+dBTOYLPbPrBuk3dxz2nE
         Otn4ivLI5zoDIIfHYFGbBBDupR01luT8hT5GaRiUEgWhuwELaW1F3D5sE+GpaQR0jhQP
         Qk8Xsc/5HQNWK3YfGOxUbaL6p/H0hEbjMStEdmfJvd9WjS2nzmvZWRkwpoPSkXe8Cqet
         P2VkvVW8cvAdPFLfbeP61Dif0pV2lD6bs0QJP2qL4bGqW6rJxWdN6gf89otigrnrsQJJ
         jn92uLBvBBHFJq7d7KA9yCUb4gYxqLD+hjB3JWL7ptL7aYzwD3Cv7s+MwdO+9x66hot2
         3tTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qMzPqCYiUBQQGIgQIGR8vgq8/L7GJ52bPFf1vWQ6S00=;
        b=xivxFa3u+uRpdGDy5jv7q3Bl15lNeI/gfResAVExV4MSbTNcAoE7VsAZnrCWszPknL
         U7xJK1IPb1NOipAsTTSTDpsnX7Ew3lzxPGJkwLvsRfmnZJIvb/dtfePQez4H3hUG0lgP
         bP93J9PtuRNFo67Z95gHQuaUYtOpfRBNd92Xc9zT+oZASGft39LFRlflDwKGzCekHH0+
         Hv9TJWFo3Nwav3gXluHSRfgXbwOy0nfTpM1/5ZQrmF5CqOJFb8NdBeV0CG3ptnGlneNX
         NIjyL7yXXYhK6yQA4lTrPbDOA0NEq88UYXsghr7xFHwVMNrTLP31pzk9QxINjJUdVinN
         L9/g==
X-Gm-Message-State: AOAM530O++xik4HE+bax7DtxAV0hUCv0oLL7NeP74P76+z7OJFmZ9Yn2
        eg7Zu009yZaMGHsWYARKk1jjj9DVVBo=
X-Google-Smtp-Source: ABdhPJwrJHhchEZ5Iste1DWfNHxfw4Dp5++Q+FWm81NgTSoc8BPQS5uSlAQ3qv44FpJCBNajhQg5BA==
X-Received: by 2002:a5d:6d50:0:b0:207:c10e:911 with SMTP id k16-20020a5d6d50000000b00207c10e0911mr23730104wri.137.1651086292553;
        Wed, 27 Apr 2022 12:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r10-20020a7bc08a000000b0039049f8b3f9sm2110742wmh.27.2022.04.27.12.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:04:51 -0700 (PDT)
Message-Id: <7e84d5b286de9dddf28ef1c8f38c7d7c28e266f0.1651086288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 19:04:46 +0000
Subject: [PATCH 1/3] MyFirstContribution: move cover letter description to a
 separate file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

In a subsequent commit we want to reuse the explanation of the purpose of
The cover letter form the "Sending Patches with git send-email" section
in the "Sending Patches via GitGitGadget" section.

To avoid text duplication, move this explanation to a separate file and
include it in MyFirstContribution.txt.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 .../MyFirstContribution-coverletter.txt       | 18 ++++++++++++++++
 Documentation/MyFirstContribution.txt         | 21 ++-----------------
 2 files changed, 20 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/MyFirstContribution-coverletter.txt

diff --git a/Documentation/MyFirstContribution-coverletter.txt b/Documentation/MyFirstContribution-coverletter.txt
new file mode 100644
index 00000000000..b9e1e10427a
--- /dev/null
+++ b/Documentation/MyFirstContribution-coverletter.txt
@@ -0,0 +1,18 @@
+This is an important component of change submission as it explains to the
+community from a high level what you're trying to do, and why, in a way that's
+more apparent than just looking at your diff. Be sure to explain anything your
+diff doesn't make clear on its own.
+
+Here's an example body for `psuh`:
+
+----
+Our internal metrics indicate widespread interest in the command
+git-psuh - that is, many users are trying to use it, but finding it is
+unavailable, using some unknown workaround instead.
+
+The following handful of patches add the psuh command and implement some
+handy features on top of it.
+
+This patchset is part of the MyFirstContribution tutorial and should not
+be merged.
+----
diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 63a2ef54493..681bbefe9cd 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -976,25 +976,8 @@ filter their email for this type of flag.
 You'll need to add some extra parameters when you invoke `git send-email` to add
 the cover letter.
 
-Next you'll have to fill out the body of your cover letter. This is an important
-component of change submission as it explains to the community from a high level
-what you're trying to do, and why, in a way that's more apparent than just
-looking at your diff. Be sure to explain anything your diff doesn't make clear
-on its own.
-
-Here's an example body for `psuh`:
-
-----
-Our internal metrics indicate widespread interest in the command
-git-psuh - that is, many users are trying to use it, but finding it is
-unavailable, using some unknown workaround instead.
-
-The following handful of patches add the psuh command and implement some
-handy features on top of it.
-
-This patchset is part of the MyFirstContribution tutorial and should not
-be merged.
-----
+Next you'll have to fill out the body of your cover letter.
+include::MyFirstContribution-coverletter.txt[]
 
 The template created by `git format-patch --cover-letter` includes a diffstat.
 This gives reviewers a summary of what they're in for when reviewing your topic.
-- 
gitgitgadget

