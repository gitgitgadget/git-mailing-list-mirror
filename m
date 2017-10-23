Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6CCF1FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 11:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdJWLE7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 07:04:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:53101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbdJWLE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 07:04:58 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ldq9D-1dOlXh3Kh1-00izat; Mon, 23
 Oct 2017 13:04:54 +0200
Date:   Mon, 23 Oct 2017 13:04:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 0/3] making test-suite tracing more useful
In-Reply-To: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1710231302480.6482@virtualbox>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kbvNzXr+97o97v6xIfvlAFYm9VIXvU2gboR/tl+ua/Y/joAUk5T
 +d6wuhjMqRiAAZfj3utwR/aB8Y3UQ/CgUHx6eFQHY8g6SqwNNVZjH5HpeyrdMcFCHJUXO5M
 +tIQP35WkqI3B4H8dDCWMwXBQApY+m+dr0DCC3G4WCHjmJeVtrmHFDKDyNFDn8siUm1JBbu
 1OOyxvxqQmWBE4Cv3PjNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6Bd4c25KWGc=:ackvPkFZf15Rojsa492pOf
 T++ijRkWpgkiZ9Bxf7/LIDZxO87/9i+FNAYvvHOv/Cp7fuSYTSQJL8FSVVkEE+5WZao4HtP1e
 eqctQ4X55ar8QviPiZgbMwBSJDNcTrlXF1P+NBlFcVun9trB4a6vcpz48JcdbjzVkFCr1YK50
 fz0WE6f4htbGnoIr9dSMm+Q4n23jLwyvslwRhgE0U3lw9n0UfSWNlB7wR91uRV0UZJV5CrUga
 UC+wIpzhg22ylfHLVmEeihSira3WfpbOVLkL4pemOooRm/8MsTX6uFo3dnfVOmkwZ+nVVtomf
 IwSogPVgU7AvbXbj2iVDF9M7Jl68WIte22xQ7sc18cWe5xKVJ0H02EGb7zya2c91ffKdGz5DJ
 H8zE9ZwSJpOJsVSXHOtD6tK9y5VTRyVia7GL8tt6FaryHxecGWLKGqIvvVZECHAi/pwQNmk4b
 yYxRpX0FmbjjDZZchbXtYID5LGSGGotb4N38qXh4W9EnZN/q/P3UORy7rK9IPKgulFrzUSvi8
 lcpoMccWSx638O6TMXwp7BAH0wCHprNqZTD8PtnO5iCPjJgHKkXCUEOUrMW4PRimOEjKL08J4
 iNDNfq7FkYFC8ZXrbhNQYEX353eZch0YBE4QDuoGu9x5wk9dVfhKin4KpNq/uIGx8hEhwMka2
 jPgbutKnQNmulDZc8W+nZrinFnV/p/6Yux0az1+smWDlPlgdasZoTf7EfxRMmzwErDGDP6LIo
 v+9qPVuHiI+K8AECq178X++WK0ISKh4OZciOsJDxOcIJ7HNDKQzj0W/JVcCx10rxoe0eZyyuB
 rJxWL98vnHD2GJuAwxWHRE8Aj0Q8Ybg8hwwEBn9di+Hvq0nB8IYXnr/zVswQCAhqOEaFGHZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 19 Oct 2017, Jeff King wrote:

> I sometimes run git's test suite as part of an automated testing
> process. I was hoping to add "-x" support to get more details when a
> test fails (since failures are sometimes hard to reproduce).

Thank you for working on this.

> Johannes, I've seen that you do "-x" in the tests that the
> git-for-windows bot uses to comment on GitHub. You may have seen the
> bogus failure in t5615, which this series should fix (you may also have
> seen the "set +x" cruft at the end of each test, which is fixed here,
> too).

Surprisingly enough, I did not see any test failure in that test. I do
re-run failed tests after the complete test run to make sure that the
failure is not due to any resource scarcity, and that re-run is performed
with -x (to double as documentation what really went wrong).

Ciao,
Dscho
