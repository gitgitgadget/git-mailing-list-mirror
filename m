Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCCF1F744
	for <e@80x24.org>; Tue, 19 Jul 2016 07:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbcGSHTQ (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 03:19:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:60773 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105AbcGSHTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 03:19:13 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lm2lZ-1apnZK0ZGL-00ZfGW; Tue, 19 Jul 2016 09:18:51
 +0200
Date:	Tue, 19 Jul 2016 09:18:50 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Herczeg Zsolt <zsolt94@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607190910370.3472@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
 <CACsJy8C+2=qv5Vu=tGeDTK_Q+XSAv3qEJw0nrHbEWU7psDf=Cg@mail.gmail.com> <20160717154234.GC6644@vauxhall.crustytoothpaste.net> <20160717162349.GB11276@thunk.org> <20160717220417.GE6644@vauxhall.crustytoothpaste.net> <1468804249.2037.0@smtp.gmail.com>
 <alpine.DEB.2.20.1607180905320.28832@virtualbox> <CAPp-Vran2GZFTyJHb2qxgh3uRpM0ar7K2+VbbLcBK74_7aaxVw@mail.gmail.com> <alpine.DEB.2.20.1607181750470.3472@virtualbox> <CACsJy8Ba=c+-WV2TsY768_fTDO2KesS1b6BK7kdykNY6gkh=UQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QY1SMfy/44WIcL/46H1pZjMz6gypjFKzquNSFFmgfAyyHCGe0pN
 Bzf3JNBcx23qEwXDBN/e9DtURsEa1c+qaAqvr1VDQlXYcWsKGA0ezt/iCLo7xytyd38vVlV
 0qRRZpTSUaIEiYruzNOtum3TPzzdk/ZlZU8Isqu/FOt6+/e2c6QmO1YimgZ6M70MIFcDUPz
 8DMe40oL78o62X5H5C2TQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EpypZ4nY8uk=:O62D6iMvJ6U4TVIY5yeteU
 4hIB4In+GssSw0jumLMdkeskGVh/fD2QzM5H0UOWcn5NJQjrbGqyOcJ42lGssTTztApWn4ras
 G+TcxK+H6QpkAePqp/y3foigSSNw2eFFjjn07UWj9sGRFDmkZr9NdzZVpqqQMym6fNa7+Q6UW
 BAUOActRGmMy2JMoebMgkoV/QnoDebMHC9miZZe4IkL7cbCYcYoWFpjyA0/hdQHGzCizifNSq
 s9VclMSxsy8eAbkcFbCQBct1jJommq5Xn6Uv5xgKt47hsq2EqijIaJ44YhLFB7PPT1611UsL0
 aCROJ4aJlfjMfm9Dg3IpHgoPHoyuQYQhmhb+TikXw8IgkNhIC35nGx09hm/B1YzxqQXUUgCe0
 fJJj7JJeDAQazfmLYTdlbmGuVFwcr0fQRp30UILF72LW+AXycJmwZIweps23f1FiwzZqlNVKD
 j5LpHVmzEAhZpfH56kOnXUpg8gkLBCnCeBI5zuS8Xg0raPBhgO07c5Gk0YB60kDBB9xdIUcWO
 4vSE7oq/sIpXriUYU+H+ME1x0CknjVpnEv+xYa24nFLFVDZEbrRbuopqLx8XDVlrxLQJ6kI0D
 unXjCXgWYVptHZshNzNMaZce1XLUyJFRTGmTTBhMZiBmdSyiS+wp7jESZukAvtH7mrKYPsVTm
 K20k71AtzPVZMiIkIfmK99UoOqmFe4Ow/8R7g6dKnadmcVOOepnkuyOr2801wbBCwTXWmY+ba
 v5YzxH0uQjD+LjO1vqmhWphWIcMFXB+N017tT1aw165H8nNu26KXg9JyimB3oRtVm0w7IRVbA
 5V6T6QC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Mon, 18 Jul 2016, Duy Nguyen wrote:

> On Mon, Jul 18, 2016 at 5:57 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 18 Jul 2016, Herczeg Zsolt wrote:
> >
> >> >> I think converting is a much better option. Use a single-hash
> >> >> storage, and convert everything to that on import/clone/pull.
> >> >
> >> > That ignores two very important issues that I already had mentioned:
> >>
> >> That's not true. If you double-check the next part of my message, you I
> >> just showed that an automatic two-way mapping could solve these
> >> problems! (I even give briefs explanation how to handle referencing and
> >> signature verification in those cases.)
> >>
> >> My point is not to throw out old hashes and break signatures. My point
> >> is to convert the data storage, and use mapping to resolve problems
> >> with those old hashes and signatures.
> >
> > If you convert the data storage, then the SHA-1s listed in the commit
> > objects will have to be rewritten, and then the GPG signature will not
> > match anymore.
> 
> But we can recreate SHA-1 from the same content and verify GPG, right?
> I know it's super expensive, but it feels safer to not carry SHA-1
> around when it's not secure anymore (I recall something about
> exploiting the weakest link when you have both sha1 and sha256 in the
> object content). Rehashing would be done locally and is better
> controlled.

You could. But how would you determine whether to recreate the commit
object from a SHA-1-ified version of the commit buffer? Fall back if the
original did not match the signature? That would pose at least these two
problems:

1. The point of a signature is trust. If all of a sudden the signature
does not match what is supposedly signed, that trust is broken.

2. The point of going to a stronger hash is to increase the trust. If
any developer could decide to sign the SHA-1-ified version of any future
commit, and Git validating it, it would be even worse than not switching
to a new hash: it would leave us open to collision attacks *and* pretend
that we prevented such attacks.

The more I think about it, the more I am convinced that we have no choice
but allow mixed hashes (i.e. both 160-bit SHA-1 and 256-bit new hash,
whatever we settle on). Otherwise there would be no reliable and
trustworthy upgrade path.

But maybe there is a clever strategy I failed to think of?

Ciao,
Dscho
