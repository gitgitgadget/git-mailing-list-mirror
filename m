Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06981F404
	for <e@80x24.org>; Mon, 27 Aug 2018 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeH1CXb (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 22:23:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:59239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeH1CXb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 22:23:31 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkfdE-1fKFrb0cnE-00aYMp; Tue, 28
 Aug 2018 00:34:43 +0200
Date:   Tue, 28 Aug 2018 00:34:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Akinori MUSHA <knu@idaemons.org>
Subject: Re: [PATCH v2 0/4] fix "rebase -i --root" corrupting root commit
In-Reply-To: <CAPig+cT0ATgRMY-mhttViaburFW37G352BX=mj-Cnr2_wZruaQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808280033130.73@tvgsbejvaqbjf.bet>
References: <20180731073331.40007-1-sunshine@sunshineco.com> <CAE1pOi3oeBEyD8skwfLAd7JviGYOUZaZwj3u9pznM4eLAR7fDQ@mail.gmail.com> <CAPig+cRe1R1YWpLaXVtTmwhaJiz2dONU83qtn_+XhaRevjn2fQ@mail.gmail.com> <CAE1pOi3+FW8itk4AHhG+r02TGyGTeoZpq7S6HKXkQtOVqigWGQ@mail.gmail.com>
 <CAPig+cT0ATgRMY-mhttViaburFW37G352BX=mj-Cnr2_wZruaQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dC+zq3UmoZxBnw7RDQG+Ha6W+dUOEOEh1QT7MDoOoRutAsC67SI
 pZanFMF8RFYzxRHNATvTeVIHcfwkCyatoOJFEowdC+BsdGRqiu6GzdM4G5eF2kwVyBFflSP
 pn3GKaij39SeKs7rQXKvUSRiv7wxaBrFfuIwGcg1qCSOELO7qXCR8T0J0LIlmTW7Xp6NFnx
 wqx5fDBm7pjlW8Mvdn92A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ziUEprsiIZo=:1U7rK28WaGNxrxa74fPSTM
 khIhOUBxmlZd7i61PDPM1UiQqEjQBYgCbjTVfDZLLy/tV20YAU+05n5F+lB8ZDXabmIuon4Oj
 1oKWKubiwjkNAM+wR3VuMRDToKsf5Q1Pdzwxg8ciXztXwsbXnXWIbdAzin3FWpAUcsURWjma/
 LEQYsR84vYREYyHmSspR8VboHD+WLoT66UIaEbUXBjGS/YyMIi0bNKxdbR9uLhx0b2mGZphNU
 Xgvw5lMPHh7NKMOg2y13v/HOSMkFHUsQkohJnm/PBPUGI9nsCqwOUJrclSpRQMYblMW6SBQWg
 iKqA1cJEVYU7JqxLuGHTcFCX60LN1CCrDtpqWYPH7+RUJKXX9MWxrrZ9CzGlXCMR+/EvMMavu
 NtOlLPqJLggSkpnx+qSucpdcyITLPkiKMcuGltsbkk0XbgmzxSD4Nnb06oYohYJ+yb907Djvg
 aCm+IaCHDdEA3V8Y3GSCTK1oj5PgdA2nKXfpIAOfHJuc8NONEnELE9ku6hnx43A+eoQo9aHYY
 1uU/zD+ZOWz0kTWqPU83SST6UXUUBCkTpz9b+49qKHZ1OAHc5citSpDl3ld8mR/aqOrxWJtc+
 3AVjEYmVkGlR3Pz2gf38cT0X8BuhY7s9Bh1ejxs6GVWIvU57+Z2kNCbzW8Xv3Sf/gmY8UKbqd
 +6D6GfbC9h3XSF3SOtynMG++5JhQ/NhEoDL4bty/bpZ1Pr1KTTV6d6d0QapGMyhVeJ4ardec2
 TJPOs6deBEyInrl+pwxpLrCiR0mIKYli1whzsi1Xnr83Jr+vbI9CbtVW3DO5N5BSf6Aelrk+b
 AAkKAGE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 6 Aug 2018, Eric Sunshine wrote:

> On Mon, Aug 6, 2018 at 9:20 PM Hilco Wijbenga <hilco.wijbenga@gmail.com> wrote:
> > But your suggestion did make me think about what behaviour I would
> > like to see, exactly. I like that Git removes commits that no longer
> > serve any purpose (because I've included their changes in earlier
> > commits). So I would not want to keep commits that become empty during
> > the rebase. What I would like to see is that commits that _start out_
> > as empty, are retained. Would such behaviour make sense? Or would that
> > be considered surprising behaviour?
> 
> I, personally, have no opinion since I don't use empty commits.
> Perhaps someone more experienced and more long-sighted will chime in.

I got aware about two weeks ago that my mail provider fails to deliver all
the mails that are addressed to me. Two days ago, I managed to get this
mail (and the thread) via public-inbox (thanks, Eric!!!). Hence my late
reply.

Hilco: if you provide a patch to extend the test suite to demonstrate the
breakage (via `test_expect_failure`), I promise to try my best to provide
a fix on top.

Ciao,
Johannes
