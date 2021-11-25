Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE74C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356442AbhKYQM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356391AbhKYQKy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:10:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D22C0619DF
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:56:05 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v11so12579079wrw.10
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PSFgT9kvFOoMZ0ZTJJHfE++msvyiVThB9xsajCaHxPA=;
        b=GIv4nxkmVKw8UaBVaHgsLX5WVyxiVKOaURdmjlcFXSjcqOrwo3owmqvhpm8G2O06Mb
         IxgVHIg6kcJOcm7qfFKvTeA8jsRpzOf5jy7ihAXcefjMaeQbgC5ANKjScZQEJxfHp+ge
         jjDi/1m22iRuextOf9qbPz3OyNnv+8CZlGJzn5R2JPTmVN7TY+CNWyN0BG0sLzvmqeOO
         MskRsnB9NTHnoypO+1uhmOUFl1q+x6Iwc04RrCOf5rNcN+DqINqo/SRw7tUzwoFhIiXO
         9Jmu4h7oQ8Cn2D7I2XcWUTcmnVuMJtBd9CUMfLMdqQBjsXMOtcyuY+TJGGqJiMBAJrUT
         bhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PSFgT9kvFOoMZ0ZTJJHfE++msvyiVThB9xsajCaHxPA=;
        b=xulAJz7KznVCHLRw0NCjXS3VghyLagz/gloBWf8scouJW2G0r1aVedZHmic23pr11e
         bmg9EYEpXtxDWqwmPA/FGOFwoL2gryp8L/lkBv8CHTb7EnrjS5e/CvCBcaIREHc3/3aS
         9VS0dEpQ1EOcj0Sqlahs8ECORPTJBJ82snYJd0C7whOuxG8THu8njwuVOXr5pyr2P9Mx
         C9w858SxRKODX3nGIw8pQJho2NNWK28TQWhmO1vwHLhCxHV88HUu1JdtF2g9+hA0pyyQ
         xix4eQi/FkEdn/SoM+hZ6L5OLFQqLMp0CGZUfvpmwy5wdH/ug/T+Z5xyilXS5/IIqpQZ
         SW2g==
X-Gm-Message-State: AOAM532W3YUPZc00Tf+nbtKZbtLVMWLp5uLSSVKfxBdtETrlkeJ1hoA3
        8U89PyVyWXrrukr2nPdwV1S1mAux5/M=
X-Google-Smtp-Source: ABdhPJyfq0C2nQIKvmC4fRTsPD4lxL7CxeDaEGSnLlHJfsdvRCXjMN+gqe292Ema5GoJnxi7qV+orA==
X-Received: by 2002:adf:fe81:: with SMTP id l1mr7840642wrr.522.1637855763593;
        Thu, 25 Nov 2021 07:56:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm10417439wmg.6.2021.11.25.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:56:03 -0800 (PST)
Message-Id: <b83bfda2443bd10930e46efadc9bd051de5ec43d.1637855761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:56:00 +0000
Subject: [PATCH 1/2] refs: update comment.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
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
index 151b0056fe5..5cfdec1e820 100644
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

