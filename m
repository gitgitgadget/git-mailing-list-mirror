Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2E21F404
	for <e@80x24.org>; Tue,  4 Sep 2018 01:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeIDFYk (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 01:24:40 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:35600 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeIDFYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 01:24:40 -0400
Received: by mail-qk1-f174.google.com with SMTP id 89-v6so1368552qkp.2
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 18:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gKG7tW3PD67zWp0HAv0QoOpNMcRCI/ak6m4x1ktBuhM=;
        b=d4uD5AFin7i/I4ol4R0bcOH6RnXf4Ug3ZXZa1GbWeFaVc0PWf6SeLi0RwBcdxRXSvV
         7JUkpDGADizPBkBpi0vH+82sJikD19yXpbkrKZDUHNqDDEyh5wCDqHV66bSpfiO5YrKH
         +mopeKlzJr547ejGnzwAoy6/y9jgFLnikvE1dUY9Ir+ouK1SuOTRKtBpaNNAdaim4Btf
         Pm4oNAEd6ilmx9jAj34IYkr9QUO4hzkVXcbR45TL/E2DaMtYzLYTRki/NS5/edyt0Q+K
         RZIkpOgbmj1/2c+Y5hnFe7ZzAq0LN4QTpJy/uSl3rlhDq5QUSciDu84116ffzMkGZEW7
         c3rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gKG7tW3PD67zWp0HAv0QoOpNMcRCI/ak6m4x1ktBuhM=;
        b=SUiP6e2xNxC+220hbbZPWCTzuUtC9N/ewfR30P7v5bsRQ9i4Q6LzcEEHh94jLEtZ9S
         7U32pf9WjNr8/jcNDf0SwELBlDL08mk5cRbrTOkJ1JwRrsxc4vM1CW2Af4q8S3FsFLvD
         IhekEpBURtE8KUkKnNLKcNMa/nZlyEBIg7pwe0moc+W8nm/1JL4vMO++UlXcCaDjDoMp
         kQknFM/A4xvxghpJVbHPtIOALQU2dw2XBUEe/m2UEjZC2VBEAoWtlDSYY34zpYgJbe4v
         6+AHbMn0mn7rR9kx5grH5jJhvTi3ZwLthahnXJU6iUT0UpmWauH7Qp6NZQu+Ut/S2w0F
         l+9g==
X-Gm-Message-State: APzg51AevvowbiZh9BLJDuCF9Qds+HHLoHwidxiLkawEwKAvzB2W5RNc
        i2hs9ABzCMRhW5PgOIW8gOei64uxJ84nvEWXcxw=
X-Google-Smtp-Source: ANB0Vdam1swRBPmS1qGvY0MOZEau1lQMC0w7GagyiXZW9fJTJQhCGE9EdwXbQgtI/euW4yXXLoWq8T/oP2+PpJD6qGQ=
X-Received: by 2002:a37:9702:: with SMTP id z2-v6mr26992406qkd.183.1536022920798;
 Mon, 03 Sep 2018 18:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180823210056.27489-1-jn.avila@free.fr> <xmqqwosghiw8.fsf@gitster-ct.c.googlers.com>
 <4909221.b3sI1bcdIh@cayenne>
In-Reply-To: <4909221.b3sI1bcdIh@cayenne>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 4 Sep 2018 09:01:49 +0800
Message-ID: <CANYiYbGt=jK6=wAat8UmQBBUNrKe35ALFtBJQJAtmF6CoNnEsw@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.19.0 round 2
To:     Jean-Noel Avila <jn.avila@free.fr>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Let's start new round of l10n for Git 2.19.0.  It includes fixes from @jnav=
ila.

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in =E2=80=9Cpo/README" file.

--
Jiang Xin

Jean-No=C3=ABl AVILA <jn.avila@free.fr> =E4=BA=8E2018=E5=B9=B49=E6=9C=884=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:52=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Le jeudi 23 ao=C3=BBt 2018, 23:28:55 CEST Junio C Hamano a =C3=A9crit :
> > Jean-No=C3=ABl Avila <jn.avila@free.fr> writes:
> >
> > > -                   die(_("run_command returned non-zero status while=
"
> > > +                   die(_("run_command returned non-zero status while=
 "
> > >                             "recursing in the nested submodules of %s=
\n."),
> >
> > Obviously good.
> >
> > > diff --git a/config.c b/config.c
> > > index 9a0b10d4bc..3461993f0a 100644
> > > --- a/config.c
> > > +++ b/config.c
> > > @@ -124,7 +124,7 @@ static const char include_depth_advice[] =3D N_(
> > >  "  %s\n"
> > >  "from\n"
> > >  "  %s\n"
> > > -"Do you have circular includes?");
> > > +"This might be due to circular includes.");
> >
> > OK.
> Hello,
>
> Has this patch been integrated in a -rc? In which case, would a new round=
 of translation need to be triggered?
>
> Thanks
>
> JN
>
>
>


--=20
=E8=92=8B=E9=91=AB

=E5=8D=8E=E4=B8=BA=E6=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8
=E9=82=AE=E4=BB=B6: xin.jiang@huawei.com, worldhello.net@gmail.com
=E5=8D=9A=E5=AE=A2: http://www.worldhello.net/
=E5=BE=AE=E5=8D=9A: http://weibo.com/gotgit/
=E7=94=B5=E8=AF=9D: 18601196889
