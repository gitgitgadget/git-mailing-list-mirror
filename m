Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507D21F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeCMTT2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:19:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34854 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeCMTT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:19:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id n12so2078273wra.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=i+bVaQOVV79cObo0BBJyQ7uIfCInHCnrrNdJ5uqqZqA=;
        b=OebjqIDyKyGle6wnUYWS2afm//6zg+rK5MKO51bgJn1S0clrwTmN4Fg39IZqE3quLC
         rSllL2N7it6TLsc+WIKIZnA5nutBccdtCCaPvx2MgVyeAQTGfGgPeNQ/UyEeV/Uytl8Y
         0yviVNXeY4uMssLAgGHsGGAkdov/IlMh6uCct2K/+VjzaLX3apSyTNiyoW2xqp3X4Muj
         QObU0LQoOsgDChGoS+lFbSUVY80ZW/otXlKApMESYyYcGwCLY9K0x5P5A+g1INMgxHwT
         iqkD0aCJzh33kxT3An/gqPA+O/GNKylZcasB3/f8wpkEYSIeN0WCGka5xG+ULGQo1qvN
         Bp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=i+bVaQOVV79cObo0BBJyQ7uIfCInHCnrrNdJ5uqqZqA=;
        b=iqKQnKNBWnuDH4+HbhEFHpKDEM7qAP/AaoB+kJgaC4jmM57l8Dgly9YRrKu5vubfxU
         m0BMUj3OgUbAEw0YAMQBEhMefvkNXB8lMDuc/ocRlTwzDlmUTx6j/BBtXIO0jsKEsqjI
         GKXWBDN4tOQtsyFgiS5Ysqm+dMWRSye6yPOJmRF25CwszCdFXg8VvVA2OL7vBMw2k4hB
         GSXrvyxkdWzg22+n81nThs44Fk4S1FpRWomV25ICowcEb6raKlMQRChY8CbNavt2CqVR
         AgEsRSAU+XYHLglnLLl0cBPCFYHqDBz4WcdvQ3VbheBK96Q8oWT4TUsEEvRVnksKxtNE
         Wmmg==
X-Gm-Message-State: AElRT7EwitF32JpP6gBreikTeVT9fxKQ4+6lYL+LtFTnlP3wDrl0lYzN
        hPA3oeNyLG9b/dI1DDm8JHicrkIF
X-Google-Smtp-Source: AG47ELsC8yhM2ZIiAnqR6q+p1ZcC7QaPYn+MbyrIsM5Nx4vSVJ/J6O5b64yuRCx1LQIwaG0tsFCGfA==
X-Received: by 10.223.159.79 with SMTP id f15mr1554099wrg.115.1520968766576;
        Tue, 13 Mar 2018 12:19:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z73sm1145108wrb.50.2018.03.13.12.19.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 12:19:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] git-shortlog.txt: reorder usages
References: <cover.1520680894.git.martin.agren@gmail.com>
        <3d4119e89c8d7c1936c29cc68d7c3dcfed8a96f9.1520680894.git.martin.agren@gmail.com>
Date:   Tue, 13 Mar 2018 12:19:25 -0700
In-Reply-To: <3d4119e89c8d7c1936c29cc68d7c3dcfed8a96f9.1520680894.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 10 Mar 2018 12:52:10
 +0100")
Message-ID: <xmqq37133hs2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> The first usage we give is the original one where, e.g., `git log` is
> piped through `git shortlog`. The description that follows reads the
> other way round, by first focusing on the general behavior, then ending
> with the behavior when reading from stdin.
> ...

The result looks a lot more useful than without the patch.  I think
the current ordering is merely a historical accident made in 2006.

Will queue; thanks.

> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index ee6c5476c..5e35ea18a 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -8,8 +8,8 @@ git-shortlog - Summarize 'git log' output
>  SYNOPSIS
>  --------
>  [verse]
> -git log --pretty=short | 'git shortlog' [<options>]
>  'git shortlog' [<options>] [<revision range>] [[\--] <path>...]
> +git log --pretty=short | 'git shortlog' [<options>]
>  
>  DESCRIPTION
>  -----------
