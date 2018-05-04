Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38CEE200B9
	for <e@80x24.org>; Fri,  4 May 2018 15:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeEDPX5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 11:23:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:38381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbeEDPXz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 11:23:55 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0McEDD-1ewgCX1p6F-00JdHj; Fri, 04
 May 2018 17:23:50 +0200
Date:   Fri, 4 May 2018 17:23:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <CACsJy8AnWC8bLfhj25quzHokber-wrWdSsJiCDra=Ymr++0-nQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805041723050.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com> <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet> <CACsJy8CRCb2go5qUBOdiSNvvAShotD=e4Cm3Jo1OxNk212YtCA@mail.gmail.com> <nycvar.QRO.7.76.6.1805040919400.77@tvgsbejvaqbjf.bet> <CACsJy8AnWC8bLfhj25quzHokber-wrWdSsJiCDra=Ymr++0-nQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pKB3WQKdw98MZFkg0zBNiMsrSfVK/NBsT430+RVX3yXhjJRTD1U
 a+wiuoPZUqWPBJFG9TKY6l5CLmsxFGTidCVTQs/89UMQevycYibvPOvL5s3W+Kr8pu1hyCa
 oqUfbZqXIZbpRzk2vLSXjc0o0sLIEeZ2vJjwu7JESQnWdI6yhENwaXuo3///iCH4tVdUNdQ
 moA6nDzQnkuRCxlB+n+zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ojWP0jKEds=:Umrfjp2quSUIGERTOdFtaN
 /1A89vT3ny4pFsA9Po8YbAHGf8x925xmFGHPTCoJvqSujKNTfxLrzUqMmJ316iY28O3Xx/XjX
 lJMkm+MEM0fjpxZwJ21fgAVXT/5tZuHVf7Y8NLjdNFlLMc9xK4QaQAzRsSSyNLWvj1kzA7QIt
 o+My2bJawIGCjFj3X+GS1UGUBDJSipwMb92J7SW8670+rEVhXYE40Y8fFTomHy+eFO44DNgEL
 dLdUkDqzHxn3tSqAv5iLG7BT+Uk0WPjqZ94d3Nj04QhR8O5sFsYBMJv8lhVPTnolUBpptzmm6
 V1Fn749Uhl8jKTpiJL/HXPcTUvbNck+u3dDEDCT7ra4mKTF64tFane/CCiKhlUDwbnno7uqVK
 Ca9ntfIXoIuC5PmUXQuBJTpJW7IJeMwWh1j8MV28mAEz0BCNLQZkhc9j6JyC/jJnr72ZQ9hKS
 g8x0yObAX/BFRNDbfvP2RvXMJwj2OOyqa5zxMd5rIGF5Iw0SdYKhGHuj3wEzK/Ck/EWcB5JcI
 1J6Y3hr5zAmOqeVsoLXZ3O1vjSZA27vxDFMN9GpSw/ggWA7S12OS8hiTFiToi6NSFIOWt9uLx
 +wwDUgDQg7nShkS9OVFcZ/gXNy6nLKc/DOS6AtDhTJSrcWeIGFbkW8SmNFH6c15WVddxHBP+d
 gZQ8/CG523HTmBJwbwgNvvjNtUPcztnZyfbmyBeXKSJHpTQGFf+awF8PrJIU3xLhyudTjCAZU
 CxQZmqEKTkmaTTJ/tj84Xn9svGNCaj1XHm+luIhNGEjn6IHgWRsadvKgzt61hfyi3r7XwxGqM
 NFjCCAa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 4 May 2018, Duy Nguyen wrote:

> On Fri, May 4, 2018 at 9:23 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Oh, okay. It was not at all clear to me what the exact format and role of
> > these lines are...
> 
> Noted. I'm making more updates in this file in another topic and will
> add some explanation so the next guy will be less confused.

Thank you!

> > So that's what `info` does: it influences whether/where
> > the command is listed in `git help`'s output... Interesting. I thought the
> > lines here were trying to automate parts of the tab completion or
> > something.
> 
> Oh it does many things. The completion part is coming (so yeah you
> don't need to update git-completion.bash at all, as long as you have a
> line here and use parse_options() ;-), but I think it's mainly for
> "git help" and command listing in "git help git" (this command for
> example should show up under the "Main porcelain commands" in that man
> page when you put a line here)

I have a hard time believing that anything automated can infer from the
source code that branch-diff can accept the non-options in three different
formats, and what those formats look like...

Ciao,
Dscho
