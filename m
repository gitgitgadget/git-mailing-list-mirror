Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1B91F790
	for <e@80x24.org>; Mon,  1 May 2017 12:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422684AbdEAL6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 07:58:38 -0400
Received: from mout.gmx.net ([212.227.15.19]:53138 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164765AbdEAL6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 07:58:16 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAAr-1dQyD40bFR-00MMCz; Mon, 01
 May 2017 13:58:03 +0200
Date:   Mon, 1 May 2017 13:58:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     phillip.wood@dunelm.org.uk
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <42892d55-965d-af9d-fb80-518797d590c0@talktalk.net>
Message-ID: <alpine.DEB.2.20.1705011355040.3480@virtualbox>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de> <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de> <8c1f3519-0768-69d9-4d15-782da0be8390@talktalk.net>
 <alpine.DEB.2.20.1704282059100.3480@virtualbox> <42892d55-965d-af9d-fb80-518797d590c0@talktalk.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bq1PYoQdrxs1RWao59camG49RRV/84WdyjmygoxWobMu9cNLvr/
 1tzEgf4+EM5uYe+D4XILMeV5JUbmectT3zXALn36JwqmPiJ4t2hIvIQA3M221QKvOn5QNBS
 +WqBy/Ez4yrwJhTcJ6/nDCYh/X6TJce9raDbixnlmZjyKMoTtVq7A9D0pZpAlpmVa/IgQbX
 8MOkh39TgrVkQ43V0HV2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g/NXNLKWE24=:87HilddGxY4d0pnC95aJfk
 eCH+TgntUSiX2oww+k200h62ttuirYiN0c78vE2BmLvvL3QPwWInwY4dIMJm8aq339R00Wi6N
 12kMgsJKCRA5aZvhjnpWPdE+2SoZX/rkUJDdMZgO2rT+eZPvQGtDUlcEYco5qplH8sv6JKgbX
 ru+1P8pfJEP3MpDmRMCQXjprBpC4Qk1ksRZO5W+Go3heaXSHvkLNfmSzY6c11Y5Vgt/8LGieX
 DRB+BoFnBoFFDsnzAmNtIejWhI33acwEqgaGITYBpqblTURGlmO00XS/o//Kf6IVK+qogmX5J
 +dV7pNtYw6rtW6UXDBriTMli9w5bk3ObSSIOIEjEj0yKE1Rmn6ekY0GneL29kXoNs9C0aojnR
 kj05SiAFAuzhz4QqqZ0TAB1j4LDCj5LFBU/Aw5zH2FlHHFllwjJjLru8ctesYd8MgX1EVNXEM
 3vReU5Q7w+H1ajtkbCH4KvR/WKFkpISI1hcFsVazHdo5B7W+1cd1Wk5i7vc3h0rZsmHMsyWCS
 3Xyjwmrv4G2IMEGaC5YLgntp7Cs49cIllPXgQUItt9uadEiW2A8nn3alDvXN8D4G8oZ9nAJbV
 3iWUKM0dnCUieeKowLBKXVHqcZ9cWe9ne78ujBAtR38aqyb2K2CBToXUGk03dy0AAE1ALKQe4
 RZCckab5+5Vs/I29Nth2q2CxlddVND0/774E7MQ6XnmwDbgkcdC2XqIlGSpH0LQnyUapCfNGq
 JhyLWcQkDkEZbKiDo/yY2Tq37rfK+CaJl4x0RDmugxkhLQbap7iiFe6o4DoeegWQNC+WWbWgR
 WKzot5j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 1 May 2017, Phillip Wood wrote:

> On 28/04/17 20:22, Johannes Schindelin wrote:
> 
> > BTW in the future you could help me a *lot* by providing a patch that
> > adds a test case to our test suite that not only demonstrates what
> > exactly goes wrong, but also will help prevent future regressions.
> 
> I'll bear that in mind, it does assume that reporters have a good
> understanding of the test suite layout and helper functions though.

Even a shell script recreating the issue would be helpful, as it is easier
to turn such a reproducer into a test case than to write the test case
from scratch.

> Is there a particular reason you put the test case in the autosquash
> tests?  I wouldn't have thought of doing that.

Yes. I looked for existing test cases setting rebase.instructionFormat.
That's where I put the new one.

(I would also have avoided t3404, as it takes 5 minutes to run on Windows
due to its heavily-scripted nature: the shell script interpreter we use in
Git for Windows jumps through all kinds of hoops to emulate POSIX
functionality, and that costs time)

Ciao,
Johannes
