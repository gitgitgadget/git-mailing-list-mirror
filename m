Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0997A1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 15:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfBGPm2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 10:42:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:59129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfBGPm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 10:42:28 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfAog-1gU2vc2utu-00Ornq; Thu, 07
 Feb 2019 16:42:14 +0100
Date:   Thu, 7 Feb 2019 16:41:57 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
In-Reply-To: <20190206185520.GD10231@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902071632280.41@tvgsbejvaqbjf.bet>
References: <20190203230152.GA25608@sigill.intra.peff.net> <20190204205037.32143-1-martin.agren@gmail.com> <20190204233444.GC2366@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet> <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
 <20190206185520.GD10231@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fOtEPtT0kH8S2BYdNEI3NYIQiux8prsJQJeRv4FlL2lgTGUAirg
 TXBn615Th8IoVfaeeIWK4Z4ueUExXRikyWp9oAuC76oIs3PSMWYbkaYUzNEicyIMvC49Bpu
 v/a1IO/5gh0JKK04+lbq3mB4DYDSJjMagsIxmy9SW7f+5B7J+e4AQ/sJ82vzg7om9/ki/yz
 iklUxHUhWNWXXgHkjkCBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GgK1fSlfkGs=:vPn2mzSFmS7kEzvQTjt2i7
 pTykkLUZTS+rRRiPLmPb5YuiKuKqbOfvlffIfDO5hNtI5FN2MleKyCO50tHarEpk6aeVINq1V
 GPnefeewWrqZltF9Lj+H7LB3P8bbMEPJb8cwfleI7GefSF1l37dtnWU1zvY49bwGn2Jov1Ie/
 1MuKoNP2gIwWwmIz/ZJJc278gGha7d647aAqvDma05kXIVGzGz3bhkzAfQcG6m3OC7Gw3pKZq
 +fTeJ+CLDSDGju4l95gM03ebI4S8cFRSbKyHR9w2UeJZJq15iaveqh6DZM4Jkdb0uoN65Kkoz
 512d/p0mgAOEQgOzgzTWlYTiCMCbHg2jKEbNYFJ7Dy4hW2pDEMrOFt1C27fMAwclpth1Gd2Dr
 +QyXVHq4EQkux6dHhOYPR16aOZP5sxQv4O46GbbFaB3y61bJ63o8PMVY2Fqr+8mD9Rgz/HEUw
 um8c/OPV6yMf5OsEftGd7dy6TGCe9KAzkJVynstWjN/hUT3zrz2YHEPZlstaJR+Ts6vnPGXy6
 V59mQeuYVnP4dR58I1hKH9yqUoijcp8T1XUGkDHImwKBm296+rcgWZx87zTDk+wHWPZ5jd5mz
 6ltp+2BHH9rIFpjEpEEw205gwbnYsbfGfhazevmJ0yN/or8Va0pPS6AiPmI4jVUTJles1RAhD
 Q7UfPA+sgB0Dn7QVbHMIILtuLe/4JstfRxobN2jAeN3rnRVBlBw8CedHKr6W6p7vgvXSWNWOm
 7medrR5UjCHtNKXnCU+g8XQa8EaWQ965VqZjajVQB0nAPlpnehXqnPjlK/IoDGKlUMVMyhAw6
 kiv47Vr4YwhL6QEqbtfKJ4x9z9TCnKxcw1tUxXVAA3areW7hIq+3+GWBF5r5lvEg0RilwH76t
 B48tu8TQI7fPPJd+a5/m5zXCedif/GA4mWgpOc92O0al7fA+8+hQgUG4n2q/QpDQJXBMa14zl
 s9qT0IfZLFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 6 Feb 2019, Jeff King wrote:

> On Tue, Feb 05, 2019 at 10:45:35AM -0800, Junio C Hamano wrote:
> 
> >  - Perhaps find the fork point, run tests to find known breakages
> >    and exclude them?  This would simply be not practical, as it
> >    doubles the number of tests run, for individual topic branches
> >    because there are an order of magnitude more of them than the
> >    primary integration branches.
> 
> I think this can be limited to the tests that failed, which makes things
> much faster. I.e., we run the tests at the tip of topic X and see that
> t1234 fails. We then go back to the fork point and we just need to run
> t1234 again. If it succeeds, then we blame X for the failure. If it
> fails, then we consider it a false positive.

If you mean merge bases by fork points, I wrote an Azure Pipeline to do
that (so that I could use the cloud as kind of a fast computer), but that
was still too slow.

Even when there are even only as much as 12 merge bases to test (which is
the current number of merge bases between `next` and `pu`), a build takes
roughly 6 minutes on Windows, and many tests take 1 minute or more to run
(offenders like t7003 and t7610 take over 400 seconds, i.e. roughly 6
minutes), we are talking about roughly 1.5h *just* to test the merge
bases.

And I sadly have to report that that's not the end of it. Back when I
implemented the automatic bisect after failed builds (for details, see
https://github.com/git-for-windows/build-extra/commit/c7e01e82c), I had to
turn it off real quickly because the dumb bisect between `next` and `pu`
regularly ran into the 4h timeout.

Ciao,
Dscho

> You do pay the price to do a full build at the fork point, but in my
> experience that is much quicker than the tests.
> 
> -Peff
> 
