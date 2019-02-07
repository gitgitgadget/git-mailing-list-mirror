Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51751F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfBGXZ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:25:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55432 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfBGXZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:25:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so1608506wmh.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mcvmjvt2bCnI7ZYpEOQ17hYUuhMVJzfWG/adBuIXU1w=;
        b=Cj7j3Iy1sTNbkOyuLmnnlVUTUtXSnv73ozg8hBbbjI2kF78mOdIiDatdcelzHYQo2Q
         X60CNsmpbQUy6MRtuDxvLgN9NOD9Hf5qHzacyhIuKjkgqF2vXQW3Uao7rMqLQBSARvdw
         tfD1D74asm+aaLm9NFiKxspS/DViGnJJtEOeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mcvmjvt2bCnI7ZYpEOQ17hYUuhMVJzfWG/adBuIXU1w=;
        b=aNbtruxJkJT/yknbq8w01hcQZUbSViunptEZ4wNTVz/PEqoONg2Y8wxxSEEpcVTda9
         TNo7+LZlDGMSyC9NiXmYcPJMAIyS4B/WCy1MNkUib4U0YVqVgzYdxn1oi30UX2aYBML0
         +4T9v5nD7Ng1gnbxnX/iPBduJvPTBIYCrZz6u4jVgKI1X/mhB4PP6ygmJ7mZdhnEiwX0
         iwXVQ84xC3RJmRIaDP31+RHrd+MXT2Hj2rux47irNU7TsHD05nZH3prO3655n4YbwOKA
         81lAGwunHm8vxS6P3v3BPPfXn8ft0CZmCxtGa6e4AZQ1alJrHGh24T1/CtR5TEtf2LAg
         13Tg==
X-Gm-Message-State: AHQUAuYbw0pAajFRgXW1d40s1Cwd6lrXOooZTZih7RDb5NXZ1fA0SWXb
        Z0Hc5Aokk9yK8h8WdO8IAXz5TA==
X-Google-Smtp-Source: AHgI3IZ9IcFE+G/8Mv+x5ZvfuqBVLC3QylBUljtqOFQmIbgv6Dy5a57uhPGPh9zpnRra5EleO9yfrw==
X-Received: by 2002:a7b:c4c6:: with SMTP id g6mr8008435wmk.4.1549581954532;
        Thu, 07 Feb 2019 15:25:54 -0800 (PST)
Received: from ethel ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id h133sm1582253wmd.8.2019.02.07.15.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:25:53 -0800 (PST)
Date:   Thu, 7 Feb 2019 23:25:52 +0000
From:   Luke Diamand <luke@diamand.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/1] git-p4: remove ticket expiration test
Message-Id: <20190207232552.4246fec6f3057aea05211141@diamand.org>
In-Reply-To: <nycvar.QRO.7.76.6.1902071343210.41@tvgsbejvaqbjf.bet>
References: <20190206151153.20813-1-luke@diamand.org>
        <nycvar.QRO.7.76.6.1902071343210.41@tvgsbejvaqbjf.bet>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 7 Feb 2019 13:45:18 +0100 (STD)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi Luke,
>=20
> On Wed, 6 Feb 2019, Luke Diamand wrote:
>=20
> > As per thread here, this removes the git-p4 ticket expiration
> > test, since it isn't really that useful.
> >=20
> > https://marc.info/?l=3Dgit&m=3D154946136416003&w=3D2
>=20
> Thank you for the prompt patch!
>=20
> However, like G=E1bor, my feeling is that we would want that test case in=
 a
> non-flakey form, if possible. If you think that that is only possible with
> a mocked p4, so be it, let's remove the test case (because the mocked one
> will likely look quite a bit different). But if there are easier ways to
> work around the timing issues (such as dropping the first `sync`), then
> I'd prefer to have the safety of a regression test.

I've got a mocked-up p4 wrapper which returns whatever expiration time the =
test needs. I'll submit it tomorrow.

It's just a few lines of python script to generate the marshalled data, so =
it's not very complicated.

>=20
> Thanks,
> Dscho
>=20
> > Luke Diamand (1):
> >   git-p4: remove ticket expiry test
> >=20
> >  t/t9833-errors.sh | 27 ---------------------------
> >  1 file changed, 27 deletions(-)
> >=20
> > --=20
> > 2.20.1.611.gfbb209baf1
> >=20
> >=20


--=20
Luke Diamand <luke@diamand.org>
