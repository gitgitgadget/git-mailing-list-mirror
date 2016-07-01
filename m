Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF68220FD0
	for <e@80x24.org>; Fri,  1 Jul 2016 13:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbcGANjP (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 09:39:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:49529 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcGANjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 09:39:15 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M6P5z-1bYA1R3INP-00yRPP; Fri, 01 Jul 2016 15:39:06
 +0200
Date:	Fri, 1 Jul 2016 15:39:03 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	"dmh@ucar.edu" <dmh@ucar.edu>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] add an extra level of indirection to main()
In-Reply-To: <20160701081919.GA21076@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607011449380.12947@virtualbox>
References: <20160701055532.GA4488@sigill.intra.peff.net> <20160701055858.GA4593@sigill.intra.peff.net> <alpine.DEB.2.20.1607010953440.12947@virtualbox> <20160701081919.GA21076@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-127919728-1467380346=:12947"
X-Provags-ID: V03:K0:tEe662cniFiJY6sj9iaHWdWyAm6IKwffm8n6aZw87VqTwIg/U+H
 ESeCnYBGNByr+C3V/zizmMXnqwEVqBLriJBReRQ+CcrBHqfce7IushZUMw7HUaJPB4KPBRt
 QL+Ul5HqAOhDqvfS6br4IaqVW8X+rcnB+/CZU+NWdZue2IPkf+2CvG0FiLTQB8xtetOfaXT
 BFGJsf3lit+Vs/aAa/79A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:FGr6zaTCFYo=:9Rp2fpUh7VemjmZ+9WPu1W
 3OJT7acg6zzwlrGUbklqpE3TYDE+Aar5IMDzOcBXgPWk1Nu+x78ykR30BOXakui4sDLYtoYAM
 kLpajrun7Kimws2CX0LP3Pa2Zxvfz8b7HoTW/vkN+nLpg2jqJptdXGu3GmJ6rf6qrSiZ1iztA
 Kv8SzMDsHkYd8w2E1w+eVt0aUSN6BbIZIFzTLzES0acjLR1q3vzYO6ujNrkp3AyXKK1K8ejz/
 bixelX12+a5T7ycxcpbZOGrrYoZduZYmSorPpY2zeT1QROhSLor32fRP/pyy8vw712mlxnhF+
 OQEFl9A7WnNAwclIyl8gH2KBwoms/dPORCX2Ba8PRIo2HntJiop6D5OuN9Jg/SfjEQDxR3ITk
 gYrNBjFm7+0ksEaXMrrqrpVDQ7qTm0A1E8y43kp0zVcV1gOzcJLJWl0Uu72bcQ0RGwYkAi1zS
 9AgO0VsYoqIPvF6WWQ/9Ym6hXop+QqXM9J083bGu5A0pnMunk01kYrVZLRezLXH7G9Qze2mis
 9SxZLbqLruo/J+sGwpfNg+235rSDUsFNjUAQVsCmskzD7vlrohqnyJmA4kW6WcRSHzF7lSucY
 IJxu6rg9Ja/iNEmWLTPlhUgtuBPcoVBI5ippYh2g750i4w5/m2cO/jkLn0J3/0G0Y9BbetKUP
 SwAle1ePoAz2GjcS6pOCFP5Zw4HYlFcLc5f85k0yKhc8a31XK7Iuxsi7DGbcjP4vCSLsePX6q
 w4W7qM3kTzJiqZDcZPR6Td7zVWPdbYSHIoKSw6dZ4nM0OuQblpq72JwngKLyJw3Yk9AxcWyOW
 G0pjGLW
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-127919728-1467380346=:12947
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Peff,

On Fri, 1 Jul 2016, Jeff King wrote:

> On Fri, Jul 01, 2016 at 10:04:44AM +0200, Johannes Schindelin wrote:
>=20
> > On Fri, 1 Jul 2016, Jeff King wrote:
> >=20
> > > I waffled between the two mechanisms. Opinions welcome.
> >=20
> > I am happy you took the cmd_main() approach: we do have to play some
> > tricks on Windows, in particular in some upcoming changes that support
> > building with MS Visual C++ (we want to ensure that `argv` is in UTF-8,
> > which means that we actually have to use the UTF-16 versions and conver=
t
> > them manually lest argv has the current Windows encoding of strings).
> > Which means that we still have to use that mingw_startup() trick you
> > mentioned, and which would have interfered had you chosen a similar
> > method.
>=20
> I actually wondered if it would make sense to get rid of the
> mingw_main() macro, and do it here as just:
>=20
>     #ifdef MINGW
>     mingw_startup();
>     #endif
>=20
> or something. But I didn't look deeply at it, and anyway I am afraid to
> touch anything in that area because I can't even compile-test it.

Sure. There are a couple of patches in flight to support MSVC better, and
one part is a duplication of mingw_startup(). I would like to fix that
before merging, of course, and hope that it will naturally be helped by
your patch series.

> > > diff --git a/common-main.c b/common-main.c
> > > new file mode 100644
> > > index 0000000..2b96bbf
> > > --- /dev/null
> > > +++ b/common-main.c
> > > @@ -0,0 +1,12 @@
> > > +#include "git-compat-util.h"
> > > +
> > > +int main(int argc, char **av)
> > > +{
> > > +=09/*
> > > +=09 * This const trickery is explained in
> > > +=09 * 84d32bf7678259c08406571cd6ce4b7a6724dcba
> >=20
> > This commit message says that mingw_main() is declared with char **argv=
,
> > and that is the reason why we have to convert. Maybe spell that out her=
e,
> > and then in a subsequent commit, we can fix the mingw_main() declaratio=
n?
>=20
> The description was sufficiently long that I didn't want to try
> repeating it, and opted for a reference instead. If you're planning to
> fix mingw_main(), I'd be happy to do that as a preparatory patch, and
> then just skip this trickery entirely. :)

Deal:

=C2=BD/5 is in 5c54dff5c54e68a1101d8fe37aefc6158fddd7f2 and the fixup for 1=
/5
is in 7b74f7aabb56b428c74f5983c066dc9ea8fe5116 in the 'common-main' branch
on https://github.com/dscho/git.

(I had to resolve merge conflicts in a couple of the later patches, so
feel free to just use the branch, but please note that I cherry-picked a
patch to let me compile with DEVELOPER=3D1 on Windows, so you might want to
drop 7b74f7aabb56b428c74f5983c066dc9ea8fe5116.)

Ciao,
Dscho
--8323329-127919728-1467380346=:12947--
