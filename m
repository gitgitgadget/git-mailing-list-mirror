Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC3B1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbdBPRKO (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:10:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:61154 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbdBPRKN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:10:13 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnOve-1cB6610taA-00hcxZ; Thu, 16
 Feb 2017 18:10:03 +0100
Date:   Thu, 16 Feb 2017 18:10:02 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
In-Reply-To: <0275af7b-eb7a-1094-a891-674300175e56@kdbg.org>
Message-ID: <alpine.DEB.2.20.1702161753050.3496@virtualbox>
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de> <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1702141545380.3496@virtualbox> <ef8549ea-7222-fdd0-739d-855ad428e39c@kdbg.org>
 <alpine.DEB.2.20.1702151312330.3496@virtualbox> <0275af7b-eb7a-1094-a891-674300175e56@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:C8E++fVaWBtBd9UWXpgXsky+Z/gQ4qpzgNiymseKQmjdBD2lx8L
 E6wk0YbDh+KyGeTdVU+W/vjF0S3Bbh6zYxdS8LC/6a6QryebeNlUf7FlRQhTBRTo2sRSYnD
 fpWHPv0gKAxdkyd1vuP56+8zQcu+yFMA35EMbyHb43ullaLa+FyxUju9K+JzP6fyoYQUgBZ
 ZGaG/pRTJ3nH6xoP5cdng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UUzDdGu2bb8=:wy44C2WAs3wjoT9LUDzHgK
 AlAnhVJ8/2chCH/2XIAyPdFKC20CvBcoHwyI7ZopDVyCB/UciImE/L18Uy0krYnvNVkKe0WW3
 GUL/j6Lk4N98yAFd/2EhWcOaV9PC3kYwByDFJuOEanSYl1sCrMUrUKPNUegqhCClsxQTBwz6i
 5xTCMpVH6m8nJ9/z6lV0WWciklpl6TX9OyJmeFPOfAerPZa21odSWTw+93EH0/bXHmMvNhckh
 oMShlHvrYHOn0AwXyxh2qWjrF8Tf5SiLzwVRrhjqX/trccKdYGF4a41amSeky+QVSe5xaXfRm
 Nl1muzUeEEdDe974/Vx5X5H4+Sq6ebfdf8w7rK33F/7B+Oldieqsm48SLdrp0gRQFaIBfvGvX
 7wq/kq9woCmuP+2/qP0ZmmugpPTQaTsZwcRxI8SYW2SODISt3a6WB9bAtjrMyAB9vn9tu1Qef
 Ox35+qocQZ0qjvGgSw2zQDGo+eYbb0vuZuFwaDTwz3eomDQ5CaOLHh61uDkHSLDFNsGgi8ZDL
 1a/0fQtKlM4ikUFSGUgBYZTAnfU8/ypcJflal8LliNop3kO/kJGGCn1nmuSW51PyppW9UN4+Z
 lZsgClVMr5D/gQnaL2mCIdfBQyww1Ny24jVzGR3gou1WyRacLqDimivK1qwz1CDQAFiDFPrMZ
 /2LZSO91d3nvSp8RqMyDH9XiIU75Mrp2Myj5tKWCknlmyHtIHcdZI1a8CykJ2hAyQPQ34nIvm
 pizJq4RDQZKVOmE/KRMi7UxXzo8W8FEt3pkXOeep1gby5cvWqni51JZUhaoiUMDeaHvFgnHSX
 sA2MK5z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Wed, 15 Feb 2017, Johannes Sixt wrote:

> Am 15.02.2017 um 13:32 schrieb Johannes Schindelin:
> > On Tue, 14 Feb 2017, Johannes Sixt wrote:
> > > Am 14.02.2017 um 15:47 schrieb Johannes Schindelin:
> > > > On Mon, 13 Feb 2017, Junio C Hamano wrote:
> > > > > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> > > > > > What we forgot was to mark stderr as unbuffered again.
> > >
> > > I do not see how the earlier patch turned stderr from unbuffered to
> > > buffered, as it did not add or remove any setvbuf() call. Can you
> > > explain?
> >
> > [ motivation and history of js/mingw-isatty snipped ]
> >
> > So instead of "bending" the target HANDLE of the existing
> > stdout/stderr (which would *naturally* have kept the
> > buffered/unbuffered nature as-is), we now redirect with correct API
> > calls.
> 
> Your statement implies that at the time when winansi_init() begins,
> stdio is already initialized and the buffered/unbuffered state has been
> set for stderr.  I would think that this is true.
> 
> Then we swap out the file handle underlying stderr in swap_osfhnd()
> using dup2(). Why would that change the buffered state of stdio?

The file handle we swap in for stderr points to the pipe that a
freshly-started thread consumes for parsing the ANSI color sequences. This
handle is used both for stdout and stderr. The dup2() call then implicitly
reopens stderr, with the default buffering.

> > And the patch I provided at the bottom of this mail thread reinstates
> > the unbuffered nature of stderr now that it gets reopened.
> >
> > Hopefully that makes it clear why the setvbuf() call is required now,
> > but was previously unnecessary?
> 
> Unfortunately, no. I do not see how dup2() causes a change in stdio state. I
> must be missing something (and that may be a basic misunderstanding of how
> stdio is initialized).

It appears that dup2()ing fd 2 resets that stdio state.

Ciao,
Dscho
