Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C101F744
	for <e@80x24.org>; Tue, 19 Jul 2016 07:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbcGSHWS (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 03:22:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:65166 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbcGSHWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 03:22:17 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MRXVc-1bna4p1cO8-00ShB5; Tue, 19 Jul 2016 09:21:47
 +0200
Date:	Tue, 19 Jul 2016 09:21:46 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Herczeg Zsolt <zsolt94@gmail.com>
cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <CAPp-Vra8c7eFegysKrM-hZKNmD6B21XqVkE8HB0QcG_m8hu+Ow@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607190920020.3472@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com> <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CAPp-Vra8c7eFegysKrM-hZKNmD6B21XqVkE8HB0QcG_m8hu+Ow@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ox4Ianwbf6MbJpM/QLt6QVKTyE+bF+o5qZkpFvioGHuI3oBrXv8
 gCSwuihZqCSw+ZfZJXiKw7kHkY1+NEmFJFpTeObDDcK9wQxSN/rjtGzHOFCul8o+724fSEp
 WZ14nV8IC278ZSfUnIHRDZYErvsjPLpitbSapjac4A7NMMhUBIonBPS38tjz0yJDn7PYEwO
 rTGa7xOYfQKsu5IkGHpPw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:7xwaM+RJjk8=:bskonoVVoiYQcFZ9KqfbUB
 t5YVeq9oAXGMicLn0PwvOd5cuEh3H0ELXX0F0f1+DiBF2ptdBWj4ZSN5r+GteLMw1nEWZGuta
 BX/FI9W9JILSUU0Vxrr7NrREEo5jsyWa3Mf4vH2NaHTx8/vjYZxxp9Ztbk3S9YoxchVbC2fc5
 9c3agawzXtXAxUx9Nw4qMNIZva+HbtB5kZNe60zUcmDJUT2553QLoHlAE+g6bmt690wOMznvx
 XMj6JtiLkQyXWPtLoHM0b3aDJXRsw0xgvmxNOT8mX4UaQe4ncdeXupXQ1wFyzBrrEbv5o6Nh1
 uUd/M0XvLtvKdFv47F7o5XyjJAeJUR1Gu2xAq3GUhjduoAvAoS3itTTbVBi+e1UTeuAqGo0aB
 RnHbD2ziyYK10tZQt+q/ZlBDthNHhlaiG7og7GWVKSXpNKd0XrETXWW5N/Pf/WlyBK3TP3GmK
 SKjPj6cviTie72K9H8PoEZgHUZulIpjviioqP7GXP7lpSz48q3FE/DwQpELwk/1D9fD5mv7Km
 FyUY5uaC9M5aKCmBtKUWpnK1oPe94b52p0Zz/Oinh5UxMKWU5TGGjp3sIvG1pry7+zHjpYD5j
 /FaYRpddmz+OITzagWUbEpQUZVvjQw71yQ2jHMD1sKhaPL72BoX/GlJPtpRBqS6dsYkdY27ya
 /NoVvSOHZKPPOBdD+QWvOKwBmIJRqB8zKdWMAtUXUxnWNjm3fBgVKPlxBR5UeQnbkngr0skZ/
 BCo4REWpmecc8S93xnPsHfblpBCgvD38YJDl8GDuM+LNc9JK7Lod60SsGY+DLdIXqT/idqX1Z
 QOa+0u5
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Zsolt,

On Mon, 18 Jul 2016, Herczeg Zsolt wrote:

> >> My point is not to throw out old hashes and break signatures. My point
> >> is to convert the data storage, and use mapping to resolve problems
> >> with those old hashes and signatures.
> >
> > If you convert the data storage, then the SHA-1s listed in the commit
> > objects will have to be rewritten, and then the GPG signature will not
> > match anymore.
> >
> > Call e.g. `git cat-file commit 44cc742a8ca17b9c279be4cc195a93a6ef7a320e`
> > to see the anatomy of a gpg-signed commit object.
> >
> 
> Yes and no. That's the reason you need the two-way lookup table. If
> you need to verify a commit which was signed as SHA-1, you must use
> the lookup table in reverse.

That pretends that it is both easy and trustworthy to know when (and how)
to recreate the SHA-1-ified version of the commit object.

Neither is the case, though.

Ciao,
Johannes
