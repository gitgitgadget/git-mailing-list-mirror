Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB9DC43219
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376644AbhLBSng (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376430AbhLBSnc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:43:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B09C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 10:40:08 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q3so700574wru.5
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 10:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jA2SVtXqn+u0233wQxvaNn9NKHl97Jzpp83rxUSYsyQ=;
        b=XRkxaeSBzukvwaKJ+PVXRAgY5q8oImlJghDX32SsQQktVETdEEgSjuJIrCP8c15vpi
         BScQRkXcejCQnuTM9iQ7fWT5GzlEBkwZ2XynrGn51gtg8/0LP5Iw41q2AQ9PFU8Ba/78
         mDeArwtk7qFzRGGvX0dFEtOp0JImA3JAG3Z8JXpDiXrkW2QyPqxNVoNmUf4CQV9vcUeU
         NtT42Nt1Ix9qAVGazBi2z8OJQ5dCttjtf77w1NvogfQCSz/xn0gsOXuLalTido0OUD62
         YdeETmiYYGXoBBPirbAFYqj2fBo6RK5mC+n2Apeq3ApdJ5t3d4pk3lo0HKbVovJnysPA
         H+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jA2SVtXqn+u0233wQxvaNn9NKHl97Jzpp83rxUSYsyQ=;
        b=0QC9dCRbLAf5bHF8PlJBYGVLQGKAi6TMVyFq3HVfU+Z3QIAeddzPWmYcrcV43orRMP
         iD6Hb9cBsWn9dIqmd3IMJy2mgN+cw2/TUf4SmE3rCPnPpjNU4UVZIG2qKz3/HCNWvEMn
         Hov8sNS55+C45nCL8B5cJEjTJaRehYn6qX+8CEPDXYP2BNNjgaFNaCK70Xk+zVKpQciX
         4mpGFXjFi63128PStAPpcvg8p6ut0rK0TMsvJmladQvMFPLuQE6u7Q5BdxR7PdTPSSVM
         fZyeslgey1autA9ViRi9GetARttgC73/fNZ1tK/8LlOyFyCFGaP5yu+CGgf81qDMMEFt
         +ZNQ==
X-Gm-Message-State: AOAM532Als0l1xPAH+bI4ODb09G/jOtuEdOrN2eEfvi69PdFDozj7B5e
        r6RA/hJVebifxMaBBqZfCE46etdk5EI=
X-Google-Smtp-Source: ABdhPJyYAhi55aARZB9tQed7VE7Iv3dDIUtF0ikwvV7OAUhBTCpzYJq3wBUraoxtqg6FFnZ+7f/50A==
X-Received: by 2002:a5d:42cf:: with SMTP id t15mr16256263wrr.444.1638470407421;
        Thu, 02 Dec 2021 10:40:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm3858658wmq.46.2021.12.02.10.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 10:40:06 -0800 (PST)
Message-Id: <466b4451015dfe4b2631f378dbf9631c04240f53.1638470403.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
References: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <pull.1147.v3.git.git.1638470403.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Dec 2021 18:39:58 +0000
Subject: [PATCH v3 4/8] refs: update comment.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

REF_IS_PRUNING is right below this comment, so it clearly does not belong in
this comment. This was apparently introduced in commit 5ac95fee (Nov 5, 2017
"refs: tidy up and adjust visibility of the `ref_update` flags").

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4b14f30d48f..37329b98cca 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -16,8 +16,7 @@
  * This backend uses the following flags in `ref_update::flags` for
  * internal bookkeeping purposes. Their numerical values must not
  * conflict with REF_NO_DEREF, REF_FORCE_CREATE_REFLOG, REF_HAVE_NEW,
- * REF_HAVE_OLD, or REF_IS_PRUNING, which are also stored in
- * `ref_update::flags`.
+ * or REF_HAVE_OLD, which are also stored in `ref_update::flags`.
  */
 
 /*
-- 
gitgitgadget

