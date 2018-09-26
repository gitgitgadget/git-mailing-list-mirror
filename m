Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6851F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeI0DS6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 23:18:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41073 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0DS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 23:18:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id m15-v6so462328qtp.8
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 14:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VrE9oF19UlBaz8VI8OaH1PPbuw1PyVNccLV+EzDxscw=;
        b=nESTq9RJ5cfoi5gbrN8lGfRiWRA5sQF6LE4Nx2u0tMC1rbW1Ijr0gA3gNwhbJ3Xq15
         nnwg4LQjkoOCH1lN961a588+A5K9dL884RCC0zAfIVraCUTMrv/V7qMKpHoia5TOR0RY
         lfalCqteaayaq+7iePWixhUhrWMpnuTvEFer1tzKMepE/NXvtiCWf9SL4qRvESfpRSmI
         FnsMHj2/um1CXc/a3H+drGIo+m8h+ba4SyZSCsSVtBt2IIwvcWBPdKHSBlca5dhb27yR
         Zg6e/3C3PtfjEA74rs28vgETRs3TCG/CfofuWtotus8hTkMM0w4OO+wO/1sF2Bn2i/jK
         f23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VrE9oF19UlBaz8VI8OaH1PPbuw1PyVNccLV+EzDxscw=;
        b=nRc2tnbbmAq77JTdXaAFhNfKcgCfkjGTsn4uzembv0tqEkmeOB31/yBQBPZkEDsoFl
         baLQVdnrplXYczT/qDsGWJdcs895OXCRnRDPEaTY4jiJGfRjxD8erqLUjucPAztFuloB
         HeGTY8MzZlL1QpTMERu6fVa0caCNYA4YID5H/55T6w4ERvJ05NZyz8g5tKcRZK+B40HK
         /MUatsqwLkqDnyItA/2q8KeenykigrR0G+SbMe5VQwBjvVyUKkcrcOlFeOVGaVnWy5nF
         jc+X4piLfZFFPMVJ/vHIdPlzWZbTo0cKDQ/ohU01P6aSu3jAaHilHhkWXZMJ1Cme+sjm
         iVCA==
X-Gm-Message-State: ABuFfoj37yNXqJ5Opa0OgwITgaN4xTAcDOyUrTZbimMzwlT6U0gERfgL
        ihytLv4SyM2bxKTSEHm+i47JvSNVTQjmuoc1plU=
X-Google-Smtp-Source: ACcGV63mI8x8LTM70uwdwv3QMwUPGqQD2ocouXWT1m9fBByEnrKYflvA1Z0BkihgrQlcMBdjuPJDP9DjXtUH51gple8=
X-Received: by 2002:ac8:60d0:: with SMTP id i16-v6mr45094qtm.249.1537995848896;
 Wed, 26 Sep 2018 14:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.41.git.gitgitgadget@gmail.com> <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
 <20180924213223.GG27036@localhost> <20180925070618.GB1596@xps>
 <4d276a77-0ac9-c1d1-b5de-3ded394efb0b@gmail.com> <CAGZ79kZEN9pSBAdVajfRrrb_D3twD+C7hnzZti+TqO0-sVp9PA@mail.gmail.com>
In-Reply-To: <CAGZ79kZEN9pSBAdVajfRrrb_D3twD+C7hnzZti+TqO0-sVp9PA@mail.gmail.com>
From:   Matthias Sohn <matthias.sohn@gmail.com>
Date:   Wed, 26 Sep 2018 23:03:56 +0200
Message-ID: <CAKSZd3S7pZUgu8MK7F26cmdX5PwP7TAcCY9-Dduj_1OY+Vfhnw@mail.gmail.com>
Subject: Re: [PATCH 1/1] read-cache: update index format default to v4
To:     Stefan Beller <sbeller@google.com>
Cc:     stolee@gmail.com, ps@pks.im, szeder.dev@gmail.com,
        gitgitgadget@gmail.com, git@vger.kernel.org, pclouds@gmail.com,
        peartben@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 8:01 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Tue, Sep 25, 2018 at 7:30 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 9/25/2018 3:06 AM, Patrick Steinhardt wrote:
> > > On Mon, Sep 24, 2018 at 11:32:23PM +0200, SZEDER G=C3=A1bor wrote:
> > >> On Mon, Sep 24, 2018 at 02:15:30PM -0700, Derrick Stolee via GitGitG=
adget wrote:
> > >>> From: Derrick Stolee <dstolee@microsoft.com>
> > >>>
> > >>> The index v4 format has been available since 2012 with 9d22778
> > >>> "reach-cache.c: write prefix-compressed names in the index". Since
> > >>> the format has been stable for so long, almost all versions of Git
> > >>> in use today understand version 4, removing one barrier to upgrade
> > >>> -- that someone may want to downgrade and needs a working repo.
> > >> What about alternative implementations, like JGit, libgit2, etc.?
> > > Speaking of libgit2, we are able to read and write index v4 since
> > > commit c1b370e93
> >
> > This is a good point, Szeder.
> >
> > Patrick: I'm glad LibGit2 is up-to-date with index formats.
> >
> > Unfortunately, taking a look (for the first time) at the JGit code
> > reveals that they don't appear to have v4 support. In
> > org.eclipse.jgit/src/org/eclipse/jgit/dircache/DirCache.java, the
> > DirCache.readFrom() method: lines 488-494, I see the following snippet:
> >
> >                  final int ver =3D NB.decodeInt32(hdr, 4);
> >                  boolean extended =3D false;
> >                  if (ver =3D=3D 3)
> >                          extended =3D true;
> >                  else if (ver !=3D 2)
> >                          throw new
> > CorruptObjectException(MessageFormat.format(
> > JGitText.get().unknownDIRCVersion, Integer.valueOf(ver)));
> >
> > It looks like this will immediately throw with versions other than 2 or=
 3.
> >
> > I'm adding Jonathan Nieder to CC so he can check with JGit people about
> > the impact of this change.
>
> JGit is used both on the server (which doesn't use index/staging area)
> as well as client side as e.g. an Eclipse integration, which would
> very much like to use the index.
>
> Adding Matthias Sohn as well, who is active in JGit and cares
> more about the client side than Googlers who only make use
> of the server side part of JGit.

thanks for the heads up, in fact JGit does not yet support index version 4.
I will look into this.

-Matthias
