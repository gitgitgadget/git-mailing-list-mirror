Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC4AE2018B
	for <e@80x24.org>; Mon, 18 Jul 2016 15:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbcGRP6F (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 11:58:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:49889 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396AbcGRP6D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 11:58:03 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LdYdG-1az9pQ2pj0-00inl2; Mon, 18 Jul 2016 17:57:38
 +0200
Date:	Mon, 18 Jul 2016 17:57:37 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Herczeg Zsolt <zsolt94@gmail.com>
cc:	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607181750470.3472@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:iDB6bpl3Kl322dJ/ka06AQa+7kqn7XlkM+sivvCCeDWLzyoQbj2
 Mcr1eT3NnIQB1/MVq+Zbk/nzQy1jMRVhS7H/MCZW/6u3duyIq9TUj46bN/oQ3skb1SAu4/v
 ogQeRgROr451SkiE7QMUDIvfCwGzfn0I04fp9D2r6MQ7ysOyrM8fzxFVrYc77SR1a/3o1wO
 P5+/P+VMYkOCfaEA6iO+g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Shzhswt4WDg=:NbzQR/DnIrPmJiXEjvV6cl
 ENh/e/zByVQ7lyyNDdq89+YTOZmC4/dkJQnMhGse0lQ2htLPyavgVKW6Em6Aq5F8CNV9BQZNm
 /IWSaZSfeuBBf51CqzMvqHbgB6cmFea6V3hKT3yAl2Lz/EY4sCVSL5G3uxIEgjA8W2+scNlOr
 Sr3MsCh+DKFbst2ErEMA4bR3t//oSUsF2LDWHgwFF/o6WX+Zc+TxjOGw1wRY1OdjAmDpCPiQs
 6JWib2NhKutnrIO5OhG/lQkqKDrvgr0wUaKwCaRO1Ygf4mUEwKiXgnsXA4dlPD1Lb3xdstf6Q
 N1XTocczVhCZgKt9Tn4p8FhNkYe+o6Ys6Ism+dhodA8a1CxrfHwSGfRRrppdEBlV/hqAoW/5Z
 WKeFWgl/yIIZTKczzYdQQdY/nNB/r6WdWWkiPiH+/GdYsnTwid0wJo5xNH6AePM0RSjtkhEU4
 3TxttBYiIL4CJM7uL6VcbdhrPZFRrYe+JAX5x92iHyxm5esdRff1CKWY7KkCv3IaL5AJlOCZp
 2Cpx3jmh4p1R9JjwB2MIhAzQqLOjetVpj7FFwGm7OC/bWOLq0GPcunimUmiBAKxq0IGKXv24C
 15SnYwu4JG530rsh4zhOkWMYfHGWpPOL9qNqjicFmDiCDvDUyZbGKp9m0Pzz1u1ZEO1uLqMoh
 b1VPjJDRlx5kpnBAwXhdXPvryVsUtarnJx4zV7zUVeyTjZ8JkMMGt4OEhKkPPjMsCnTdCB7Yw
 5FK/eZ00PXBAnV8tTFgQWzp/VvZ5WGUc8X32oS6iI9+0WFS0hQLbeBCgQpSxgKA+UgXpkR0sQ
 pPXfle/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Zsolt,

On Mon, 18 Jul 2016, Herczeg Zsolt wrote:

> >> I think converting is a much better option. Use a single-hash
> >> storage, and convert everything to that on import/clone/pull.
> >
> > That ignores two very important issues that I already had mentioned:
> 
> That's not true. If you double-check the next part of my message, you I
> just showed that an automatic two-way mapping could solve these
> problems! (I even give briefs explanation how to handle referencing and
> signature verification in those cases.)
> 
> My point is not to throw out old hashes and break signatures. My point
> is to convert the data storage, and use mapping to resolve problems
> with those old hashes and signatures.

If you convert the data storage, then the SHA-1s listed in the commit
objects will have to be rewritten, and then the GPG signature will not
match anymore.

Call e.g. `git cat-file commit 44cc742a8ca17b9c279be4cc195a93a6ef7a320e`
to see the anatomy of a gpg-signed commit object.

Ciao,
Johannes
