Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86381F453
	for <e@80x24.org>; Thu,  4 Oct 2018 15:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJDV7M (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 17:59:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36985 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDV7M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 17:59:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so7050569lfa.4
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iq5Z9NwrOhoRGuJefQ7DSCaqYXEIj9n2KDVJr5+2Uhc=;
        b=rFHnEcX1TghYauF165LcsxTpxLWUYoLbWmjZs3IFyGmGdXd9E2OHZ7yu2ME6bbSR9D
         /cYSGUQKWcEbe/1ShO79VoKdrHOT7noqTantKyi821fIzWveJ62TdhD6DMMScMKMoy0H
         hzFENMTkg4VPvsHGpDjgU8yDKuGkkP1AstrIbQaJEYv7fdT1P+EBbxr+OhC3pZ+mPXpR
         OPspQkqqhn40azD+cdiO2Nqmzvmvg35DGufVUz3WbRn+CIhPi6/A4qPK0F4SSEx+aBX7
         lVH8FRepGT7D67uVnFEsbOt0NtfAQvheY+zlWMgb9IkQK+k8iBKvL7d5h2PM35sGIhpi
         oCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iq5Z9NwrOhoRGuJefQ7DSCaqYXEIj9n2KDVJr5+2Uhc=;
        b=KCdv96xFQG7j4kdfONotxxUtd3J3letJw7lO9LCN0IKnZvj2X/QT8Kq0LqPoZC7Jsm
         rzqpdxTAvoAJG4lPoq835md6P2s93X3LY/IioQxemFAynQd4FZncNqRpf2KG1emvNUPz
         WNp7yo6pTNQZDMelYXPEp5s6MpBeAzxgRkegLkn4recbZC4VYzNNHb7w/hH4Ry9jFkL9
         RUGRX/LrNB0kk+B13WC69XBrfRRfZVcSwUmtq9E/mEDjDOtf2d57OJhPBM3wIxri9UIQ
         QNOSgp8+2SFwVtcjiPsRYup3EMjdlrwVteA7pB25wRi2tY3OgFMtPWxkSkFOkgFmc9ba
         gdBw==
X-Gm-Message-State: ABuFfoiyTITdmKJoaThhupwYqRP9tVFqUHBoRppVVvkGConJfm+4hbpY
        KMO9cTHICMeCl35QYUZR/5lHSsFie5iK7stddXE=
X-Google-Smtp-Source: ACcGV61vmntl050x2S6GKnintaqfloOj4jql+6eoryl84G4uUgCr7N14Zx1OLnHUMIGrXUV9ZMp2bMhvcu22ht2JghY=
X-Received: by 2002:a19:eadb:: with SMTP id y88-v6mr3993720lfi.1.1538665529777;
 Thu, 04 Oct 2018 08:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181004113015.GA30901@manohar-ssh> <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1810041624290.73@tvgsbejvaqbjf.bet>
From:   Ananya Krishna Maram <ananyakittu1997@gmail.com>
Date:   Thu, 4 Oct 2018 15:05:18 +0530
Message-ID: <CA+=o6KFN-p901GiJzj5BquU2RKCVTOKarGpjjuqsASN_uqGZSQ@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] git/userdiff.c fix regex pattern error
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 4 Oct 2018 at 19:56, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Ananya,
>
> thank you for taking the time to write this patch!
>
> On Thu, 4 Oct 2018, Ananya Krishna Maram wrote:
>
> > the forward slash character should be escaped with backslash. Fix
> > Unescaped forward slash error in Python regex statements.
> >
> > Signed-off-by: Ananya Krishna Maram<ananyakittu1997@gmail.com>
>
> That explains pretty well what you did, but I wonder why the forward slash
> needs to be escaped? I would understand if we enclosed the pattern in
> `/<regex>/`, as it is done e.g. in Javascript, but we do not...

You are correct, the code would execute either ways. But when I came across
this line, I didn't get it's meaning instantly because as per standards, forward
slash has to be escaped. In fact when open source code is written according to
standards, the code will be reachable to more people.

Thanks,
Ananya.

> Thanks,
> Johannes
>
> > ---
> >  userdiff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/userdiff.c b/userdiff.c
> > index f565f6731..f4ff9b9e5 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -123,7 +123,7 @@ PATTERNS("python", "^[ \t]*((class|def)[ \t].*)$",
> >        /* -- */
> >        "[a-zA-Z_][a-zA-Z0-9_]*"
> >        "|[-+0-9.e]+[jJlL]?|0[xX]?[0-9a-fA-F]+[lL]?"
> > -      "|[-+*/<>%&^|=!]=|//=?|<<=?|>>=?|\\*\\*=?"),
> > +      "|[-+*\/<>%&^|=!]=|\/\/=?|<<=?|>>=?|\\*\\*=?"),
> >        /* -- */
> >  PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> >        /* -- */
> > --
> > 2.17.1
> >
> >
