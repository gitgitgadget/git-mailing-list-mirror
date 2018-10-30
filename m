Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1B71F453
	for <e@80x24.org>; Tue, 30 Oct 2018 02:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbeJ3LNx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 07:13:53 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:36808 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeJ3LNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 07:13:53 -0400
Received: by mail-qt1-f173.google.com with SMTP id u34-v6so11807006qth.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 19:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JOhWuFAPwc4+mwDpbvj2Htvu8iRfFIjLFAenTay9NRU=;
        b=XaDuCzdwDhlarNiD/dCP82RzZ32VEUq9oXTWdfHmPhwspzx0pMI0k6M0oNHE2YwU0k
         QJTECmm1u1ZxHcHJg0+hTM+og7cdDtuHm7mjKJRIpIjHe859IJguFgHuAAkusKjSZWcb
         pI8LuU2fpScf17UJaR2zAJ8p1GD1w1sVktZIJn7sLxg6F6Onc1PR5jTK454zhGng25aZ
         w6o/yGzA1VeTGP9OQqHdFwRzoeHeoLXEl5bhZojf0nVVhVZ/DWphF1mYHmrhPAwupvSN
         oR44hSaS/xHPvTsoGHlYxBw3dWEQdO1s3xeym4EtlFEjiJwm59nqCIR4fhY/7bmqw1/B
         Xzsg==
X-Gm-Message-State: AGRZ1gI9cxiOe4fz7DeiuzXjt0rj1LbRW3rVBIJXnZnZyWrAfPFHVv3Z
        4S5DN/Va6hz4inTrwbJt8/o1pnY92yEu0KETYNU=
X-Google-Smtp-Source: AJdET5dPRlcvlCOMGcK/5Bc9q0woPtF6fvG1C7Y9mimxwO4hCv4kz+sIeqPv3YZ93VJDf8oDoC1VlldZ2UwH4iPO2+o=
X-Received: by 2002:ac8:5190:: with SMTP id c16-v6mr710423qtn.352.1540866144018;
 Mon, 29 Oct 2018 19:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet>
 <xmqqftwsdevm.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1810291418300.4546@tvgsbejvaqbjf.bet>
 <xmqqftwo2nig.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftwo2nig.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 29 Oct 2018 22:22:12 -0400
Message-ID: <CAPig+cTJR4Qhqf_VVCihNW91tGt8Mbi2Oy99jzg8NmAksKoXVA@mail.gmail.com>
Subject: Re: js/mingw-http-ssl, was Re: What's cooking in git.git (Oct 2018,
 #05; Fri, 26)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 10:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> How's this?
>
>     On platforms with recent cURL library, http.sslBackend configuration
>     variable can be used to choose different SSL backend at runtime.

s/choose/& a/

>     The Windows port uses this mechanism to switch between OpenSSL and
>     Secure Channel while talking over the HTTPS protocol.
