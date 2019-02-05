Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD6A1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 02:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfBECmr (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 21:42:47 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:41317 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfBECmr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 21:42:47 -0500
Received: by mail-yb1-f179.google.com with SMTP id n6so465623ybg.8
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 18:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oGx78teqTRh1GsppqQO3z+z7VEcXkT8wKgOXQcQzdR8=;
        b=tL2kpTPSD40It9r3h7bQ3ZiPIAWloP7nx0DnsyftwKF4jrdRGT0EfzngIrMNziRfXZ
         7im1afKzFSWqyh1/nNBOn50+11/m08pdluDpauBq0zEszFmM6r190wxDRmaoYNYGnPar
         rOZC2lbk0vXIjESIqI+1MxDqNo3qtwW0ZqyqZiqHxTM2O8wrRYOlOTs78naDMvVCfWdK
         RstZIY/f1wK8WmM1Sck1rYYELTH5p+uBOWOfX5u/c6lFlMYmkj1kUACA8p/YQlp6TscH
         4cfdyVPMl/uSgSRFgwBQfpIKwsIdP8wsOeUhN8chhUuDTcbfmX32MctjtPvUIcKvZLA2
         6WsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oGx78teqTRh1GsppqQO3z+z7VEcXkT8wKgOXQcQzdR8=;
        b=J0ImgQF6WySsyk5sKHNhNo54nLAAoSZySXrRAEEN1SV+VSYfoydhw9odQl4NKBGuwz
         U1s/kVuHCtfccUI7OiguDogEjiPcXSKimQcqcBxN/yGx8822/FKHKwasw9FLyqjQ8tL9
         oby5brxUvOwICRu3v128mrEmEQqQFTOUFF8thrnrt8j2XoVskKdQwiF3BKoyYNbJ6Pre
         fGlvbRctEx3HNhfnjyGyWCp4sfHF5Gbf1J8aI+fwpzZIg2Bq+xvGTzNrVaFHjh/s+5ZV
         4LTaqfQwY7qCN7Rm637ZOXFueEJTNMAWXTZ6ujEIqP42DjIWH7WCgTJTpxkS2Lc21r4r
         dUgA==
X-Gm-Message-State: AHQUAuZ0yMRjAon0ckBTdISw3NFq4Zfpu5jYLVduTbARTU4Pg75igpxN
        Qdg2mdH4WZmpMZPAtXVMkGmPn8pTeVsCY0ORrw==
X-Google-Smtp-Source: AHgI3IbdkeB1hlWbFaysO3bHjvEAxnCrCd3yLNanzZu9ryFi9WiKZ9IXdvAgW04UzO2gHwQcfHLFAeegrYG+bk6cXDI=
X-Received: by 2002:a25:d8c2:: with SMTP id p185mr2050875ybg.79.1549334566553;
 Mon, 04 Feb 2019 18:42:46 -0800 (PST)
MIME-Version: 1.0
References: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
 <20190205015506.GB527887@genre.crustytoothpaste.net> <CACwCsY4fwr6=2S5CHe5bH7=7Hukq9np+eT1VO+kUDyBtMLKPcA@mail.gmail.com>
 <20190205021513.GC527887@genre.crustytoothpaste.net> <CACwCsY7o=ArM4T4n7umun-R9Dip5NmmOEL7Ygd9zEQdCyQa4Og@mail.gmail.com>
 <20190205024055.GD527887@genre.crustytoothpaste.net>
In-Reply-To: <20190205024055.GD527887@genre.crustytoothpaste.net>
From:   Larry Martell <larry.martell@gmail.com>
Date:   Mon, 4 Feb 2019 21:42:09 -0500
Message-ID: <CACwCsY4tAZm4+R+jxkuSyJUEz8ZTt4_CMW-OU0TRBPpFXp=vJw@mail.gmail.com>
Subject: Re: hook to get info on commit, and include that in a file that is
 part of the commit
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Larry Martell <larry.martell@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 4, 2019 at 9:41 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Mon, Feb 04, 2019 at 09:18:14PM -0500, Larry Martell wrote:
> > On Mon, Feb 4, 2019 at 9:15 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > > If you want to generate a file, you can certainly do that in the
> > > post-commit hook or using a Makefile target. You just can't check it
> > > into the repo. Lots of projects do this as part of their build process.
> > >
> > > An example of what you could do is "git log --pretty='tformat:%H%n%B' HEAD".
> > > That will print the commit hash and commit message to standard output
> > > for each commit. If you want just one commit, you can use "-1".
> >
> > Yeah, but I want it part of the repo so it makes it to the target system.
>
> You can create an additional commit for each commit that you put in with
> the additional file, or you can serialize it as a note for the commit
> (using git notes), which can then be pushed to the remote server by
> pushing refs/notes/commits.
>
> I'm not aware of any other way to do what you want.

Thanks. That is what I will end up doing.
