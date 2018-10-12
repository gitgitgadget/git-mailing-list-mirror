Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FC51F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 09:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJLQ43 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 12:56:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:56443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeJLQ42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 12:56:28 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYg42-1g6xnF402M-00VQQL; Fri, 12
 Oct 2018 11:24:44 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYg42-1g6xnF402M-00VQQL; Fri, 12
 Oct 2018 11:24:44 +0200
Date:   Fri, 12 Oct 2018 11:24:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Lucas De Marchi <lucas.de.marchi@gmail.com>
cc:     sandals@crustytoothpaste.net,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        git@vger.kernel.org, t.gummerer@gmail.com, sunshine@sunshineco.com,
        gitster@pobox.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
In-Reply-To: <CAKi4VALL5nnLfo4ZxtifKE1JmcmUQ6F-9GSAQEMxXLjKsCtSmg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810121122260.45@tvgsbejvaqbjf.bet>
References: <20181010150916.4295-1-lucas.demarchi@intel.com> <20181011000233.GX432229@genre.crustytoothpaste.net> <CAKi4VALL5nnLfo4ZxtifKE1JmcmUQ6F-9GSAQEMxXLjKsCtSmg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BRPShd++ucJjFTpZpAm1IZNT2bBcMDlTjRFJOhlQgEQ9j6Peve2
 XbWoJFOm06f5um/UDwVQ67JHlwk3QPg1LiSLgNSLhaJhg63yS9raVvIlLUCWtI9I6kUiyKg
 dzUEq2/zf7F35sUR74c4kaue0g/nbNHii5UYCBEiAZAxx5Yq8hZe71Q1wNJ5opd76Nbsdn/
 cS9QLm0GnYbm/jAPL25yw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3bejhCWdBps=:rU3CVVJrLv+F4QlZf+q3xV
 Tr1ZmWoLL0FtltWm5SLlCSQw1mdex3AQvtPd9/XxSfd4v3hyVYG4a35PJtdsFTEOM/JZozzNf
 GOaOKU0BjO83XcfJ+aKJgjGayj6B6RLoN9kTu6PY2+8xaXmFNE2tE+VT7kV658munH3WX5po3
 ngnAP+DFYffPBqvgpOxZDK7Shsp8coKe/HMOuSHlLeitbKo/vTq+NYTzxQDRxFzg8jNlieCfY
 De1t15LUCagK5vIGhJmlDnj/ieTe1dpZp+UPmcVbyvciawDxEnYP7WKt+0PSwObK1UvOZajG+
 gerI8muK2b+POs8sAuL0hYEK+irzbvv0iNXYAIEzmLzeYcvyEAyMHOJtaw3gUX7B4/UAhtzKA
 lCwTWllzUHKg+tbPf6Wa7+qra8VFlyi9jUxaTRoR6rZO3CDH8schhiRQ9BVTqB2+BwFXeQh2u
 11XQ6PvCs0j9VzImJJMpIxLLuRZZF9NAWmsQ6pgbyDanots1jYwhJg6da26xVumSkGpz4XbDz
 cBJlQnJbGSfzpdb0aOi/2wCmY55PTlCovQqHwNQtdJJn/VeBHGyPKREhVnvPnlDlLhz8GsFYb
 Icxk7dz15ctEKOiZYFZjRHWwdy2VH+wgowUNrecxdJqhGOYTmdITlZkMc5yUz0stGq+HEmeDE
 yXGhSWDrK8m1Waa9l4k0/x9bP1s7Xuw9PBY+nAtBzZeSB2aSPiBlZFAqyMC6ridR/DJjuvLqA
 2dwgkwjBjf1xGpXu9ttNN60cDKL5cSIjkee1FwdwLYU4wDMOuEKI1u1Kx3FfSk0Q5Tb5RO72v
 fgdEQb2E8VlAwpo94qmQwUGlhBbXhtFMg4DBr889UQe1U0IRiI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Thu, 11 Oct 2018, Lucas De Marchi wrote:

> On Wed, Oct 10, 2018 at 5:02 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On Wed, Oct 10, 2018 at 08:09:16AM -0700, Lucas De Marchi wrote:
> > > Do like it's done in grep so mode doesn't end up as
> > > 0160000, which means range-diff doesn't work if one has
> > > "submodule.diff = log" in the configuration. Without this
> > > while using range-diff I only get a
> > >
> > >     Submodule a 0000000...0000000 (new submodule)
> > >
> > > instead of the diff between the revisions.
> > >
> > > Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> > > ---
> > >  range-diff.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/range-diff.c b/range-diff.c
> > > index 60edb2f518..bd8083f2d1 100644
> > > --- a/range-diff.c
> > > +++ b/range-diff.c
> > > @@ -354,7 +354,7 @@ static struct diff_filespec *get_filespec(const char *name, const char *p)
> > >  {
> > >       struct diff_filespec *spec = alloc_filespec(name);
> > >
> > > -     fill_filespec(spec, &null_oid, 0, 0644);
> > > +     fill_filespec(spec, &null_oid, 0, 0100644);
> >
> > If we have a system that has different mode values from the common Unix
> > ones, is this still correct or does it need to change?
> 
> From what I can see this would still be correct, or at least git-grep
> implementation would be broken.

As you can see from the Windows port: we are stuck with the simplistic
POSIX permissions in Git, and platforms that have a different permission
system have to emulate it.

We only use preciously few bit masks, anyway. For example, we do not
really use the lower 12 bits for anything but "executable or not?"

So Lucas' patch is correct, AFAICT.

Ciao,
Dscho

> 
> Lucas De Marchi
> > --
> > brian m. carlson: Houston, Texas, US
> > OpenPGP: https://keybase.io/bk2204
> 
> 
> 
> -- 
> Lucas De Marchi
> 
