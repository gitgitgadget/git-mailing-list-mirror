Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E531C1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 06:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeGUHKM (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 03:10:12 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46219 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbeGUHKM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 03:10:12 -0400
Received: by mail-io0-f194.google.com with SMTP id i18-v6so11605360ioj.13
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 23:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RYVypMVsMb6S+I2P0ISwesm4tPB+qfAzeuNmtN6fsp8=;
        b=WLn7MFvu3VOpk3EmRj30Vs05nsXaWSXK4Iv1ux52aTXZfulU+6zLqKlcirhZtG6+RU
         fzHoVaXqiI2au8aFsKI49hwhQrtOxBFyMM4fIcuuSeIlyGIA7hotQDEqACIJs4HIu/A8
         6a3Ec4RJiOOtRwa7lh8ucDsr5KsaYTObQF5ik7YKgvB1wkr7WXFOiTNYH9EW1wXND9mg
         3mjv75FdOWvkgR9LodxR2+sqtN9FtKQphLcbl0athjiEm5WseHCPP8ryXf0hPqkfYAd8
         FIfEmWlQMWvQC/WyEERTTIRj4dyuoBJdpps8g/rSKu7lxxmHgPfFF74hM2QkVRQR+ydb
         YgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RYVypMVsMb6S+I2P0ISwesm4tPB+qfAzeuNmtN6fsp8=;
        b=Ev0D1hsiqNhYYhUVFDxrfhSGm7m/vf5jm2hTMwulnkBpYyfbvP7H75JNBiZgkUCWdB
         qZ573/yiaY9YanoO1LwcNBNjQ5V6IPElf4Rby79CDha4meFfBxJH88oDoTnuwBMRnGTO
         XYNqM3kPIiVX1bbC1m7P6LZ4E1M1Ebfv1XKjrUYv97n/kgQFWjyHHgl01wScbx5xKfJ4
         XyqPlaS2jhbHdkqolev4nfXAFacKNsqb55pax4GFJxQVNFf+rvLWQMOJV6weKwewnSwB
         5BqsPq+jKZx070ZpcmanZUBlXqyOnaMLVRDK7gusvuDlhCWWh9EROiDpB6eREMiLekU3
         ykNQ==
X-Gm-Message-State: AOUpUlFxdSxrOAat74vKx0uTMhcFNNzBpLKnq00MxFBZPhckpm9ORWsr
        +t0/uZw3kNi5l6sy6Znl94fV/XE/uC6KsWRmB+c=
X-Google-Smtp-Source: AAOMgpebR5feKCkX7vMXUBYCKJ+/poBRwOTLaCHXBiPE18F9k0dVda6soBBGPblDXnbBLThUy+RUdw+wBlQtDC9gC6o=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr3787643iod.118.1532153920602;
 Fri, 20 Jul 2018 23:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180718161101.19765-1-pclouds@gmail.com> <20180718161101.19765-3-pclouds@gmail.com>
 <xmqqmuunf5ny.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuunf5ny.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jul 2018 08:18:14 +0200
Message-ID: <CACsJy8CMJJ1xW1zfnngGXqhJpwL0_dw9o7rTfq-YRTfqKjt-7A@mail.gmail.com>
Subject: Re: [PATCH v2 02/23] archive-tar.c: mark more strings for translation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 8:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > @@ -256,7 +256,7 @@ static int write_tar_entry(struct archiver_args *ar=
gs,
> >               *header.typeflag =3D TYPEFLAG_REG;
> >               mode =3D (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_um=
ask;
> >       } else {
> > -             return error("unsupported file mode: 0%o (SHA1: %s)",
> > +             return error(_("unsupported file mode: 0%o (SHA1: %s)"),
> >                            mode, oid_to_hex(oid));
>
> This is no longer sha1_to_hex(); the "SHA1" in the message should
> probably have been updated when it happened.
>
> Cleaning it up is outside the scope of this patch.

Yeah. I also asked Brian [1] what to use here instead. I think it's
much easier to go through git.pot then fix all at once. Whatever
leftover after that could be fixed as we see them.

[1] https://public-inbox.org/git/20180603182724.GA288937@genre.crustytoothp=
aste.net/

> #leftoverbits
--=20
Duy
