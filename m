Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81BA92047F
	for <e@80x24.org>; Mon, 24 Jul 2017 02:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbdGXCaG (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 22:30:06 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:37340 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdGXCaE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 22:30:04 -0400
Received: by mail-qt0-f182.google.com with SMTP id r14so29988372qte.4
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vxHMS5co0P3s5GEzAdDXcDBEC5Vxm1F84P6ncttgB7g=;
        b=YHb9ky0gC2gc//TKSuPvvfWhZDYHmxj3/lvzCW9L9wqpyaJXE0ZcgPkdDKPljW+yL5
         hzKzFf/Je3tQ0Z8aonas/O2vPPwAQz9sOlw0divhY7Fn6bqnw1Lpn9FT46Lm6jkXwyVy
         9Rb1NhKWUV4VA6Oxq6rBUemB4R88wqTiJH5a6+D7MtGMW0tYQx0xqtDrqv8t14efIzQS
         2tTzbUvO31CPBg6oiMvRiVqLbgOlaOUxHWrshVZ+gyoQ0wffpe1WRYnfq8NWfzg1xuCZ
         fU9ZdjV7RMMUg/oZmIVALmo0dihMTF1cNe8dKrj06hnauIabHWtBgwwTRu4+p5vYou2Z
         qxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vxHMS5co0P3s5GEzAdDXcDBEC5Vxm1F84P6ncttgB7g=;
        b=htcpVHsfRPk9VpQYmLhLRNtl13GQcZy/o2r2O+ftLjmHnxCO2wWF3a9ER27Pm+uEDQ
         lI7kmzIHcANnmVW0XqB10fg08PP7VSM1mQZVmXukXt9g4JR+yc3WK1nnxiwbG432Kir6
         iK9omwv3sbuqwIOFXzEaDyRfsndPG7fa43fJi1MmNYSHhzRAaf/5d5DPuUVsCE5aPl8W
         lGCsdfqylEOQSQgmCfGsF2nDC8jxJXyTxni5Qc4wt10fPI3rpXm6/TRWTzADPe6PUOM6
         n1i9Wsa0X1wBgq3NxbbungjurtcWRCMN8FEPhP+S5f+H97pOqFnLOPx7ciS4K8E2EM7W
         +TBw==
X-Gm-Message-State: AIVw111Da2D61Z1CU99qYxtsZvqyWDjVXF4LdSZV94wajdT2FfLIpjfl
        FRxSCKm68toRnwGgin4qW6ifhmU1/Q==
X-Received: by 10.200.2.75 with SMTP id o11mr18224117qtg.26.1500863403970;
 Sun, 23 Jul 2017 19:30:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Sun, 23 Jul 2017 19:29:23 -0700 (PDT)
In-Reply-To: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Mon, 24 Jul 2017 12:29:23 +1000
Message-ID: <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
Subject: Re: Should I store large text files on Git LFS?
To:     Farshid Zavareh <fhzavareh@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Farshid,

On 24 July 2017 at 12:01, Farshid Zavareh <fhzavareh@gmail.com> wrote:
> I'v been handed over a project that uses Git LFS for storing large CSV fi=
les.
>
> My understanding is that the main benefit of using Git LFS is to keep the=
 repository small for binary files, where Git can't keep track of the chang=
es and ends up storing whole files for each revision. For a text file, that=
 problem does not exist to begin with and Git can store only the changes. A=
t the same time, this is going to make checkouts unnecessarily slow, not to=
 mention the financial cost of storing the whole file for each revision.
>
> Is there something I'm missing here?

Git LFS gives benefits when working on *large* files, not just large
*binary* files.

I can imagine a few reasons for using LFS for some CSV files
(especially the kinds of files I deal with sometimes!).

The main one is that many users don't need or want to download the
large files, or all versions of the large file. Moreover, you probably
don't care about changes between those files, or there would be so
many that using the git machinery for comparing them would be
cumbersome and ineffective.

For me, if I was storing any CSV file over a couple of hundred
megabyte I would consider using something like LFS. An example would
be a large Dunn & Bradstreet data file, which I do an analysis on
every quarter. I want to include the file in the repository, so that
the analysis can be replicated later on, but I don't want to add 4GB
of data to the repo every single time the dataset gets updated (also
every quarter). Storing that in LFS would be a good solution then.

Regards,

Andrew Ardill
