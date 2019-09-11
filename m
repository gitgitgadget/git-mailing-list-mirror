Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA4AB1F463
	for <e@80x24.org>; Wed, 11 Sep 2019 14:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfIKOwx (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 10:52:53 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37738 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfIKOww (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 10:52:52 -0400
Received: by mail-wr1-f45.google.com with SMTP id i1so24339497wro.4
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oxErGkL9lXvAW8QuIujtZbYlkWRYw6inaFywpnfIkH4=;
        b=cuvtxdsk+jh+O1LLvpqYHi7uSkuguQajQCi3rljX79Pe/a52O2MnJCavEW0xKQa78n
         RQ6LNUM+allfufkufhbBAYEjvjYh3ml8SGKWI/0vL5OqIMRt85JOEpBb4xz9/vGeizOc
         tZ0KCId0V+5jQ94MHCpd3/PzZlKD3/Lpcce77owaWKDBG0ik5W9lv7br2/A2Ww1IdBIp
         TRwzzYevT07Ox/sp37aNCz3GruKorFpd+kPswF7KZGCwrIthoUiDtAWtMqgqC9gmundM
         eivKcf+s3Jz4kNCFol9P0P7VsAAMGxbCvZtGdFFd/hMjuHkRvHPnnFlWHEYlq5LnzArg
         sOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oxErGkL9lXvAW8QuIujtZbYlkWRYw6inaFywpnfIkH4=;
        b=XbH9LNG5aBNR5mdRUdKqlNl+50k3+9X8o81nzFj8V6VQIe5zosFHtoEjoGcr8Tzpcq
         oHUMjF5eUDI0x0SKxFYSsmJTf45wuUAoekehdglkjQsqRvhBIHvyOUBdOgFB7KOnrRPG
         wEHB65DtCs5Agn4kKuT8+1/YesXLkvqogMQh5O5OjHf/Rv/+9apk5ThssiJJ2IhjZq6A
         sjsdkL8EYdY4Y22w46tXMTViXkCWsRjj3SBl7nLu29KvnSfhrCWeiKCxinvF2Bjy4//3
         Z+bRZbC1lLOQzQ4+6NLOoP5QWFrC/lK3vwiIVQSnaqpjtdKnzsZ7OUbKYUtMqZs+chqW
         0Nag==
X-Gm-Message-State: APjAAAXs3v8n7i46MSqJJaqJbQGB0Yql7DBA+xKbZh2sm+as40a9SOps
        +aV1TNTqU7bUJk3iXIJgm5CA0467
X-Google-Smtp-Source: APXvYqxou8ous++/+E7w3ZfkiX+u+OIXaMvxHOamJZieYqKwNHX0wyjGXO/7McOUOHb2f6A8qI02pQ==
X-Received: by 2002:adf:f601:: with SMTP id t1mr31139653wrp.36.1568213571388;
        Wed, 11 Sep 2019 07:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s26sm38607995wrs.63.2019.09.11.07.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Sep 2019 07:52:50 -0700 (PDT)
Date:   Wed, 11 Sep 2019 07:52:50 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Sep 2019 14:52:49 GMT
Message-Id: <pull.330.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.330.git.gitgitgadget@gmail.com>
References: <pull.330.git.gitgitgadget@gmail.com>
From:   "Cameron Steffen via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] doc: small formatting fix
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

Move a closing backtick that was placed one character too soon.

Cameron Steffen (1):
  doc: minor formatting fix

 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 75b2f01a0f642b39b0f29b6218515df9b5eb798e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-330%2Fcamsteffen%2Fpatch-1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-330/camsteffen/patch-1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/330

Range-diff vs v1:

 1:  5248e3332c ! 1:  8e64007452 doc: small formatting fix
     @@ -1,8 +1,8 @@
      Author: Cameron Steffen <cam.steffen94@gmail.com>
      
     -    doc: small formatting fix
     +    doc: minor formatting fix
      
     -    move an incorrectly placed backtick
     +    Move a closing backtick that was placed one character too soon.
      
          Signed-off-by: Cameron Steffen <cam.steffen94@gmail.com>
      

-- 
gitgitgadget
