Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1BF1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 16:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeGQRB6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 13:01:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:37639 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbeGQRB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 13:01:58 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNZVG-1fh5fO3v9W-007Efs; Tue, 17
 Jul 2018 18:28:25 +0200
Date:   Tue, 17 Jul 2018 18:28:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v3 11/20] range-diff: add tests
In-Reply-To: <CAPig+cQB8p1Eo0qyfD78cfSY6N=N9i-KBw5UO2OULXfA8+A=tQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807171827460.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <3d9e5b0ba383bab3a30b74a96a1d78557e168b7f.1530617166.git.gitgitgadget@gmail.com> <CAPig+cQB8p1Eo0qyfD78cfSY6N=N9i-KBw5UO2OULXfA8+A=tQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T/xmPQjvJBhQFJ0O6MorfMUZrjQu4iTq2GrWTTCDDnpVwlRpc2K
 Ibbjk7CCl/UEzvxjOPxOEH21Q4sr9d56T8Qm6uTAEbBs6L4HDo6/YDsXfeB5YJbZIfqIJuX
 smrDDUKDKRcn3wmemfLVzHLEOT+rn2zif0gIovPmFHAt6VrytxoWsjhKzbHA2sv0koduFVS
 /koUNREgQtURzNl+5sacw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:V8V2L2saFqY=:dxJzdYAHbY0CEUDBawQJMi
 Vr3qBouafQfXXaWk6qLEiUAQqNoDR+Up+hpr3Gf7OVA1YtXPW3axvJ8vPJYeSdVl3Va6tHXS7
 jita0rBks9hK/zy5l1bkPAyeafO1eXhO/pCr0ewKR3XSwjy3Or5RtSJjnsY6ygPGOK5QLsWsa
 4XXeICcUaeL6yKfJhdiJryhIA2Ze2SdSIu49yOi6ipljyKQR/QLKrgh3NLH8n7kQZYxB3ku+f
 E+WgzjGhwCikdXMTVg7n6unCcpSP+NzU9dG8JsN5msTvfHxgtba/llr9Xu4rGf/E0Ny2BHOwF
 ++7p7GFDkw1aaqMQm4wI5jALRGsdMNq1+ZdQfjwqwiXLg+wRpi0caGa35Sy6R/LKR/SvTCn1M
 6TQT81ES4nXoRG+6S2PJTf4tR92BZPLWqmIcZoA2WV1hKRnE2y8cECzEt8um31o4ixC4CYN4R
 aMRHkN+y/2tPhqGGfO1eL/EhDTvPM8WOeoeBLXqi+VUVMVrTBECDCY2fXeiL1xEo9kHdbUghY
 Gm5O4FuW1452XqD+JFKEdFcMV1BIzxoKqaTY8fOZxnQJc3NH1arg+il7RaDPAeUWPeU/kHIf5
 IA3DLaF7sbt6S0xnVJfchv0qcrOjgb4YvAVOYAQml2D6gVbR9tuB1f9Put4aPEZ/WQ4J2lPQe
 kbvUqR0pglgmy499+r4wP5eujppcXkm6wOOBLU5F8tPc9VkClf13Oi9B13mytrtzsuuG/FZwQ
 aotliiCG77JQTVWHua4RSAQo277HBy1tMgSqb4UViTJ//bnC7sc353hYuK1f4FdBzzvy9J7Mx
 zpGw+w6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 16 Jul 2018, Eric Sunshine wrote:

> On Tue, Jul 3, 2018 at 7:26 AM Thomas Rast via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > These are essentially lifted from https://github.com/trast/tbdiff, with
> > light touch-ups to account for the command now being an option of `git
> > branch`.
> 
> The "option of `git branch`" mention is outdated. Perhaps just drop
> everything after "...touch-ups" (or mention "range-diff" instead).

Ah, the line break made my `grep` fail :-(

> > Apart from renaming `tbdiff` to `range-diff`, only one test case needed
> > to be adjusted: 11 - 'changed message'.
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/.gitattributes b/t/.gitattributes
> > @@ -18,5 +18,6 @@ t[0-9][0-9][0-9][0-9]/* -whitespace
> >  /t7500/* eol=lf
> > +/t7910/* eol=lf
> 
> Does this need to be changed to t3206?

Absolutely.

> 
> >  /t8005/*.txt eol=lf
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > new file mode 100755
> > index 000000000..2237c7f4a
> > --- /dev/null
> > +++ b/t/t3206-range-diff.sh

Thanks for your thorough review,
Dscho
