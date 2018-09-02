Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A841F404
	for <e@80x24.org>; Sun,  2 Sep 2018 02:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeIBGgy (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 02:36:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42193 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeIBGgy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 02:36:54 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so18579832qto.9
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 19:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzGi84cO6+LEfbvB/THwzNLL3rJiJ89GTu2D1Sr2OwM=;
        b=jyneAfp1cj0/AaJyEOCRqGU19zxh6/H/PAJoKqWzybae7kNKrzlOZAcelOQdzVAQV+
         vopftj/ojGKyZJDh9SS6BxbYCjc41rCM5BXBr0GYLCav9+BmsT6dDGdYRi072sg4egRm
         Kij+MtMLmdPoVfxcAS2kTAu17qbVwrpC4Ec4ttVxT3GOMpoGIvTvx6Q9CusbEHvhO2K8
         nXRKDiZePJoGKqC2f20rRa7QFfEIWIAUtBdr+6r6ZeGewn6cxynNEhLZvRJDwQLGEXfi
         fqOMsbHLkPQ76Qzi7CA0rTseaWnknoC1HqQ+SxQ+bM4c9qIEZubuS7XBWjlKqo+zgw+2
         K32w==
X-Gm-Message-State: APzg51A4qRpJqh99IKYK4OsqEPscgumrMYTFBgO1W/4FMCyKWHCI7XUc
        9qcF6/I8MMTZ05VcGkyy+2s1VUn8U214ZVzh0Pw=
X-Google-Smtp-Source: ANB0Vdb2WJwppjQgv4/s/oXZfiMbhEpjsehZ4NVuBnHFBcxPGnocpV5S7OVbTbygMUI0Ud8D3PrS6lP+fYRJJGoM9iY=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr21963418qtd.101.1535854972761;
 Sat, 01 Sep 2018 19:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180901235256.4260-1-ischis2@cox.net> <20180901235256.4260-3-ischis2@cox.net>
 <CAPig+cTzBTA4hSkM9ZtRVARZEwXMv1o9GnPMrBGimt-g=ExmHw@mail.gmail.com>
In-Reply-To: <CAPig+cTzBTA4hSkM9ZtRVARZEwXMv1o9GnPMrBGimt-g=ExmHw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 1 Sep 2018 22:22:42 -0400
Message-ID: <CAPig+cSnFE9G+09LucqTQXM7nKOXPkJ45CR-hkaA+5y9JdaNHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Add test for commit --dry-run --short.
To:     "Stephen & Linda Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 1, 2018 at 10:18 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Sep 1, 2018 at 7:53 PM Stephen P. Smith <ischis2@cox.net> wrote:
> > The test demonstrates that the setting of the commitable flag is
> > broken.
>
> s/commitable/committable/

Looking at patch 3/3, I see that this misspelling exists in the code
itself, so I guess my recommended spelling correction isn't needed. It
might make sense, though, to quote this word in the commit message to
make it more clear that that is the literal spelling in the code. That
is:

   ...demonstrates that the setting of the 'commitable' flag...

(Not itself worth a re-roll.)
