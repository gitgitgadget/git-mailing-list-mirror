Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E81F51F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 06:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeFBGST (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 02:18:19 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:43850 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbeFBGSS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 02:18:18 -0400
Received: by mail-ot0-f176.google.com with SMTP id i19-v6so1199943otk.10
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 23:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AcEwUqCbbQJy3/HzWopVxeYHXmE1ycKaJdkS+p3v3+A=;
        b=lhHCDAiXaTtAzu3phS3m0aAelrpbSrlA8v49QAInLhbGt4/28T95eyIhWbJiSW9iiE
         TuThq25fkKC3uop093Gs4Eue++DFreqrI9QiItjQ8B7dfi5KJ3QDnV1Z2MtuXRkRHASV
         pC2Ybc/T5LCXV5ulQUxpOfHligs7k2CvMoir5bzXjR0rmibzOPktFBBcjJCRhc+8lKJ2
         Fe/vGG4Of3Cao1rewKPQesi1bCDgHRZEuLSDtL6Mmyw5tUJy8Pf5lETNMa9t7Hd7gKYT
         QxCoMr7yAWMdeRPBYC4aHMv6AYdbLcqb8NR23K9Lmm7ZTuG14g7/Pg9d5kX+maGsjnZm
         1btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AcEwUqCbbQJy3/HzWopVxeYHXmE1ycKaJdkS+p3v3+A=;
        b=L/G6EM1vwLb/nSULPiSrsC+pLjiZnqtogVvAgDbSrY8PNoVrbUtJ7lQDLAFhDgDqLS
         b70CMdYSaeJzdWnP2cgZLfLCzwMAdEqBelqNNtrR1MrlXqREpFQvJnopSW91WIRLs30N
         RZMEOBs/kQHpIWgIBop6cxUvua9W8CwWOwPzXtdDxHM44iwK7uYn5pAMfcbV0/O8FNDp
         Xd028ypPe4A2/FwspvK6N76tUv7+kjO+NyLoUlABqM0LPmRYHWftNusbISUsa/3f8LRM
         NeUGZs3PLmKZ+VXdhNYh4z5g2w8LJd3xEO4cdoA+Ii40PzxlAh7ZnlcjOHAhCxKD0rm5
         RimQ==
X-Gm-Message-State: APt69E2tQyd8PNLEpYCfdta2vd5jXQGHyOFSo8rOry5cZ/bzn5JleQe8
        ttUP3rADMySh1vyIkI3lLqH3pONXL+bZogxUn9UOzQ==
X-Google-Smtp-Source: ADUXVKIrtr1WrN7Tjyt63vTZLjD8WDf+cPL6Jw3YOQnSv21BNEjgYg/g7/CDmaAuuuHJR4vQ5bp8cLiTlytIGcEOu84=
X-Received: by 2002:a9d:1d92:: with SMTP id y18-v6mr9694806otd.304.1527920297612;
 Fri, 01 Jun 2018 23:18:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Fri, 1 Jun 2018 23:17:47 -0700 (PDT)
In-Reply-To: <20180602043241.9941-3-pclouds@gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-3-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 2 Jun 2018 08:17:47 +0200
Message-ID: <CACsJy8DZC1xd5O=Qf=HEQeDQ0xpwExnnLvgqemNE77mVwQckeg@mail.gmail.com>
Subject: Re: [PATCH 02/22] archive-zip.c: mark more strings for translation
To:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 6:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>         if (pathlen > 0xffff) {
> -               return error("path too long (%d chars, SHA1: %s): %s",
> +               return error(_("path too long (%d chars, SHA1: %s): %s"),
>                                 (int)pathlen, oid_to_hex(oid), path);

Off topic. Brian, do we have a common term to use here (i.e. in user
facing messages) instead of "SHA1" after we move away from it? Is it
still "object name", or "hash" or some other fancy term?
--=20
Duy
