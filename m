Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A8C1F424
	for <e@80x24.org>; Fri, 30 Mar 2018 08:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750988AbeC3I7d (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 04:59:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:49301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeC3I73 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 04:59:29 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh5h7-1fEfu72nRJ-00MLKB; Fri, 30
 Mar 2018 10:59:22 +0200
Date:   Fri, 30 Mar 2018 10:59:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Daniel Jacques <dnj@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Why don't we symlink libexec/git-core/* to bin/git?
In-Reply-To: <CACsJy8AwyJPJv4mdbZgGo4tobncKPR=sKmv93oon0CD6hwNCxw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803301057150.5026@qfpub.tvgsbejvaqbjf.bet>
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sguorb5.fsf@evledraar.gmail.com> <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
 <87y3iwp2z0.fsf@evledraar.gmail.com> <87woyfdkoi.fsf@evledraar.gmail.com> <xmqq37121vz5.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803151807060.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CACsJy8AwyJPJv4mdbZgGo4tobncKPR=sKmv93oon0CD6hwNCxw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sMzRVMEW58txTXYzQaagJ2jxwuJ2aKPmI1hSTtSvZuHnkEPr9G6
 2uq65pxTMhlEDEsx/r40kCk9AMr2f5Fu7TY7dmmHxt0KJpqiLVKzgWprvOv717wDkpdYSbN
 IWgIz8+XKVeYPwEfGoo+KpPjMkf2TgRY4gRATXMExdyvyj1OBKfjxqZPiDVn+CKUTI5noT6
 Mh8dCQb86ph122IqCzD2g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZFLtU9TjPBw=:0+Qo3ph6hpX1VCO0ryBOpc
 XM5OeJwCklD3XWLa+gLKxnrcM4c+e7MHeYjsYcbcJ2qGBL8U2l9dN2qA7I/KQvle/La5eC2yw
 761yGQNzo9xsmdje/Z+ylqrhrwZYP0JqtMWocBGonSlI+FFnPZIjivQmqevdm/jrlztGZXLyg
 y4rMOcB0+JEFf2HTpuBt6gUzzja06zZubMHClc4d0qkGgk3fR2EjTHWJTXLJjMxYnSBFTDttk
 dEc7l2ZOhTu6AZiRSLBDDhfM+gyiR558HD8yjFybY4PmpeBybX5L2Mqh+DCCGam1p+NMASHYV
 whvIRZfrnBOehXVjWZf8ivKRkDc2HbMSHXiPOxUg6yr8xQa5Okh8JPEI6Z3MDotchXc9EZ1xI
 2spmZo6B8Ns5FtuAFekbjn3ZDi+oE+jQCeXgHOJWjuloYQZh0a9bznsGsj8ybojrRpI7tN9hf
 bw2hOCfJ0BP9Y6NOAz1hz26E+pyUSR2iss0o770nZL1K48crreSNtl37QFH/xaSkMlJhocMMJ
 PbSeIlQfHrBM1tJQkMxjufMvoM2NrHgeV4Pz0wrd7E5HZRD/YV06TdGgnjfWaY3P86eoB6lEj
 ENlXRArBLOYaXzFJy2W6bAT0eAmAwDSRWKpSFC18eXUqbY22F+RWyBRcExvs/Fmmy0RHc4Zbp
 3LMQmZ4iYvEiNWLMfbvwbwgo8oielfwaIzIVbmxG3uf4RwohjOyxD84+gg0eXA/gqiT0P7LB1
 cizwKVtLI2Us8STr9kLTrOUqW098Krv+GC5Xh2FWCNzclTFxjbvaLGvPZRDia5XLEJsft3wUI
 unxydPAHYlHmXPV2XoS4m5KRYtfBLoEumXTmHr596Ssh5Q0gx6tk1XPpcBbgW5/9HyBayO6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Fri, 16 Mar 2018, Duy Nguyen wrote:

> On Thu, Mar 15, 2018 at 6:16 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > To add some interesting information to this: in MinGit (the
> > light-weight "Git for applications" we bundle to avoid adding a hefty
> > 230MB to any application that wants to bundle Git for Windows), we
> > simply ignored that old promise. We do support hooks written as Unix
> > shell scripts in MinGit, and we have not had a single report since
> > offering MinGit with v2.9.2 on July 16th, 2016, that it broke
> > anybody's scripts, so it seems that users are more sensible than our
> > promises ;-)
> 
> That's very good to hear. Perhaps we could slowly move away from
> symlinking (or even hard linking) these builtin commands (with a
> couple exception like receive-pack and stuff) ?

I would hope so. As I said before: the fact that Git started out with
everything as dashed subcommands is an implementation detail that
unfortunately leaked into many parts of Git's UI. We can fix this.

> We don't have to do it right now but we can start announcing that we
> will drop it in maybe 2 or 3 releases. We do provide a new make target
> to recreate these links so that packagers can make a "compat" package
> that contains just these links if they want to. But by default a git
> package will have no links.

I think that makes a *ton* of sense. Let's get to work after v2.17.0?
(Same for your excellent work on t/helper/test-tool)

Ciao,
Dscho
