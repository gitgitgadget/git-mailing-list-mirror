Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DAAA20248
	for <e@80x24.org>; Sat, 23 Feb 2019 14:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfBWOtZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 09:49:25 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:37771 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWOtY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 09:49:24 -0500
Received: by mail-ed1-f45.google.com with SMTP id m12so4164171edv.4
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 06:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=cK0o6S5wj6zkQDwahG549mrJgcxN5qBAJ+L4TLBGsuc=;
        b=P3p7LtzCFHOjQxkUVTktE77YkgAVd7Ql/ABKTAEvfAYlOkhTxuPqjFGOqHREGGkRQP
         MqmXkudfdC/7o6N4dKYgHIqthP/u2+dIY117QHhMrWE9GIskbgfqkj/YqloJ68hTxRet
         EjSzMkCyIZR2qx3BraMl52m9e4pVQBifXABJ+1KRWAP2lDkypOlc1T4qjcDPzcsp/i+y
         NhWP9kqSjqVDU+PdjoKA+hgiwQPXo7KAWTOe76Q5TOlZwMh/udkoM54Dl0IrNYR9jtDX
         4kbdbPnrQ1/3NFV+XUi76e+9B7Gl1tsxdWa8L2QEAjaRxMGKkTJ+7baR1u+N8HxzHUmd
         jdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cK0o6S5wj6zkQDwahG549mrJgcxN5qBAJ+L4TLBGsuc=;
        b=c5GKZIao1YDRH9dUSGllT6pKlONQjbBRegQPRS8KbZgsKSnIvqpRCPRdYLlmSpghIs
         oJ+B9hPkgyPcx8P63ig+gZZ3y2LqHSq9dVxI5Drn0Y/Kvn5JxPHnRTxQOj2KupxT9ABd
         FU98glCrCyI3OAc3h4rujFIxGvxiXkdb3u+MfamC10NrO0jJoTkeWExSddXYGtQ+YNzy
         tcJpEsv5Wl1gRIyoObskGGAcEkZnyzqvAYwYVAK5qli2jnkWKNlkW1m3wnWKvhztZ+ep
         5UIES6FUsXHMxP27XN/1m+Tz9Yy7uBR8Bdj8X7i/+LKRSA1AHvNUlLSd0/SSlV+Hpxq7
         hmZQ==
X-Gm-Message-State: AHQUAubuSFTCBW/M0reCHxXMWJ1wXDjv1QeoGI5PJea7UOJiEgf/YlkO
        Hd+YqHcd9iBWZgL/TxOfVr0dDE8F
X-Google-Smtp-Source: AHgI3IYp6Ny8YpdiThH5pRwIdldPvbr9Edi7fDGHQFbya+MSCltqLVd1JaljIGLouIfkcNq8ZLDxBQ==
X-Received: by 2002:a50:858a:: with SMTP id a10mr7720536edh.1.1550933362932;
        Sat, 23 Feb 2019 06:49:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm789803ejj.26.2019.02.23.06.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 06:49:22 -0800 (PST)
Date:   Sat, 23 Feb 2019 06:49:22 -0800 (PST)
X-Google-Original-Date: Sat, 23 Feb 2019 14:49:20 GMT
Message-Id: <pull.128.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/1] Adjust the Azure Pipeline badge in our README
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We now have an official Azure Pipeline (not the temporary, for-testing one I
used during development), thanks to Peff! Let's link to it, too.

Johannes Schindelin (1):
  README: adjust for final Azure Pipeline ID

 README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: c65a2884eae159bad540135479bc8afe20ff62d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-128%2Fdscho%2Fazure-pipelines-badge-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-128/dscho/azure-pipelines-badge-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/128
-- 
gitgitgadget
