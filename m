Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEDE11F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbeA2V3W (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:29:22 -0500
Received: from mout.gmx.net ([212.227.17.21]:51239 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbeA2V3V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:29:21 -0500
Received: from MININT-KR8J64V.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MEccf-1eZQQK2Z33-00Fnl8; Mon, 29 Jan 2018 22:29:13 +0100
Date:   Mon, 29 Jan 2018 22:29:11 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to
 resettherevision
In-Reply-To: <nycvar.QRO.7.76.6.1801292224180.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Message-ID: <nycvar.QRO.7.76.6.1801292227200.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de> <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org> <229b332d-56b8-0183-f57b-b0db0c62f781@talktalk.net>
 <CA+P7+xpj503VKEf4jzYdbk33aAvaMQ8+T1bQ3EB0T+AWEU3pKA@mail.gmail.com> <nycvar.QRO.7.76.6.1801292224180.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JpY7NiaBNgD+n/qAQVpPFwsOBfXFAjeV78xn6AN/eYDUgGGBBS3
 VndnGIFLTzutf2C2Yi1wk4g1ppaRyVEnDEbOgEn2I+bl6FpnGTuw7BjCf3CgbEdo/YflUIG
 N1bktqNez2oTluGMLuuVWQ1co7z2jSF8PeLjBNvpGFuYsSofHEQ4gNV8i0DWGy/C+4v8res
 2w/499lFGXi44RTQJvTig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jVHzXbkdteU=:5dD9xd21s/yjMpSK5Iq3UE
 p5wfd+ycN8iF0zQUnFDg1TbM6Sj+PutL7DaKDo7AL9FmsxkziWMwj1wI/WX5kYkNrxs0G747j
 zZvfnlnHlpUzWI9GJi0yfu4FmNvlY6AyPJ+hjQLOQ04fOWvT/9evbfPZipMwThxaHOA0EIM0y
 MPg2Ek8QqYlinfzXr/NG3cGoaF7FgtgGAeGy0vPFXrKlKS8TQW2G8xW0b0D9adqahGC03KqjR
 fm6ROqWHGYadbePsbhJEA3FmZ/tmvUP3IV7aFncjWS6JyLOTjGNrvIITa4YyxT2IG6iU/CLDs
 oQbA7+iMzNsALVCT6J3g8dt5kaFegD60hIXXijWjbvq2NKYfEvf6K7HifltQm3eDyKHK0jIdZ
 TfiwKwoTOg8UT5KylBppvFflpa1o0FUcfgHK0sDi0cKLiMapj/Jcr7DiRVJBMHSwg3w2jI4US
 BfExjr1PkTnZ36Gx9a7lm/2ebWLEZ0QQHSWjZHb5dVIFKsKPz2d021hGVQT/po7joK0klKEWK
 aJX/+VJSqXETH5ta19JEgwXf6iJOQ0rAlhb1E0JpPT0t9vcamVGFKhNbLZiKM+ZKTmVMyCwb8
 Y43z7GGaGWH/+YJv+jS9nvITRJgmdoGIQBAbgdcgZTeDeenWe3akdBcaDrWGFSerF2Tyizt9L
 gk+MvIalDX78VktCjznhHWtzwWEvZRYa7muOpiJ/H+czDzvnC/Ruy3CiFwBZyHE5EHqR0+aWI
 N1tUnmLYrF7Gltyr5LcOpaKaG7sBlXJo/M2WzspK9QdvqB1xXQ3xhwN3LFjQQn1Bs1nyPph11
 8cSnRq+D7TRZe5ucinVadoBNRh+K3imBpxgQhaeqpDf9b2xMQcK0WtUEcHkeaka46Vtsr3M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 29 Jan 2018, Johannes Schindelin wrote:

> On Fri, 19 Jan 2018, Jacob Keller wrote:
> 
> > On Fri, Jan 19, 2018 at 10:55 AM, Phillip Wood
> > <phillip.wood@talktalk.net> wrote:
> > > On 19/01/18 12:24, Phillip Wood wrote:
> > >>
> > >> On 18/01/18 15:35, Johannes Schindelin wrote:
> > >>>
> > >>> Internally, the `label <name>` command creates the ref
> > >>> `refs/rewritten/<name>`. This makes it possible to work with the labeled
> > >>> revisions interactively, or in a scripted fashion (e.g. via the todo
> > >>> list command `exec`).
> > >>
> > >> If a user has two work trees and runs a rebase in each with the same
> > >> label name, they'll clobber each other. I'd suggest storing them under
> > >> refs/rewritten/<branch-name or detached HEAD SHA> instead. If the user
> > >> tries to rebase a second worktree with the same detached HEAD as an
> > >> existing rebase then refuse to start.
> > >>
> > >
> > > Ah this isn't a concern after all as patch 5 makes refs/rewritten local
> > > to the worktree. Perhaps you could move that part of patch 5 here or add
> > > a note to the commit message that it will become worktree local later in
> > > the series
> > >
> > > Best Wishes
> > >
> > > Phillip
> > 
> > I'd rather it be included here as well.
> 
> But it would have been really easy to overlook in here. I really want this
> to be a separate commit, also to have a chance to get this done
> *differently* if somebody comes up with a splendid idea how to do that
> (because hard-coding feels quite dirty).

BTW there is an additional good reason why the patch to make
refs/rewritten/* worktree-local is so far away: that is the first time in
the patch series when we can test this really effectively; at that stage
we can easily just add to t3430 because all the building blocks for
`rebase -i --recreate-merges` are in place.

Ciao,
Dscho
