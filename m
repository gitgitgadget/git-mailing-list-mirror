Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA2CF1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 17:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeICWNh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 3 Sep 2018 18:13:37 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:44358 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727726AbeICWNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:13:36 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 12C51200416;
        Mon,  3 Sep 2018 19:52:19 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: fix mistakes in translated strings
Date:   Mon, 03 Sep 2018 19:52:19 +0200
Message-ID: <4909221.b3sI1bcdIh@cayenne>
In-Reply-To: <xmqqwosghiw8.fsf@gitster-ct.c.googlers.com>
References: <20180823210056.27489-1-jn.avila@free.fr> <xmqqwosghiw8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le jeudi 23 août 2018, 23:28:55 CEST Junio C Hamano a écrit :
> Jean-Noël Avila <jn.avila@free.fr> writes:
> 
> > -			die(_("run_command returned non-zero status while"
> > +			die(_("run_command returned non-zero status while "
> >  				"recursing in the nested submodules of %s\n."),
> 
> Obviously good.
> 
> > diff --git a/config.c b/config.c
> > index 9a0b10d4bc..3461993f0a 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -124,7 +124,7 @@ static const char include_depth_advice[] = N_(
> >  "	%s\n"
> >  "from\n"
> >  "	%s\n"
> > -"Do you have circular includes?");
> > +"This might be due to circular includes.");
> 
> OK.
Hello,

Has this patch been integrated in a -rc? In which case, would a new round of translation need to be triggered?

Thanks

JN



