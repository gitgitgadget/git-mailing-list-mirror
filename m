Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367E020248
	for <e@80x24.org>; Wed, 13 Mar 2019 21:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCMVFg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 17:05:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:53531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfCMVFf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 17:05:35 -0400
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3AzH-1go1tD3Ipz-00svMT; Wed, 13
 Mar 2019 22:05:24 +0100
Date:   Wed, 13 Mar 2019 22:05:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
In-Reply-To: <20190313193909.GB3400@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903132153480.41@tvgsbejvaqbjf.bet>
References: <20190312213246.GA6252@sigill.intra.peff.net> <xmqqsgvrfsrh.fsf@gitster-ct.c.googlers.com> <20190313193909.GB3400@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:KT/X1o/hnNvS6o9Unt+0EZdv79ZKr2BkuSz++3eju8nCsv4Kvwu
 dPxCSZtk/VGKksQYQbs/SMvtOrvBOEs+xYDbSOvnkveg7MmRTU4g51/sZGwPKpRP0+cTUqG
 y1InEHr6QZB5u+MAnO/iAQ+Mwqa3WdMCZdhL1HD87npMh3C8H7Xfgk2dPD2yap5XnWjQmbw
 sCUaG3K6lGIMlHIHXrh/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C6ZZ8UpSUOQ=:8eqtIyUrSQr4dG56Uo+ZrT
 HpepsQMqbHQNfvup7mznPIhGDdpZBiIVa6yN4YKdioygCSFziIS9okS7msP70/jEV35nvcDfY
 Oy2/moNdrz/zctEFHTfr5g045fW6z/QT87qhau6FsvgKW12ggH1UhWD9jKelZRv8D/6uofsfX
 0fy82tMqQ5Dz3JfziMfBKv4op64D7Jbjxxt+FTt9WJ8pCnzdquDc+FDRMdcp0kYFBW++dmeg/
 69kSsDlYymuBe7KJ3dGzUHDOOIssbYvfkiszGK11bYf9PQoCSbZBCI8b1br7kAlkmrVC14SDS
 FUm8g24PivJReb9Mn6jX1qwVsji/IxFVcOAa+y1zPe0AeUeAxQ0O+FvygpZifKhmSBDj/BC2S
 7gcmsLE6ZS95SUwLTYb/7bwMt/3eH63SGJ/dMISzfhUP+NfhcDwxasQ/JgThGcUCcGjvlEYPa
 iTMP7AGDdGT72VuHcBaOqdoagntRo9k9UitL9PwMk9svb6JO9YK3XziYmhUnWh6+F70EErUTo
 J56SeaUYyitalyk2mIUyeDzXsY7HgVLkq68DreWLoWupGEKV4nxqhjY71v/jOVJgS1j3IT6Gt
 aqT6Zp0Wv2jSA5v1eCdxcRc4LkiSgF59DVLLzi79T0tOwlLnJ6p2aqCXQQv6nD56U1i+V4UaK
 5NA/xpnWzHiE0bK9A1Q8aYCGEvIcyVDLL1yOJ2NTX/smWBFy4s4vR+l15za3iBkFbbmMMRBCc
 JRWSEZ7Nw+pRT54hriQuV8DG0FgNiK3QxkTSk+S/aPXj+tP0SQ8sJpJ+J7lqnDkg5mddXHQYZ
 rquM8LQ6wpsFBUiozD+Oqbu/pxNMTx2PSxvzDex8FYzuf0+rMb7Kx/UZfFEUi0b4PJjuGQbza
 b4H9LRm4OtniSu1+gxaBaSQMSzbTj3J1irVqoeh67K49TPl/ZL02czdaXDAqO4mpAmCx5OW8l
 PpZ1MhyPKQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 13 Mar 2019, Jeff King wrote:

> On Wed, Mar 13, 2019 at 10:49:22AM +0900, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > infrequent contributors. And there are a few reasons to prefer GGG:
> > >
> > >   1. submitGit seems to still have a few rough edges. E.g., it doesn't
> > >      munge timestamps to help threaded mail readers handled out-of-order
> > >      delivery.
> > 
> > Hmph, I had an impression that the recent "why aren't these sorted"
> > topics were via GGG, not submitGit, though.

Hmph. I thought these were sorted out by
https://github.com/gitgitgadget/gitgitgadget/pull/23...

Junio, if you are referring to your complaint in
https://public-inbox.org/git/xmqqftt83bt9.fsf@gitster-ct.c.googlers.com/,
I just had a look, and the dates of JeffH's 00/14, 01/14 and 02/14 were,
respectively,

Date:   Tue, 22 Jan 2019 13:22:12 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:12 -0800 (PST)
and
Date:   Tue, 22 Jan 2019 13:22:14 -0800 (PST)

Not quite what PR #23 tried to achieve. So where does this problem come
from? A little further digging reveals another, quite revealing header:

X-Google-Original-Date: Tue, 22 Jan 2019 21:21:57 GMT
X-Google-Original-Date: Tue, 22 Jan 2019 21:21:58 GMT
and
X-Google-Original-Date: Tue, 22 Jan 2019 21:21:59 GMT

which makes a ton more sense because GitGitGadget would not ever use -0800
as generic timezone.

(to see for yourself, just direct your browser to
https://public-inbox.org/git/pull.108.git.gitgitgadget@gmail.com/raw
https://public-inbox.org/git/1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com/raw
and
https://public-inbox.org/git/4aaf4834bfa9f2169e2c00f7cdc6c75281567c15.1548192131.git.gitgitgadget@gmail.com/raw)

So the *real* problem is that your GMail developer colleagues, Junio,
decide that GitGitGadget's Date: header is not good enough, and override
it by a less useful version.

:-)

> We did have one case a few months ago, but I think it was since fixed.
> Whereas it cannot be fixed for submitGit without major re-architecting,
> because the mails go out through Amazon SES, which writes its own
> timestamp.
> 
> I could be wrong about GGG being fixed though. I haven't noticed the
> problem lately, but we definitely had a submitGit-related one a few
> weeks ago.

Maybe you use two different versions of mutt?

*ducks* ;-)

I come more and more to the conclusion that you can use whatever mail
client to read the Git mailing list, as long as it is mutt. Which leaves
me behind, as an Alpine (and occasional Thunderbird and Roundcube Mail)
user...

Ciao,
Dscho
