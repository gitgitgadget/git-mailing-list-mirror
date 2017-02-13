Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B2D1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 14:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbdBMOhx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 09:37:53 -0500
Received: from mout.gmx.net ([212.227.15.18]:64017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752101AbdBMOhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 09:37:51 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKYsh-1ceevw3zsN-001zXW; Mon, 13
 Feb 2017 15:37:36 +0100
Date:   Mon, 13 Feb 2017 15:37:34 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Arif Khokar <arif.i.khokar@gmail.com>
cc:     Arif Khokar <arif_khokar@hotmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
Message-ID: <alpine.DEB.2.20.1702131533400.3496@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com> <alpine.DEB.2.20.1608241509200.4924@virtualbox> <alpine.DEB.2.20.1702101707060.3496@virtualbox> <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4t0Bgbp0WjHTRV7YYDIiB9nZ2g1sTjfThGjI6OXcIWrcXkskaci
 bBdg/s0HIl05wgEnW70R17l4dsrnMczGueH80bqAhg3AgIKoT36JuEsWPILduih1xOuxufe
 X9GBCNlQ/K07xADWvIyVxqf0SkDMYK4LvNwGuDk/Hmqp4OqNrHbsTndnsviYd+XoIXlexAr
 iYngoyy2EgMqN83+IZItg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2PQ80DyWkZI=:U29M94W5TpAxibmXiJycXB
 IML7ewFBKqrUymfG694ha7PhMyM3cHKmA9RnH4at+OOZNUDZSMqOcMo5uB23myyL5uVf5Iphe
 4ddR1rgz6sZMeT9cKEArxs1WsoTWcR8Ea9qg0k6bpjqekJ6Vq7TEPVBMDIx1wG94QlCafJwrV
 Pd/6qSNoVcglsLzJmT5wcyNCm6up5NtYioTUy39RRbn12Y7uldm/0dkQAbc36jzMQfLcDwmzm
 7EuX35cWlQUpb0TRbdP3oSEVl+PDgqP7NMvJBi3a70GdZPnB12MuWjuC3pagiIkYEsnhO86mb
 hwtFQ7A5bDNgCNaFtKtqBhpZYO5nhHoH7zRVYnVWMOHVlTWopDyDdwVplR7KW7pU0/XyzriYB
 4f3yt1eLyh5E/xP2roOJywWNxNHoUHbbhORN8KQSYGBsXEYOeQOqkfmXTQwkK8YwDPARpftLe
 D2oH6XDUsPyG7ljEq8LLkSc97Zbz4MDMOgcbEikruP2dG2ST4SYSMrP8jwvZDgybvkwmr9AP7
 OgOiKTK6u/iwXjEUygnS5lP8yDhGgL+ivmWvju2C1zng0qpTlJcl4yuSTNacPbQh9pwGfMblU
 t7p5hPyfNTIfAWciHJ2ZfRDPR3M7MVSjGlEXgFta9vcn7qQdECuhJQ0wrfPRIiTOoOy23QQ11
 /Z+dNATmaIf+Qe0CKPOZ49aDwgtOb72cJAMiTt1xOL/libug2HLL9m0an/E0vw4K6PYPVK7fk
 jKDiBRcHzmrFdONdu7Hxs6TEZUVyOLFNeqDE+OSRGcYgyDculKiqsBiZ8XD4+RKINMfyLML7r
 c/aP6hP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Arif,

On Mon, 13 Feb 2017, Arif Khokar wrote:

> On 02/10/2017 11:10 AM, Johannes Schindelin wrote:
> >
> > On Wed, 24 Aug 2016, Johannes Schindelin wrote:
> 
> > > I recently adapted an old script I had to apply an entire patch
> > > series given the GMane link to its cover letter:
> > >
> > > https://github.com/git-for-windows/build-extra/blob/master/apply-from-gmane.sh
> > >
> > > Maybe you find it in you to adapt that to work with
> > > public-inbox.org?
> >
> > Oh well. That would have been too easy a task, right?
> >
> > As it happens, I needed this functionality myself (when reworking my
> > git-path-in-subdir patch to include Mike Rappazzo's previous patch
> > series that tried to fix the same bug).
> >
> > I copy-edited the script to work with public-inbox.org, it accepts a
> > Message-ID or URL or GMane URL and will try to apply the patch (or
> > patch series) on top of the current revision:
> >
> > https://github.com/git-for-windows/build-extra/blob/2268850552c7/apply-from-public-inbox.sh
> 
> Thanks for the link.  One thing that comes to mind that is that it may
> be better to just download the patches and then manually apply them
> afterwords rather than doing it in the script itself.  Or at least add
> an option to the script to not automatically invoke git am.

I actually had expected *you* to put in a little bit of an effort, too. In
fact, I was very disappointed that you did not even look into porting that
script to use public-inbox instead of GMane.

> Getting back to the point I made when this thread was still active, I
> still think it would be better to be able to list the message-id values
> in the header or body of the cover letter message of a patch series
> (preferably the former) in order to facilitate downloading the patches
> via NNTP from gmane or public-inbox.org.  That would make it easier
> compared to the different, ad-hoc, methods that exist for each email
> client.

You can always do that yourself: you can modify your cover letter to
include that information.

Note that doing this automatically in format-patch may not be appropriate,
as 1) the Message-ID could be modified depending on the mail client used
to send the mails, and 2) it is not unheard of that a developer
finds a bug in the middle of sending a patch series, fixes that bug, and
regenerates the remainder of the patch series, completely rewriting those
Message-IDs.

> Alternatively, or perhaps in addition to the list of message-ids, a list
> of URLs to public-inbox.org or gmane messages could also be provided for
> those who prefer to download patches via HTTP.

At this point, I am a little disinterested in a discussion without code. I
brought some code to the table, after all.

Ciao,
Johannes
