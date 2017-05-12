Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159FC1FF34
	for <e@80x24.org>; Fri, 12 May 2017 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757761AbdELOUC (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 10:20:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:52699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757418AbdELOUC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 10:20:02 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Le69A-1dnnZg0ebc-00pu6b; Fri, 12
 May 2017 16:19:56 +0200
Date:   Fri, 12 May 2017 16:19:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/
 for good
In-Reply-To: <xmqqfuga5lp2.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705121617420.146734@virtualbox>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com> <xmqqfuga5lp2.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aSV8r5/CGC1CNuT32GPU3q7MJYvo2PMcrvxQzRPudJFV6Tgn/ys
 OfeijwRwEVFXafNK9fywGwOI94YEp6oQBg/mD4IK5faYyIL+o2L+/ZbHATHOm6H2mUPKo+E
 lav07faXbAaHztNavjLkvf7Vx0N5LaJUFAnqdVxdfXI9lZaMMWmqplumMjnD7HblSIhG122
 PBDy2lDtsjqSKXy0Qauow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OVwzfian2R8=:o+fjy8iitZB7obbOGGWkkS
 ZBT6O8VfrvqjkBdiNv/Qm6yxdo9OtviQOMeS3WKSTo+Q3pIwOYUSRqeYNNndC/zNNszCs8Q/R
 AqbrL0SdCJ38wvW2am4peBxPDX6ZXsTEL1eXhAycnkwuJ2pYazD4VKlpeJ0Zb8cVyLvIQCelS
 bepRNQdmrXEBzVW8Nz1LGoJYM6P7EwGQt+RLN5W52KNgu35XJUhrihipebt1nQ7F83Yx+XvDV
 gxgW+lpJHyK5mOb1vWfkBLF3VQ69WQ+Pr/Th90USdZB898FNsDCRQO/2L7ZOvRYO8BUbGwOI6
 6iVf8N30wcseNAIUtMNdgCmi5zYGF6Fhq54RLpgb29AhWAY8kgz316aISP0bse2lrH/AtF/0N
 JPZF0qqGRc8X/R9UwFpzNLCY84GZRkEKDhhoZGaeIl8lE1EQoIgUrongNWB4jm99mALy1FfVj
 Z0C8BhEigB3Fb0Nhde8G+HWoGQb+/Mka795t7s4BoriOMsj+7yg+pvhDjfXFThT0MIxcyt4Z/
 u1LEnM4m0eueF0jID6TYC/XyYx0Y7Scqt0njrx9GBJDvomkusjV6sOA1cSe0P9GwkTvLXtUVm
 +42ltPHAfZ55MqglLwUm2jFarmsFCgJAkYD4GdZJbD9hchu6OFoxPrmJotuKIy6CEo8SI/3L3
 +mrkIgTNUlGDnuyQLQw+Z+CnDYhVv2Qrbx9EO48m4mKtgTr19qAJ1KEOnEy6SzWz9i3Q98tIe
 gDwRYEkkYb1L1XAnQMqO2kXiCTlKwqeZenUdAxU+fQbTiV2tudakgxooLuW7l32o7ui72csmz
 yEcPLPn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 May 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> Git uses the config for remote/upstream information in favor of the
> >> previously-used .git/remotes/ and .git/branches/ for a decade now.
> >
> > The last time I thought about trying this several years ago, I found
> > that people who need to grab things from many places still do use
> > .git/branches/ and their use case is hard to migrate to .git/config,
> > primarily because the former is "one per file" and it is easy to
> > add/remove/tweak without affecting others.  Ask akpm@ if he still
> > prefers to use .git/branches/ for example.
> 
> FWIW, I do not think there is any reason for people to be using
> .git/remotes/, but for .git/branches/, I do not think I can offer a
> more efficient and easier to use alternative based on .git/config to
> do these things:
> 
>  $ grep <substring> .git/branches/* ;# what did I call that remote?
>  $ cat .git/branches/$name ;# where do I get that from?
>  $ echo "$URL#$branch" >.git/branches/$name ;# I just learned a new src
>  $ rm .git/branch/$name ;# I no longer need it
> 
> without having to learn things experienced CLI/UNIX person already
> knows.

I do not understand what you want to tell me with that example. It is
confusing me utterly.

> We simply cannot beat the above with anything like 
> 
>     $ git config remote.$name.fetch refs/heads/$branch
> 
> even though the config based remote definition may be infinitely
> more powerful.

Then maybe we need to teach, say, `git remote` to be that powerful?

> > Is it really hurting us having to support these old information
> > sources we treat as read-only?
> 
> And this one is also important.  I do not think we had to touch any
> code that handles .git/remotes/ or .git/branches when we extended
> the .git/config based configuration for remotes, simply because the
> old data source are pretty much frozen read-only places these days.

Okay. But by the same reasoning, I want to hear nothing from you anymore
about the sort of maintenance burden you talked about in the ssh_variant
patches. That burden was ridiculously small compared to what you tell me
you want to keep (and for a single user that may have moved on). Not one
word.

Ciao,
Dscho
