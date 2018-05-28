Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FB2B1F42D
	for <e@80x24.org>; Mon, 28 May 2018 04:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750716AbeE1EMa (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 00:12:30 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:42925 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeE1EM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 00:12:28 -0400
Received: by mail-io0-f175.google.com with SMTP id a10-v6so12664965ioc.9
        for <git@vger.kernel.org>; Sun, 27 May 2018 21:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yGY1vmNx8432gVaCC+PoAuSkk/nJtat60xBdsq+WjfU=;
        b=UsNPJw0fIPQj4B4mU2I6BKm8o/UfIAfomabijUMn2fncy4xsZYD3hJKGalIz3MmjMo
         XY3XI1gGhsAHtvqf6DeQUvoU4Hr6dGp6F6HGFv9X4X3CCMv/QDnTlKAR9nrwXPYvCNwz
         IIRNWbHG7LvuWk+Ruhu+UEFG1O4hK7FdUyvdIScogp/SaS7yk3ON2xdu0ryHU4IzjVTN
         3UA4ghPUIr1IYIbddbUJpiUVWuuIHYTwOLofYZuIuexz74mYqCedJug+xnnuziBs5+O9
         QVCrYavxiHaQl0PNhit5X20CUPmcnymb9IkFzkNRKE9U+sm/kSRT93aZVWdrh+/xD4qr
         i8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yGY1vmNx8432gVaCC+PoAuSkk/nJtat60xBdsq+WjfU=;
        b=CDE8LwHLRfgfbKjma+iZK5HiavOyaphuzjuAnR0bMoAmlckMSKVdS2pMBNQNt6irg8
         8gUYeaQiEV1mvReTgy7TGUUydQk4//ncxlRFRhUDaGN2A9qlIiGc8bs87pLYLDNUEw3N
         vJYUZFm+cHsXTMO3dkWpoJx7uFnf2Nq/XthzyFmlCPsetHHi03CBOegJncRVaNkTFRX8
         cksrQtmPEXoTd8n3JqlZP3JcZ75yG2vwb2X0z6Q7fyWpzoAR5rMdihhlat3t5SWPQrYP
         zhKbo1HrYVsapg6hdIjvm0HNB6lj7IFyZLj1+rcCHpL6nmTa+VWbu/fc3pK9VjLPS8VX
         7s4Q==
X-Gm-Message-State: ALKqPwcAw2TIIIQ7q1iWCIPUlvdzkX/C5BhbSK9B0WPiEaEMkJ4XYZnI
        jm2lcYubxtKIO0svVsBMB9UZaWmXR+KQ8DG2Gsg=
X-Google-Smtp-Source: AB8JxZqFmP8a1hGY05nUpmDQNTuT1uMGZWUvswPXCf2/rqUATJmvqArHt244ALtdaOArStCFGH/26DcS+iKFhw2e1As=
X-Received: by 2002:a6b:ca46:: with SMTP id a67-v6mr9437328iog.53.1527480747475;
 Sun, 27 May 2018 21:12:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Sun, 27 May 2018 21:12:27
 -0700 (PDT)
In-Reply-To: <48c8a5ba-3a04-00f8-94d7-5b32083a59ef@gmail.com>
References: <48c8a5ba-3a04-00f8-94d7-5b32083a59ef@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 28 May 2018 06:12:27 +0200
Message-ID: <CAP8UFD1LR9gR-Au0N33yktdW6SiyVeXccBfR3zPjZHs95sjwOQ@mail.gmail.com>
Subject: Re: [GSoC] GSoC with git, week 4
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Sat, May 26, 2018 at 6:32 PM, Alban Gruin <alban.gruin@gmail.com> wrote:
>
> I published my blog post about this week. You can read it here:
>
>     https://blog.pa1ch.fr/posts/2018/05/26/en/gsoc2018-week-4.html
>
> All comments are welcome!

Thanks for publishing a nice update!

Christian.
