Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394D520248
	for <e@80x24.org>; Tue,  5 Mar 2019 16:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfCEQAG (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 11:00:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:34909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbfCEQAG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 11:00:06 -0500
Received: from [192.168.0.129] ([37.201.195.16]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvDpe-1h9PtI07iU-010Hq8; Tue, 05
 Mar 2019 16:59:46 +0100
Date:   Tue, 5 Mar 2019 16:59:29 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] builtin/config.c: don't print a newline with --color
In-Reply-To: <20190303172428.GE23811@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1903051658200.41@tvgsbejvaqbjf.bet>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com> <nycvar.QRO.7.76.6.1903022123160.45@tvgsbejvaqbjf.bet> <20190303172428.GE23811@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VOPfDYNZboGpkO0Vx4XLI1btmOVguGQQCge8tullw1FQqbw1G6s
 3SM/tfGVRB66RzxoCMVY8/OHYtPnnhJsD84M6CNK7zes3Zu9OpVPJqSK3xeP1M5IN4rDopA
 FWZF8ZyUhctjr0nXLiFi8cW2vnd/fsiww+PBFSIxSQN2Fg1RXjzuyy+GaX+xv3jCffVLFzk
 nMc94Ki8LFzSZRNymhnbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rZ6DOVGqzyw=:6rVKfrSkq9iaBg/3Db7dOf
 7eGhEdMy+iKPfdnKRXs/GnmM4Y4dipIs147yiIOd3BEL/rMhDIwW540L+c8EqjYyX3klwvg1/
 1XM52svyIOTzq56M9slQC3Eo8LMEpmkc2iywzTeJgdj1M2Q+c4cS4dBJtVZcBQ4sTKFCXFTz5
 NpTH3TP+U9TSHIoLZ+m9oHCWV3iiEe2+/3lj/6EX78iIXgdbG873uu4vko23YRXujuKe7RYbK
 r/IkJhLopxLh8xBDy9+84Uz68MKC6qdp5bnpc8s4uu6lRMJELmrOe/UZ5Ridir5kxwqEU+QjD
 lwbqK2C7q6jQJS9/SuekJKrAFL+c0wsq+HT/7ryD1KNPLB3rt4xqs6Cw2NAiCcFxQcogt42hO
 cNdCs7hMgpd5CCl75qkweJlGQs6c3htmTcBjM5T++3+X3cMtvTmSJefcNDnPh/ijrJh3aOFiK
 Ru8LuWVO+U09sDU+Q8j1z4QPcSwCztoE/3u4amirR6TbzMD9RZZYhfo7+4TGiGe6gcoIHbMtU
 iXGSNpAlLzxJgyk4zyALZkBEgUK3enSgJ+5izocvigP1In6MKWktJe5yPm7wmkqDsDmdzg39f
 CZVWi/MUWgYjXrxVJVolyrFvzh5mkC51IyVjMbiKOji7e+IYpYvZo0IEPGmbCVS5Dx3gWr9Ac
 gyD+fvPFv+ESbb5kR2wjLE9Zja99WH7qCaLT0Ta7S7zWUOjyUDKHow1ovpK0rJ5ZhVPAkCQio
 mmWKKXMRAwH7WbTRDxr4UYufUO9KfhrTa/3BkTSxociA3qQ84AT5YYqOXjYqKQ+ychI4chTw7
 UBd703uKhyeMM7LfEp65nQBJaVJOoa/vxmVp79qXTvSoBOOo5HMITelX6uI5xYp8ZBGV8B0JT
 U04KAbutCaZvS8R2BoZw/tLBVDW1Y9RxAztCXQDGvj72NtywzWME0YCrSl3GGR1cLBmzVHSsT
 eHB/8ypBiCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 3 Mar 2019, Jeff King wrote:

> On Sat, Mar 02, 2019 at 09:25:28PM +0100, Johannes Schindelin wrote:
> 
> > > This bug has survived because there was never a test that would have
> > > caught it. The old test used 'test_decode_color', which checks that its
> > > input begins with a color, but stops parsing once it has parsed a single
> > > color successfully. In this case, it was ignoring the trailing '\n'.
> > 
> > Isn't the reason rather that our test compared the output to an expected
> > text *with a newline*? IOW:
> > [...]
> > This should do the right thing if you write
> > 
> > 	printf "<RED>" >expect
> 
> No, there are actually two problems that cancel each other out. Because
> test_decode_color() is implemented in awk, it doesn't see if there's
> actually a newline or not in each record.

Ah, so it is actually another instance of "we really need a precise
test-tool command for this rather than a somewhat incomplete and fragile
script" ;-)

> So it _always_ adds a newline after printing out the line (and I don't
> think Taylor's explanation above is quite right; it does have a loop to
> handle multiple colors).
> 
> So regardless of whether git-config is sending the newline or not, the
> "actual" file will always have a newline in it.
> 
> And then to match that, we used "echo" which of course has a newline,
> and matches the test_decode_color output.
> 
> So you're right that we need to switch to printf. But doing so without
> dropping test_decode_color() would mean the test would always fail. We
> have to printf the raw bytes, which is what the new test does.

Fair enough.

Ciao,
Dscho
