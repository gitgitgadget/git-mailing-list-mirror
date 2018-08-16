Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639301F404
	for <e@80x24.org>; Thu, 16 Aug 2018 02:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387702AbeHPFao (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 01:30:44 -0400
Received: from mail-yw1-f50.google.com ([209.85.161.50]:34793 "EHLO
        mail-yw1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeHPFan (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 01:30:43 -0400
Received: by mail-yw1-f50.google.com with SMTP id j68-v6so2429894ywg.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 19:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DfRpBI/P6B3VJLM92f0KAZXrocSpMre+zQg+vQX4Es=;
        b=GbGdkRMq9q8lVePsgd78Oek6wJ3R8lcO7Dntml4Oqi+bsxr/crsUlDGchy0FI5ceqi
         3NUYra6M2LBvYcfCY5aImqUzZ1w5HP4BRXPUsPeeuLoOU+j1Pt6pdZWpOwwJQEWcqWYw
         mHBPyrllwM2Vq2TyFus/ESKquVVDP8djv++/jH4ZIjZXVhtSxorimQtnGobU8t8qL80i
         2S5FEH+TvmEFMc08yqpytWXaUCVxsPkVQRJ11Oc0e0Qfr7FU+rAacDo8j/JYbscfQlQD
         FmpvVbMRCLbj621T+0+GFUx0JpCbHRF8ph2ZJ5oP2ndmmeFX9LFMYFWX1ikgl0eTM+Rg
         Gj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DfRpBI/P6B3VJLM92f0KAZXrocSpMre+zQg+vQX4Es=;
        b=le7BLw/AZpDdK6MTauN2dHhYYyIGtaj5JnM/N612XQygntY/DLoVvJbjHoBGdto62k
         hc6JEFEt+CCUa71wKUt4n7I8A3vIdMBBrX3AZRzXeh44HLOlgles6nRO0ymULZgUvJUx
         6sEpdg6qWPbG74DHob2pmXZIjcCzI4Zr+ZFr66Ov5vuJkJhLJWtT+1t/zpzt/2mcLpEA
         g4Qzj4vqZx6D6HDwKmSClgQUFhU0lVWt7pDTZI/mbnYm/MoA0j4j25YF9n9duMrahUbu
         8EoSLi2gR18hVWd+6oEs+4bwjFAy83DfBJF0e4AAsmBGohGgvbUheh+rdNqsX9qclbcP
         oU+A==
X-Gm-Message-State: AOUpUlF+/LCBarLsbeCQF5XT0MnT2IyshO273UJ+Vma0WWat5qEQfJFC
        FIvBzyWEm+rS3iP1rFCWrhKwCAWMpsqWTWGfNR2LqrzIYt8=
X-Google-Smtp-Source: AA+uWPwF8aViAI0k76Y3177hE5dwg50AH+k6kIqUHZhxIDbbLqTPUNndx5SHzwEAHoGKgtVHD6GTBZvb0S/AprqdsE8=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr15149841ywh.238.1534386934858;
 Wed, 15 Aug 2018 19:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Aug 2018 19:35:23 -0700
Message-ID: <CAGZ79kar1UwZEX9d=+e57ZJCy7YaqKSPExOexp8_t=G1VjwY2g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #03; Wed, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/config-write-fix (2018-08-08) 3 commits
>  - git-config: document accidental multi-line setting in deprecated syntax
>  - config: fix case sensitive subsection names on writing
>  - t1300: document current behavior of setting options
>
>  Recent update to "git config" broke updating variable in a
>  subsection, which has been corrected.
>
>  Expecting a reroll.
>  cf. <CAGZ79kZ1R8sxmtfgPOQcpoWM7GWV1qiRaqMq_zhGyKBB3ARLjg@mail.gmail.com>

That reroll happened and you picked it up,
cf. https://public-inbox.org/git/20180808195020.37374-1-sbeller@google.com/
