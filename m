Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 938BB2095E
	for <e@80x24.org>; Sat, 25 Mar 2017 12:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdCYM0q (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 08:26:46 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35912 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdCYM0q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 08:26:46 -0400
Received: by mail-oi0-f41.google.com with SMTP id r203so6038685oib.3
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aKVDofOHXGH3aPdORu9P8bZEuMMv6P7Dv+FJNaVt3WY=;
        b=eUNn57RwBR9nR0ECGnjAWBOw9nIm1vN2y7Nhx3OBuoSnd4M/tNl4DigzzCME2fB8gg
         XvZrJv9uLCtJeVBh7mmhElNzoEpwEkJlU+i0d7CACUF436gJTN/adQzq4bDCpJj1olhF
         WuAfNYpzlmf819s+D7rP43rKOG5jceATZ31SzQ6F5LU9bPfqBEG21Ar1KN0V6l62ikO/
         h/0h3y8v0m+hUwNaJhknJayE94A2TceZv2fsJ5GHnJFoFGaqIPf848MiNH7nZtvKoh73
         FjJrcBai0InIHtgVrMT8gxvfkeGLX52ojQQrKTRESGIOD8FsVOrV6ZvEX+/wsQnMJrcG
         SNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aKVDofOHXGH3aPdORu9P8bZEuMMv6P7Dv+FJNaVt3WY=;
        b=ChHxiS8+TeN1D72fr3xR59onRonfSqepbX5JsUTkgtEHGKnSAYAI+oiRpBuG9t33Eo
         Jg1/VL7/DceJVwS7bleayyoHRNXIxRR8/PxFLVTNgMOXVPiNRK8I/Lqe8XPo8maPR5yf
         HpEitvf41LwlfyuODOxPaw9Qe7vSjoDbM7+DrSDAaXi+r7fOQ2vCIuLnlsR00CUW91ow
         D06G4FyTy/4ex3/bfX/dttsalkav+t1nGycE2i4wO/4YljjzeJCfMdjupGbCMAQN9dVS
         Ip7AiJSU7/n4XXbHsVk/7BaPHe41JhyfL2mzRQhkKzVEI4DABuU+kcoIzwJES/jedy8f
         4ZZg==
X-Gm-Message-State: AFeK/H0AXFceodcxm1WodObVpl5+h5Mgh5CYtz2gcvs7k+AJsszHmBSBaL3/YZvMj0PAMIs3Gy4EYFG9Q/7ICw==
X-Received: by 10.202.182.7 with SMTP id g7mr7013013oif.175.1490444804625;
 Sat, 25 Mar 2017 05:26:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 05:26:14 -0700 (PDT)
In-Reply-To: <CACsJy8B1DWL9uHPZoQEO+ytkt1M+qV-x0F5CWFLFSG1utxO9EQ@mail.gmail.com>
References: <fad6ea92-0a44-de30-48e8-09e7c567cd4d@web.de> <CACsJy8B1DWL9uHPZoQEO+ytkt1M+qV-x0F5CWFLFSG1utxO9EQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 19:26:14 +0700
Message-ID: <CACsJy8CZdZuxpwbfB+TgHdH9YneeUxUhkF7XuLhWw6Lp9ZLPDQ@mail.gmail.com>
Subject: Re: t1503 broken ?
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 6:46 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 25, 2017 at 5:46 PM, Torsten B=C3=B6gershausen <tboegi@web.de=
> wrote:
>> ./t1305-config-include.sh
>> seems to be broken:
>> not ok 19 - conditional include, $HOME expansion
>> not ok 21 - conditional include, relative path
>
> let me guess, your "git" directory is in a symlink path?

Yes I could reproduce it when I put my "git" in a symlink. There's a
note in document about "Symlinks in `$GIT_DIR` are not resolved before
matching" but failing tests is not acceptable. I'll fix it.
--=20
Duy
