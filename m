Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426581F463
	for <e@80x24.org>; Wed, 18 Sep 2019 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfIRQRR (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 12:17:17 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40615 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387555AbfIRQRR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 12:17:17 -0400
Received: by mail-lj1-f181.google.com with SMTP id 7so515726ljw.7
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=MdMGAxq7k4scZVg8juIzjgWrgApIE6B2GpLUvAXwA0Y=;
        b=gDOE0OQRQrYjfT+ai4ORjgrnNSyiLiQ/cZzTiBY/6ftKOq/tZFtPIRbRbFyrjv3uTd
         p0Azky50/PXo+HY0CGdFTqXUmg7XLE66HauoXGk8PCyXv/MZAWGwcFwM/FCBXHP0zY7F
         ugv1mvhcVwX2soCV2tfxrj1UnLEY7ZkJIQQc+XGnmk87U6voeuCFg+h92TN2oesvXrfS
         2SzeQwVoQn2HwdbWXy31w+1twNvMnkoSAdMood+uh+vJIU6Bahh0a8YqcceIVdZ4Z3Pe
         lhfYTs8Ias7xPYQOot0LzNhIfCVIDMPXVYztk7aqe7gJRDar8uVj0N7W+oDCLPcksLqB
         FX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=MdMGAxq7k4scZVg8juIzjgWrgApIE6B2GpLUvAXwA0Y=;
        b=sE2kx+b4zOl7UDNYq7cseO/6FEaWFKVddDZ+khXGoPVwYzrRjIUq5hjhjeWcMNKv0Q
         HWwDvw0nT31pSboeAbnlm/aGDREjI2lfgfkGssva2h2xu2xycGnNCXeird7FRVz9i6SV
         fUF3LdxOy6VQaOPtEnDu7zoSnIjeFoUqjiOToE6w0xgRwtxHNRMCo1q5IaRui1FtijZ2
         7QBx1uIcfG9nM958/mBNx8qigEm///3usP06zlzQPD1yT/oct+wrLKJ9ptnmQoEB7bA6
         gv7KurpPoW/gMBEDatGRvwcdzJJ9Vk6raOwVPEdRslnGvX8Ki9qbXUyczvSCDDxtDerG
         umAQ==
X-Gm-Message-State: APjAAAX+nnC7QA8mWmai0/c/0BJOTD2pb5mm1eJxrNIrciiwq+apAsGX
        iCLWTr/2U9vqoYAK72m1P1GbCJEa1vGccr+TTCCCKUrv
X-Google-Smtp-Source: APXvYqwEXOADTCLtTkI90Hg3m+7pCfuW0cvizQp6bFtF1HWbWScJWrbaaTD4y9HoclwSGxvRij9/5o5QL/HVIDk4UPI=
X-Received: by 2002:a2e:8613:: with SMTP id a19mr2513610lji.94.1568823435588;
 Wed, 18 Sep 2019 09:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KC=OPMJZB883MWys=J068cdZNHL=eOYK81fNBEv9MhvA@mail.gmail.com>
In-Reply-To: <CAGr--=KC=OPMJZB883MWys=J068cdZNHL=eOYK81fNBEv9MhvA@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Wed, 18 Sep 2019 18:17:02 +0200
Message-ID: <CAGr--=L8iRCW2zKLEN73rpqfK+xB_0RsbhUGuCUVA56Qo2BtQQ@mail.gmail.com>
Subject: Re: git-gui: duplicated key binds?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doing some more experimenting with these, I realize I was completely
wrong about them. Please disregard my previous email :-)

Birger
