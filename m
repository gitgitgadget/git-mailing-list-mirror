Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24CEF1F462
	for <e@80x24.org>; Tue, 28 May 2019 09:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfE1J6E (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 05:58:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:54621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfE1J6D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 05:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559037473;
        bh=MGReiPzxE8BS2RKwHyC0nVov9bqYZUcWW7eq/E6fIfs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GjhrDim2Lu6uZxrpi7eTFRdRPWJGSbD1Nkf9+ukNiaXxufEiu9VgAzNWeGa45eWxu
         khGUqT+K2AVBHoAf4kpsS2drtGZ7qj2qEDi8XoHy4FKzJcF7C2kixhJRc7+D1ko2+g
         UJkz+XIKgeF5VCfF6G/SJfluqGoi7iVDYlgy73sg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLunc-1hWgOr0KaK-007pXe; Tue, 28
 May 2019 11:57:53 +0200
Date:   Tue, 28 May 2019 11:57:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.org>
cc:     LU Chuck <Chuck.LU@edenred.com>, Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "chuck.lu@qq.com" <chuck.lu@qq.com>
Subject: Re: git filter-branch re-write history over a range of commits did
 notwork
In-Reply-To: <3cf99e80-98aa-639b-ac9d-a882da349fc8@iee.org>
Message-ID: <nycvar.QRO.7.76.6.1905281154390.44@tvgsbejvaqbjf.bet>
References: <DB7PR05MB5573AD842E430342E2BD011B8D1D0@DB7PR05MB5573.eurprd05.prod.outlook.com> <db2dcf54-8b1c-39b1-579c-425ef158c6a1@kdbg.org> <75618ca1-748d-0761-9108-c7deac63cb53@iee.org> <DB7PR05MB5573B5B80C8A9CBE867803D88D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com>
 <fa23e865-94ed-308f-6a19-75b6ea89eec3@kdbg.org> <DB7PR05MB5573B5FC17FD1F221F7AAD558D1E0@DB7PR05MB5573.eurprd05.prod.outlook.com> <3cf99e80-98aa-639b-ac9d-a882da349fc8@iee.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+ruTyr0OZPnP0HviEx5IdRNTVo3MRFpnAnDOTkS6QTBXanx4NEW
 AvsEuXJ9/JK9Xx5FRf51QtAhnHXXz1GYgcPrXhbYBkvHIKKbmADTktEE8y6fCvdNx0nTYao
 plFQkvtdtLBuzNhrX4MMo0riJ/6vtojG32xkjHDMEiFe99RlKGIqYhOY0LCS9ik6GN1JgC2
 Gl3rUinG3Ad7D/pCKxgqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3ocSBtsaFDQ=:quP5yd5hCpFg1u1O+udKyI
 /TA+UI5VUT/Qg37IJPc/AOeW3AZT2RVHwZyROI50USrr9Q9NXsSQvlsI+GWF3M9ZlII68x9xD
 FWUxbDOulXcPZD4SaGc6RklqjVZpHo52soj+1udY/xSTTcfBu5swa3zerQ2GZjzuxHOrQafts
 2Fx/n5FxhSNbuoKKLBLwoKgjzB0GM3k/sX8Te4P1ZLBbj/tammQwK2XF7vo5E4r04aNzbyi+7
 CsAQo2tU1P6kTZOkFRaKa04jDnvvYaf4cGkVg9KarWgxRbQOM0FPeJd+HA/qxovNT2qqI0P+A
 DJ7wQUSGqPZfA0fo3LIyaNTd4px+e6WEaK4qLkAeOWudXAPEmyQWEdtlGUyaa00h0Kh28XkzB
 tlcDO3vaDn2rxMibqJV7eTOynKvEkY56Pb37H844hpR8+jJf6b6gXogctUAwM5XJQFr3fc7tf
 A1Ucn3KZ4dbRLANYuIwu5L1oEIczd9oA51kvUZhWpN6mwZsIUN1yBdpcPyBM1Z69SRvvvB3ug
 XVscPsiDVSwmTGU7pt+Wru0ELslcuNifysc4JJxliuXsk0wVIsd8fFe31x8Bk6357SUIo4jv+
 P5OMfsSlmGzeSuFKYvnfnXbaSzX5PSYfFmQi7CwRDOMSdB6BkXOsALh3nIjDgPVpfL2p5dWwx
 J9JYOR9ksMwL+ml0m+LTAX9HehkSOHP+WRkN7nA8iu/pQET0ckMNtRyEoLcmvI7JPLTbVLXkc
 kvKn5LpC6YFivycoJ71kBzeBfHuKW8YBn7k4ChTf4o3hUiy/L4j6kH8WCIt7bl4OSAzjpAc2e
 8S2b0Ca1WPX80UZn9OFRrOvMdA0uJrSAeic6FBUbvV+4NAHLMcfB+Nq/4urmJkfdKD/RvTwBy
 Dg8FDogfaVTvmK/NBIzI+AolQWNV8jvJHBVEXEECOPCI1ZpEmemxFwFTUU2Ijz2AjTOeYLOct
 IanNCUiWO2mR7/k2tTCKVgOqorvPybhlKXZiviOsrKWYpSmCq/IFT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 28 May 2019, Philip Oakley wrote:

> On 28/05/2019 08:10, LU Chuck wrote:
> [snip]
> > > Copying and pasting examples literally is dangerous. You should know what
> > > you
> > > are doing.
> > >
> > > "..." is a revision range that computes the mergebase between HEAD and
> > > HEAD,
> > > which is (surprise!) HEAD, and then includes the two end points, but
> > > excludes
> > > everything below the mergebase. So, the revision specification that your
> > > command ends up with is
> > >
> > >       HEAD HEAD ^HEAD ^67d9d9 f70bf4
> > >
> > > Which is empty if f70bf4 is an ancestor of HEAD.
> > [LU Chuck] Sorry, I can't understand this part, did you have an
> > documentation about the explanation for ...?
> https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-Theem82308203emthree-dotSymmetricDifferenceNotation
> >           "computes the mergebase between HEAD and HEAD" I have no idea
> >           about this. And you also talked about mergebase, but in my
> >           situation, there is only one branch with 5 commits. I did not have
> >           a mergebase.
> >           You can check the detail description below.
> When there is no specific revisions around the three dots then HEAD is assumed
> (to save typing)

From
https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-Theem82308203emthree-dotSymmetricDifferenceNotation:

	The ... (three-dot) Symmetric Difference Notation

	A similar notation r1...r2 is called symmetric difference of r1
	and r2 and is defined as r1 r2 --not $(git merge-base --all r1
	r2). It is the set of commits that are reachable from either one
	of r1 (left side) or r2 (right side) but not from both.

Most importantly, the next paragraph states:

	In these two shorthand notations, you can omit one end and let it
	default to HEAD.

What it does *not* say is that you can leave out both ends, in which case
it becomes the non-sensical short form of `HEAD...HEAD`, as Hannes pointed
out.

Ciao,
Johannes
