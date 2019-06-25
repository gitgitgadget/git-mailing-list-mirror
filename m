Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20AE01F461
	for <e@80x24.org>; Tue, 25 Jun 2019 17:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfFYRuG (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 13:50:06 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38880 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFYRuF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 13:50:05 -0400
Received: by mail-pg1-f170.google.com with SMTP id z75so6714645pgz.5
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/0eSecNdkcAmbTeLAs6CvAzXqLJmaqP6oSQP8GmbPuQ=;
        b=l9UNLt7fjnbjRQwkd5V9ffEuA4boJ9jR0xV2JogZpMBpC2a04L8J7HwVwhE6we+NQo
         wDciZhll8LIyxORAaKH0D8Hyi+TZBQ4SklWZQ6Cbw+yBJMTku5ETdvoFLCisivVoLZiZ
         4WQFoyAM57NaS1j3+6eWzvsbofSVA07OTRx2azhIzyHI3eBcFHMEKWpY6M295+dS4kg4
         ieGOf8BoRPWSjfttKCCaqPGd7jUbdenvgAF5sNMKvEycvFLn2K6uh/mQ/FT12hKRlaOK
         /cBF58Xqtx6v1+khz/5zVh5E2ThuYzB1jLUPdyezaI4yN75WtHJn9bGc2qTyXgnR1MuC
         yUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/0eSecNdkcAmbTeLAs6CvAzXqLJmaqP6oSQP8GmbPuQ=;
        b=RYDNjor12ZmEXW453/iGt3wc8KjfXGkH35Uu+4jbbDxmGdELBry/SSy+hianDegUGQ
         QDtgVzW3QtRq/fJTA1KX0cx+sWsHSyT9erJwE/BjqdDFMIF8WVnUVlUGUM82YzXNCWtD
         ySHh0qBuUVh78Emfttpa3dPpODf4Vc/JuUJAjJzT21guUxZfmss6qzJns1I/E+MDFjmY
         Tl6obBqxxh35GgKxNRlePVv5BJCarzcVdzBte0NR1IyPDlTQ5cqiwPtNBmUUH2WPSdsj
         139DBMWGvs2eDd/My4HjfLv6JvlIFa4idpZgTdCskLRpnvRRN+pRLKoP0obyLUzChAAt
         dCsg==
X-Gm-Message-State: APjAAAUUNjSpZgfZRUw/PSmkg6ULO1QerNKuI+2ScecQ/B9IEV1HTQc3
        SalJOh0JEM/nYztU0mbM5q/VfrBbSPS12MMO0to=
X-Google-Smtp-Source: APXvYqzLNYPAO19xpM7cmKuFdxkS87WUZPM+2edPZpqLcoShz9djwLHH+rp7oHA9yOAQK6c2dAXhNyc2ABfehXVc+jg=
X-Received: by 2002:a17:90a:cd04:: with SMTP id d4mr43075pju.128.1561485004955;
 Tue, 25 Jun 2019 10:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <0102016b8d597569-c1f6cfdc-cb45-4428-8737-cb1bc30655d8-000000@eu-west-1.amazonses.com>
 <CAN0heSraZh+j04qjeaVtS5bsNoE=Hf_FBU-kfcB+69BkZz+zHg@mail.gmail.com> <nycvar.QRO.7.76.6.1906251339050.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906251339050.44@tvgsbejvaqbjf.bet>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 25 Jun 2019 19:49:52 +0200
Message-ID: <CAN0heSr=E6yHkUHiGE=nezB72+P_R2iSZcYKDZHp1JTPj4f2QA@mail.gmail.com>
Subject: Re: [PATCH] doc: fix form -> from typo
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Catalin Criste <cris_linu_w@yahoo.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 25 Jun 2019 at 13:40, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Tue, 25 Jun 2019, Martin =C3=85gren wrote:

> > Do you have any suggestions as to how this could be made clearer?
> > There are at least two of us that have stumbled on this. :-)
>
> Make that three.
>
> Maybe something like
>
>         This option is deprecated in favour of 'git stash push'.  It
>         differs from "stash push" in that it cannot take pathspecs;
>         Instead, all non-option arguments are concatenated to form the st=
ash
>         message.
>
> ?

Looks good. I would probably avoid the semicolon ";" and in this case
just replace it with a period. But it's nothing I feel strongly about.

Martin
