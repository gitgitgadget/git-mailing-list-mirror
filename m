Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E74C20248
	for <e@80x24.org>; Tue, 26 Feb 2019 20:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfBZUGQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 15:06:16 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39761 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfBZUGP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 15:06:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id g80so11907184ljg.6
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 12:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r1/SnvfeHU96V5ngbarABtQfhz2aYtZQCs8C+utpRm0=;
        b=EAhPTBvmaKU5SyI5Zw/IZ33+LbUADvCqaxEk/JLejZuI/ESuBjx3bvYBon0hCVRE6Z
         VNyKX/YmjFhG1FOb2U4LHr/B/bgf6tQBiMBUOV0Er3rRBrr/1YIWJQRV1tZPVHKsJfB3
         K6OV8wlnd+JIRKkkQ3trPVogXUW+Z9LQ+y79r4nrkv+41tH0XIhVvjNUt01ZZ27WAEIA
         QKVOIzwu3KKL7lH9wsmpavGp/LTcMmLkMl8h4V6qeeEa2hnYzvY1iGpbCIYHXUNeuMDS
         MEssNKcCx0eXRiZ1WttV8GSQ++DOTfYmH1iRt4obQbIE6aY2Q4h2BLjQC4NgB+6zJX5H
         O53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r1/SnvfeHU96V5ngbarABtQfhz2aYtZQCs8C+utpRm0=;
        b=qPdxU3yOHZb7bDM119aya1HwPnavAzXKgowxGbayJ3GaWAMMuSyIK8R52xwIYn3HX9
         up+YXUwk/qBq/uAyIW4kIbTJiyo12mdmH1YyRZNXkJuTZEZB0pPlurBXuCaCkIJR7upz
         vZLY6VQCZ/UYbHbrUzh/R8VXeffR5ROZ1xpRMvVDi3RdUIOQgaf9lded/rlEFaaCRbtk
         bkxBrLEBZmxUZH9GilreVC7kkdHIFAT83zLQyhFYkUUtVS7bmjZb8vrU1V1bSOkH3tnN
         Mgcu7Udi4sKYFyoxFGX7UV8x3JxHM0GxASJSOg/14aYaTOEO3mV6nL6OnJUgre8MKA9Z
         WxiA==
X-Gm-Message-State: AHQUAuah1z4NnZ3Fxo64xXf8z6MF9nZjnBRyb3NtKmEs6u7Xy4nPlQYb
        F2Nx9fT8sIQPUF5Hc2rP488JFoWY6wfCbSAxf88=
X-Google-Smtp-Source: AHgI3IbnTcKgqsxqa/4DBlqtNjyGwOwercIc4GOZfCxEzlSnjzBclO0AlMN6mwPQ9xjkQKJz1DjpwalhU5NMPFU7FZc=
X-Received: by 2002:a2e:20cf:: with SMTP id g76mr14272157lji.36.1551211574120;
 Tue, 26 Feb 2019 12:06:14 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <pull.152.v2.git.gitgitgadget@gmail.com>
 <fcafc87b382dfef00d8e33e875bcb8b03d5667e4.1551191168.git.gitgitgadget@gmail.com>
 <20190226163737.GB19739@szeder.dev> <CAL7ArXocrtCBpEoCM6_aSWcKgaVDwBADMZ9WEBzxpwOfHKuHGQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1902262101180.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1902262101180.41@tvgsbejvaqbjf.bet>
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Wed, 27 Feb 2019 01:35:15 +0530
Message-ID: <CAL7ArXp6YhpzXdbuXD3HmdUPC38AqBdAnVn5MRRNgjHgbHBvqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] t3600: use test_path_is_dir and test_path_is_file
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

On Wed, Feb 27, 2019 at 1:33 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> I think what G=C3=A1bor meant was that both `test ! -f file` and `! test =
-f
> file` should be converted to `test_path_is_missing file`.
>

I'll work over this and submit the patch.

Thanks for clarifying
Rohit
