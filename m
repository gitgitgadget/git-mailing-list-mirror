Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6BB01F404
	for <e@80x24.org>; Fri, 10 Aug 2018 20:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHJW4P (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:56:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:33269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeHJW4P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:56:15 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LufbI-1fwmbM2jHU-00zmKP; Fri, 10
 Aug 2018 22:24:44 +0200
Date:   Fri, 10 Aug 2018 22:24:46 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 18/21] completion: support `git range-diff`
In-Reply-To: <CAPig+cQ6H1ys6MrZ3qV_93WCQxz0mxnQJMm23XRTrDh1WHHnGg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808102223580.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <9b3632324f93afdab7273df7a7dc119e14a261a1.1532210683.git.gitgitgadget@gmail.com> <CAPig+cQ6H1ys6MrZ3qV_93WCQxz0mxnQJMm23XRTrDh1WHHnGg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j+NYREvsCiBCDRiZdKy42i8zjXfy8OLPzucqlHWv0m1gokda136
 pIeOAAyyToiPbF9ecEfIuhpoblvCUD+thVYWVKr2FUhZQaD4RRk3XMdTis+OlyAZBAxCL7a
 JFNrStBOmHHM/+iegwDhpmcxiu+mDBrWvehHdUQhTkaGohH1RdEPy5NoZ4cEX56FL+jz7WU
 wTtnwfTfNsfazw9bflzvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xzkZ0NeW8bk=:KsScV4HHCPO9C1NRP78MdW
 DR0coYy2iGB1Ks/UZxin023j/8u4CF4ooqjcwZe8nAJM40jsOkIeU5v19lj9aWRaCR4Cjj3YZ
 3wklUP3J9sSfrG65Kn3hx+V6SdcUIDFolQPxRYmjuxM+u0Rmg3C2KF+s5cLA5p/nfKnsMOCRV
 i+onT4/FMt7veMh68v/K/ngs6XLopSumT6QXcGGkfuaJt/Zq9T/OHRDZbHzrSdvE54LQ3RBak
 LV3VtEwpM7WmcnvG6QHYyFYgi4ltaI/JT06nkKZSW/LVYGZbJhZEg2Hg98XpB9hCu9ckOgmuB
 QnnM1xmniqnfD/sw0Q/qgheJJqboViBFOFDLU7lVNbsQZY7DbYr0pWf6/I/AL7Npe1zf9yhyl
 g616EBa5dbmUNV8kgcFoBgBhrwSOuKttRYIDgSdUUb8lQ6otxj5PdZAnfmepsuOmfTpL6IEpE
 4oa3oT62wlzaLctFJIOVJ/bjq8lL0fgryWwWtJJV2Er+bhPihBzmR7GHGpK8Aw8CJXLsgsTiu
 jPD+IorXQTw0nqV5vQ2MoJ913cspjjjWix7KOHikp5TCoCbcURGnOZXoCz97HlXNa0daZvtBY
 JZneoIjY0C9Gm2X+hyH2DqcA2e7tj8cbx4aRWqVjH55GjKyBQ6/bVDWj5BbtVFn6z1Q2/iFX5
 kAbWbbUzLJXLGUHVPDPv9cWdOEmBt/y8dJB19RSxPRniWuuhY+zFKBkmhG6TLgimcpBmgISSL
 96nc9OrePBt4egJV83b9YbEK836Hvfxgiv350uqCpuuNgEUIAvaJiy79cE0KaACkSZXOUzBKX
 vPGFKWO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,


On Sun, 22 Jul 2018, Eric Sunshine wrote:

> On Sat, Jul 21, 2018 at 6:05 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Tab completion of `git range-diff` is very convenient, especially
> > given that the revision arguments to specify the commit ranges to
> > compare are typically more complex than, say, what is normally passed
> > to `git log`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > @@ -1976,6 +1976,20 @@ _git_push ()
> > +_git_range_diff ()
> > +{
> > +  case "$cur" in
> > +  --*)
> > +          __gitcomp "
> > +               --creation-factor= --dual-color
> > +                  $__git_diff_common_options
> > +                  "
> 
> This is indented with a mix of spaces and tabs.
> 
>     Applying: completion: support `git range-diff`
>     .git/rebase-apply/patch:18: space before tab in indent.
>                 --creation-factor= --dual-color
>     warning: 1 line adds whitespace errors.
>     Applying: range-diff: make --dual-color the default mode
>     .git/rebase-apply/patch:105: space before tab in indent.
>                 --creation-factor= --no-dual-color
>     warning: 1 line adds whitespace errors.
> 
> Other parts of this script seem to use tabs for indentation.

Thanks.

I guess that this is due to my playing with VS Code and failing to adjust
indentation rules of anything but C code...

Will be fixed in v5.

Ciao,
Dscho
