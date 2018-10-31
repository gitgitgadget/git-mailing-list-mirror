Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671E51F453
	for <e@80x24.org>; Wed, 31 Oct 2018 18:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbeKADl0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 23:41:26 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:36535 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbeKADl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 23:41:26 -0400
Received: by mail-pl1-f182.google.com with SMTP id y11-v6so7710687plt.3
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMpLKmOVu1/9+VA8p+6l4Z0zqz4SbRfjW1VIK3/A8JU=;
        b=QaHWIHb5h1Hb7qhnK6G6hGqsD8ux+XfbbX9CJpNCkjxFu8wnV5/ytYH5LaEO6vNS/i
         Pl87uCD3d2ZXMlQeALF4RgJoeiU7/K5SKRa+lAD7ZDAv0eSkZp4QzIVnMH+9+ZhTypbG
         Qky7aA7JWv5raiUzIZbtEAgiUSnO8NjE2wg/i/e9UCO/KWtSP0v7giAwa0ha256YpQbc
         dYRCcAgP+RDIIyc2bC78X2t3mohH8TxVgQYouTXu3qaan2jOYtu0wK8QX5s83Qu0qxDl
         d9x7ZTKFIiq6FAqON1RrluU2bSc3catdCbBzdPWsGmk7QJUmr5IdwjXmYmmHrGBNTrZt
         V/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMpLKmOVu1/9+VA8p+6l4Z0zqz4SbRfjW1VIK3/A8JU=;
        b=f/G7E21PAWavju33Y/mn3cpa22YaKcPdPFORB0d7Wq5yeC8+10fUbESd/zwHCvQvEK
         RhIZvtdRngbAn4DtWUGPotCyneE4JGCrQ5FYjPArnnuu3lknBQgrmLDKEvWHM8M+6vGO
         eppzE7pMQj0as5eI/YujdQy5MICNDwUejWDWDknwssxMnfFlTn7vAFMqTsPPiBCIFGGp
         R6hePo2ruJYJSbo5SrKhHgzYXRfZ0kYK1TFO5oR1GewX2l7iVN7VF3wqh07cpCoGZH97
         9baLpeclX2nKNQ4pVbbSynJCsZE6H1QlY6m7Q7BbSxxWhrhkyftSsIOFNhVJeP9BMwfP
         vqCw==
X-Gm-Message-State: AGRZ1gIBRbmzKE01+KNA+sY/PWm9qLQKcJONQ0P6i2r/2dco8E6yZCsl
        3UIZBcMEB4trbO3aFotM5wlp3YTMoq3KLmmOG05+8A==
X-Google-Smtp-Source: AJdET5d5mVr7VsjqJILwcyS/8+u+OncIpqHwkQ5HwTfmnOatPg0OF3g8eXhxBc6S2VHX7Gmj6f0NRmUVmCWRuZDvaDg=
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10-v6mr4466162plx.171.1541011331268;
 Wed, 31 Oct 2018 11:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva5l76zs.fsf@gitster-ct.c.googlers.com> <20181030080937.11118-1-martin.agren@gmail.com>
 <nycvar.QRO.7.76.6.1810311553480.4546@tvgsbejvaqbjf.bet> <CAPig+cR-W1bQ7wY8k8Zok3hCBxHL8uXmUA2p2Tc9pYYXc7Zr+g@mail.gmail.com>
In-Reply-To: <CAPig+cR-W1bQ7wY8k8Zok3hCBxHL8uXmUA2p2Tc9pYYXc7Zr+g@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 31 Oct 2018 19:41:57 +0100
Message-ID: <CAN0heSoe+R90F4iT_-jE9iyvtB+M+y=U_n-8cUhHyrAh+zN7ng@mail.gmail.com>
Subject: Re: [PATCH v2] sequencer: break out of loop explicitly
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 31 Oct 2018 at 18:28, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Oct 31, 2018 at 10:54 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:

> > ACK. Thanks for cleaning up after me,
>
> Looks good to me, as well. Thanks for working on it.

Thanks, both of you.

Martin
