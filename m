Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97B91F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751239AbeEDHRi (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:17:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:56695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeEDHRi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:17:38 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ln8gj-1egpFJ1DtV-00hNFg; Fri, 04
 May 2018 09:17:32 +0200
Date:   Fri, 4 May 2018 09:17:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 17/18] branch-diff: add a man page
In-Reply-To: <CAPig+cR0V-UgKg0iDfAXLPiSANLv2b3CbwGNKk=VBvrZjX5FdA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805040916550.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <edb34bd4f8da7437efb20e442780f17e9f84fc73.1525361419.git.johannes.schindelin@gmx.de> <CAPig+cR0V-UgKg0iDfAXLPiSANLv2b3CbwGNKk=VBvrZjX5FdA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5wXHUouWlXocmWtFDGkywRyRZ2bjjpTxURcFnMMimLsQ2dYEUjk
 9K6FYCtZV64YD2VvKKPakpr/9UhjgOIFI+PGKOoDpKQ41SQUeIV+2gcpVsuuoN3SVOVs7OG
 NcqvwEbMakKwpdNHLfVNNFGhZhLF3hGM63ONAqXBLe3sqC8iSqCUvAmo7tmKcpHeucoV9G1
 MHcrB5TJhw6qePeMQRbFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vn9paUuvDks=:frPIzjCVRu7jvqvtnFDhTn
 qtvwCGPkkuTq6hdTwweklPKB/XsHNZm4WqpjJaB6e1q/Qm8ViSdn9eTmAmAk0kQTVNfHbsVUU
 2rn7EVsYof6gujNdGkQQyrPqUbyE4O/P7bLEAtzzPKZma7DffqCizdSU1W44rpAtYrMyFy8Ge
 O5nDxE1UUmFdBYGkvjC9M3v5TbHylxDMcVqw0CDH/j8Zic0FZ1gC7Z4FXMrQHvUbi/icIfF01
 AtjjGQjUWOQ7t4vQI7rIlWVGdnEHMsg+wqzmDgdDag8qbiQZ0NAcY+2wIQ/R6G0da0vA0G48m
 /FAfgWSI4uG4/NkrBQXgEyV62ALcxC3SXVOLxXCpXr2Rgd1QLrUgrmfiaSHTFA6csSHZ+ZaXW
 liOf1DUHxsYqEuP6ZFwOnZdCYZxpzhKE5xsOjosjPy7rFqTQhaf/C366hyH/thQK9pOfdMln4
 xNaQiJUI6TmJBKi9+YZnZhXfnQa/zh+4OtRt5udM3dXEOkTWR9gj5fQztgvFBpKu7CoYZmNin
 tkZgxCGUoZ9d76Ibc4marsGbRkHwgug6Pg4IBAHdyGuLniwU9ecK96cNYAcdjkrLzZc0LQ+Gm
 zXVoetDL7vkZ2kr8/T4TP/a9PDqQztW58DotCgyLvR4d9xQjjnxaPWmGimjX4Zwre5zryq1qC
 Kpvxi8mof2K+zLhBMVMhGXk+E2/XHlfiWcz3ODkp4+tSiOIHqFnQA2PXW0Vqgrtq9eWczJcZi
 bKs+dOdq/Nr9/L7+oPpNdDJBGoXzBWjLt3Dhz6hUTP3ZGIvo2T4qQxcHyuoF5LUHxMXINtqqR
 uuJOMmC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 3 May 2018, Eric Sunshine wrote:

> On Thu, May 3, 2018 at 11:31 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This is a heavily butchered version of the README written by Thomas
> > Rast and Thomas Gummerer, lifted from https://github.com/trast/tbdiff.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/Documentation/git-branch-diff.txt b/Documentation/git-branch-diff.txt
> > @@ -0,0 +1,239 @@
> > +Algorithm
> > +---------
> > +
> > +The general idea is this: we generate a cost matrix between the commits
> > +in both commit ranges, then solve the least-cost assignment.
> > +
> > +To avoid false positives (e.g. when a patch has been removed, and an
> > +unrelated patch has been added between two iterations of the same patch
> > +series), the cost matrix is extended to allow for that, by adding
> > +fixed-cost entries for wholesale deletes/adds.
> > +
> > +Example: let commits `1--2` be the first iteration of a patch series and
> 
> s/let/Let/

Okay. I am always a little bit fuzzy on the question whether to continue
lower-case or upper-case after a colon or semicolon.

Ciao,
Dscho
