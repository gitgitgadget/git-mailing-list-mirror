Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10980202BB
	for <e@80x24.org>; Thu,  7 Mar 2019 09:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGJ6c (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:58:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43025 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfCGJ6b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:58:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id l11so10851044pgq.10
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8b97g440HAEwX9daqZSOrQWIP+JfRrdyV0CdVNx31Hg=;
        b=riiiL/ZzjcQdNf819i7u9HpuFk73ry6Qdf2vDrc/hLr86I/oJ9T8R/4FysuKd6yRB2
         7kOZCEdoq5uDx+qBgkkSwc8IzbTJimRSWL7oKDJqhjv890FIfdVRekG22+uF/iQKpG1K
         fJwOXNPDZhIfPTl/778duvnhkNnxsa2jWx4sMdwQZ3ucVx7xEN5Bu/oAI0dwKZs6Eajg
         R+1YI7DdsmSwRF+Nq5VDa5ccSJK2ASY66DJdZrEIufUaWGxOvjq2G5zrWsOdq4/8beAU
         HYTeCMkr+zrN4e1j14SNS9OGSSTAbjByewyFxHEMxLktavRG21U6Gni8NlSLSt5U2R7f
         pKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8b97g440HAEwX9daqZSOrQWIP+JfRrdyV0CdVNx31Hg=;
        b=nHIbnCQRtDPSArFIYqB+2bbtI7XTx8t1zXfPQ4xYLVaId+xmrD0BoTVPS+FOF5oO7d
         JszK9WJSJ8pPGHq7FU/8UR4XgVMFS4EGyOcgiR5FIcl8nR7iusWId8qSN4QOEHTeI3Ad
         0X5iydKxxguvoduNLgKRSXHZFb5H8WO9PWjo7ogVNtGHNzQEn8Mf1q/AiGIDW2yerdXx
         KLxWext+JKCoXk2d/9X+B74DpkjSLRaV7GizkKQUw+vAX35TRtpBfUx2E0U11OJ88Ao3
         57/tTHZfnTzHypEmanuloTnqjyRaHpSgpEfaWqJGJnfQpTqYusvgJlks00fEOPo2Nm/q
         /icQ==
X-Gm-Message-State: APjAAAV8IEsx+Co0iE+8aDGYNFiPQex44b8uDVUS7sPTFttiS1/tYm3d
        GXSVAhsSgbkTjo5tHMRc5zplX0mN
X-Google-Smtp-Source: APXvYqy+50cEo92HZVW5pFISkO05fxW/i53fVusCsXpICt9bfpkn18JmQmoj1tXtd6PKnJuK4RG6OQ==
X-Received: by 2002:a62:1f5d:: with SMTP id f90mr11901767pff.104.1551952710134;
        Thu, 07 Mar 2019 01:58:30 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id z15sm6149208pfn.30.2019.03.07.01.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:58:29 -0800 (PST)
Date:   Thu, 7 Mar 2019 01:58:27 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] merge-options.txt: correct typo
Message-ID: <1076d4c45108b1edad48fcac0f203c8c4e521b79.1551951770.git.liu.denton@gmail.com>
References: <cover.1551940635.git.liu.denton@gmail.com>
 <cover.1551951770.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551951770.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The scissors line is included after the human commit message. Therefore,
saying "scissors will be prepended" was incorrect. Update to say
"appended" which is more correct.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Notes:
    Note that this can be squashed into 6f06b6aeef (merge: add scissors line on
    merge conflict, 2019-01-22) if it makes life easier.

 Documentation/merge-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index c2a263ba74..6fff647409 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -31,8 +31,8 @@ set to `no` at the beginning of them.
 	This option determines how the merge message will be cleaned up
 	before commiting or being passed on. See linkgit:git-commit[1] for more
 	details. In addition, if the '<mode>' is given a value of `scissors`,
-	scissors will be prepended to MERGE_MSG before being passed on in the case
-	of a merge conflict.
+	scissors will be appended to MERGE_MSG before being passed on in the
+	case of a merge conflict.
 
 --ff::
 	When the merge resolves as a fast-forward, only update the branch
-- 
2.21.0.370.g4fdb13b891

