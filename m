Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2152018E
	for <e@80x24.org>; Thu, 25 Aug 2016 13:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934086AbcHYNB1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 09:01:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:55808 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbcHYNBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 09:01:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LcEPJ-1atuUh1GMP-00jZg0; Thu, 25 Aug 2016 15:01:06
 +0200
Date:   Thu, 25 Aug 2016 15:01:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Arif Khokar <arif_khokar@hotmail.com>
cc:     Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <DM5PR17MB1353DB7619E47FCD0011DA82D3ED0@DM5PR17MB1353.namprd17.prod.outlook.com>
Message-ID: <alpine.DEB.2.20.1608251500210.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com> <B21604E7033C458EAC5EA0651CFEA8E9@PhilipOakley> <alpine.DEB.2.20.1608241459360.4924@virtualbox> <DM5PR17MB1353DB7619E47FCD0011DA82D3ED0@DM5PR17MB1353.namprd17.prod.outlook.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bqIoyBHd0FrNP8TF1Otxb6mhUXoh5KewvuAXH6C868Bhoe5b+hu
 +d1Vh960Dyzo3UgL9wMxRz1rwhcDjhhd9cMGblrZIvQG1MsclkHNw+npYNQo5wnQ52MQCub
 8zBQxkx7acldms4sQ+EgmKtnWXxYD+7H+OlRAbgMmW7IR9fFF5LfwZteVOzIu8v+sIvtwET
 o4e/QOpX8PiMbJzHYtlCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nphdW1z1Uv0=:DBTNLgEHotjZvG361gJC8L
 s2eoTiI8ztYAYkZZ78iT1w58726a4rCOxyCHugb6dgUyhrIBvBrhDc3p1xy7mf/oSyQsyQuJ9
 /Uk8HM9bkUfRMpgx5/naXj7lJTRFeooXV91D6ZC+7pjTzhNb14xT/VwBVRzThPDp2bIrBOR8N
 B2HKQ8I1erBwAxJVtaT/yOqvj+agZx6C9s770JAvDsORvM0m5yYinmVzsrZKW8oZSh1m2RCV8
 gD3bcrOKzjgC/2L7oQch+d90Xy7LuQNsOtAUqDibREyGJ/66IrfLvF4R6lZziVprj5stdAchy
 9njVPf3DQCZRNgcTW9cRYZ3j61WgdLegloNUEzTqAtjWdtxz5Z3IJO3rSvUqNF838Gx0MoSKW
 8LixGP/1cAXmPRm4R9h1Dt/aXQlO+CuKe1FA7Y9G5HdKQ815xYAJue3iQ0IJf97+FL0xlWypI
 +7iKEXcDuBhdPZcfRHeIN+UT4EWvKMrRJNb5TlQJKChTeVAQSbsifZGrBBpuYrZiADB5dbRd7
 pj6YA9RRI9EuJOWLrfLvo6WFaF/hNNYhNhk2OlOS/wWBSvca3F0SH26U6KEXcBfiVUjdVkOSw
 l7BRVHV0HXX1l99ctbxt2vCmF9NtrNCp8NmTj0NkiBaRkqcJo6GtzYwKQqMkjaKa8YJz1gPCq
 yqH7AXqps2I0J+tGsvgLJ7kqX8V/qWvt5ofqd8BtJ+SGeUIvQtDHA8lKamydYNtT0olMKMwwg
 KfTEY/AEBKyB7LBCT+ncMXYxOSx+UQMZhms2BYwlHA//2YA2wPFbb1UsmiQOWaOQo7GIjWL63
 wCzVYyG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Arif,

On Thu, 25 Aug 2016, Arif Khokar wrote:

> On 08/24/2016 09:04 AM, Johannes Schindelin wrote:
> >
> > On Mon, 22 Aug 2016, Philip Oakley wrote:
> 
> >> I do note that dscho's patches now have the extra footer (below the
> >> three dashes) e.g.
> >>
> >> Published-As: https://github.com/dscho/git/releases/tag/cat-file-filters-v1
> >> Fetch-It-Via: git fetch https://github.com/dscho/git cat-file-filters-v1
> 
> <snip>
> 
> > I considered recommending this as some way to improve the review process.
> > The problem, of course, is that it is very easy to craft an email with an
> > innocuous patch and then push some malicious patch to the linked
> > repository.
> 
> It should be possible to verify the SHA1 of the blob before and after 
> the patch is applied given the values listed near the beginning of the 
> git diff output.

There is no guarantee that the SHA-1 has not been tampered with.

Ciao,
Johannes
