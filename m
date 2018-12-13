Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDEC20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeLMVX0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:23:26 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45810 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMVX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:23:26 -0500
Received: by mail-qt1-f193.google.com with SMTP id e5so3879167qtr.12
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fja8K5LmfMs13uRZ+FONl6J6+s955BVNqg9xzknmhSg=;
        b=tW2MEmc4SZ05EYZK/UzkppB+HyJaux8qmqNdE3HcJyCt4xfQ07dZqyrRVkvCn+RPd0
         1whY7RCo52SmcvWwCulbuTi8DbGQFMLdOfWtp7HtajULJuHKHcscoZ5RQyfZRWC+YjET
         LR4cctSfyY/IL0qaYIggv6V3h5vkja3wWHXq/QMFM5SytFrBKew+TU/5oMpHtbj0QBpa
         BwVh2FxRR5Fvywk7FUZF6pwnNFPKCy8QCtsydPqQ+jL3XOFtvQPF8TvUntM3Vb+Sf/Gd
         e4H//GQ+YTZUQ2K6fo5x9WABHAxbzHv2q4qYbUlN2IwFd2Uc2RDPxhihCWd6yx3IAyKq
         gF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fja8K5LmfMs13uRZ+FONl6J6+s955BVNqg9xzknmhSg=;
        b=mIDWHTxD85acsK9VSngifmfnMhrtGaVGgZmf0J4JxjyWy408Z441Jb6sT0izyHfjrV
         fglwRIBN6wypu2vJ5EyYxDk9bhaWltMErwSHX9CCET26SJ4UFFvrlIgXLZldjS3w0PY1
         WDhH4sHnBxRZ3DLa+IDVCxMPHFz9RG6mAbHL3HszfEn+uPhmLd7mHEfhxtFzAMbiCTCZ
         KFgH5ix6BxPnR+V/KSWmm6UceBMqbnIIyiIRSOZFDoAkj20Mcedk1664Kf0nFnNY4eD3
         K+Kowb9K8n/7l3BvdM2Ploqr4DpfXZtSTLQBjBgRqxAxpxhg0yzJZtDRZ5mEmAonhR6d
         WGSQ==
X-Gm-Message-State: AA+aEWYNfYhKl1NB5TOGjEEgAcDAP63mP57gHlOlCxlCS6pxfxybDLLZ
        8nZRbygTB8hE2TrNLsDv2bd0RacQ
X-Google-Smtp-Source: AFSGD/XUargmSuIHcUjqGrCPkpiTB9p1JiNBibsUw/OyzzRvlQPY8BySpPSvHDlFSx/tk3PeAaVLGA==
X-Received: by 2002:ac8:35eb:: with SMTP id l40mr408776qtb.165.1544736204567;
        Thu, 13 Dec 2018 13:23:24 -0800 (PST)
Received: from localhost.localdomain ([142.154.219.74])
        by smtp.gmail.com with ESMTPSA id f13sm1552840qkm.52.2018.12.13.13.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 13:23:23 -0800 (PST)
From:   John Passaro <john.a.passaro@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, alex.crezoff@gmail.com, peff@peff.net,
        mgorny@gentoo.org, John Passaro <john.a.passaro@gmail.com>
Subject: [PATCH 4/4] docs/pretty-formats: add explanation + copy edits
Date:   Thu, 13 Dec 2018 16:22:56 -0500
Message-Id: <20181213212256.48122-5-john.a.passaro@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213212256.48122-1-john.a.passaro@gmail.com>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify description of %G? = "U" to say it can mean good signature but
untrusted key.

Make wording consistent between %G* placeholders and other placeholders
by removing the verb "show".

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 Documentation/pretty-formats.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 4a83796250..32c2f75060 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -147,18 +147,19 @@ endif::git-rev-list[]
 - '%GG': raw verification message from GPG for a signed commit.
   This and all the other %G* placeholders, other than %GR, %G+, and
   %G?, return blank if GPG cannot be run.
-- '%G?': show "G" for a good (valid) signature,
+- '%G?': "G" for a good (valid) signature,
   "B" for a bad signature,
-  "U" for a good signature with unknown validity,
+  "U" for a good signature with unknown validity (e.g. key is known but
+  not trusted),
   "X" for a good signature that has expired,
   "Y" for a good signature made by an expired key,
   "R" for a good signature made by a revoked key,
   "E" if the signature cannot be checked (e.g. missing key)
   and "N" for no signature (e.g. unsigned, or GPG cannot be run)
-- '%GS': show the name of the signer for a signed commit
-- '%GK': show the key used to sign a signed commit
-- '%GF': show the fingerprint of the key used to sign a signed commit
-- '%GP': show the fingerprint of the primary key whose subkey was used
+- '%GS': name of the signer for a signed commit
+- '%GK': key used to sign a signed commit
+- '%GF': fingerprint of the key used to sign a signed commit
+- '%GP': fingerprint of the primary key whose subkey was used
   to sign a signed commit
 - '%gD': reflog selector, e.g., `refs/stash@{1}` or
   `refs/stash@{2 minutes ago`}; the format follows the rules described
-- 
2.19.1

