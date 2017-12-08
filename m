Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3238120C31
	for <e@80x24.org>; Fri,  8 Dec 2017 15:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbdLHPI0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 10:08:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:55655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753542AbdLHPI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 10:08:26 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LpcBS-1f1M2s3fT4-00fRah; Fri, 08
 Dec 2017 16:08:20 +0100
Date:   Fri, 8 Dec 2017 16:08:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/4] t/Makefile: introduce TEST_SHELL_PATH
In-Reply-To: <20171208104722.GD4939@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1712081602570.4318@virtualbox>
References: <20171208104647.GA4016@sigill.intra.peff.net> <20171208104722.GD4939@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:IqW/HYV2+eqz/OUqpn0wukb8ZCYpozw7h1vFSv7SwFyMVWjMKmx
 Zg2osPwwHAPud4pWr/3x5NXoef9w8v1bc9Rtv/GYfQd9sE6Ds8dwPnJrdWarsv/rTDu4O0N
 w8DE8ejv8E5sdmF11iDa/uUKOgKD+NTyprD4xyZnrh4PCMzordZHzWnikKc4GXYyuCSiCUK
 XaObdwlECtqPYyL7P5HXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WzkHzuvvoQ4=:7aFJyk2V2imcBfAHvXgPtu
 aAjMUiZbMPbYh/2bbZyQ5TMmWb5gyRU/0nH9OU330VFfOAtxEL/jWwlTKZi2Be5wW7KKoj0cF
 MZDHYlK7DpGIBNkXcvCspcifgUCexRhrzgv7bbPJid3MdV1jeC5ut4h5GXdf4djeZS4voIP5q
 UOyPmK8pLim/9e2FMakzpTVTTPTyiX7Mao2hE+XE8hdiTX4y+sg0ztMeVCyzTCUr7FkThkFiN
 8ZdrnZj8LinNCsCMSBkUrxx2kMbVi/o3mlcKs5Y3x8VuBg3IrNT8LqMhRUjkGD6bvOr9E00LD
 rzLrK+VzpPnY/AjQXdA8nWY7YlzTXq7iu6xZEa6VlxxU6rEmEE9aUl7ZnS+H1AXLopnTwQ+/x
 W5E1uCjkPGQ+vP62Jj+xYgySlwO54dCKKplOMGReVZTgQeq721bKDME4zhTbCObfFJEPYHCgK
 VWI461repjX5wWH/YnSb8IGxxk+mMuJfQ6bbgFz0bIixNyIMsR/0lyQ2lyJZBZ+01tpkfWRMM
 fjyM/pGgugQGVdD7XuB7OSJd19SrHD3qVnNA/MaLX/7mGSbxjiwY+ES1nUCjkeVPKuyAuBXVb
 D0vg1+sc1mhKssOcOSSA43KOm/bfiPAWNRwLzbFq3dBqzNQvusgpyg1srRaNjzVyhJ8fmyBmp
 Eug6LsOQAaWKQ6l+F1yY/IKCl/PFHoXN3ViYHYabb+7JRdSKJ4xbXtefmqARGD9pmLYLVIOMf
 kdPuSyv9RzPjhDH2dVRKiD18wGGrOKjQyx8mdFj2x+eCu95du3I9JrHEBauh3khAb72710VwB
 8pf7GDchnARC3TO6U7R31PUPmG7EZTmo6Y30WWDoLcwgnKPO0A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

the other three patches look good to me.

On Fri, 8 Dec 2017, Jeff King wrote:

> You may want to run the test suite with a different shell
> than you use to build Git. For instance, you may build with
> SHELL_PATH=/bin/sh (because it's faster, or it's what you
> expect to exist on systems where the build will be used) but
> want to run the test suite with bash (e.g., since that
> allows using "-x" reliably across the whole test suite).
> There's currently no good way to do this.
> 
> You might think that doing two separate make invocations,
> like:
> 
>   make &&
>   make -C t SHELL_PATH=/bin/bash
> 
> would work. And it _almost_ does. The second make will see
> our bash SHELL_PATH, and we'll use that to run the
> individual test scripts (or tell prove to use it to do so).
> So far so good.
> 
> But this breaks down when "--tee" or "--verbose-log" is
> used. Those options cause the test script to actually
> re-exec itself using $SHELL_PATH. But wait, wouldn't our
> second make invocation have set SHELL_PATH correctly in the
> environment?
> 
> Yes, but test-lib.sh sources GIT-BUILD-OPTIONS, which we
> built during the first "make". And that overrides the
> environment, giving us the original SHELL_PATH again.

... and we could simply see whether the environment variable
TEST_SHELL_PATH (which we would set in t/Makefile from the passed-in
SHELL_PATH) is set, and override it again.

I still think we can do without recording test-phase details in the
build-phase (which may, or may not, know what the test-phase wants to do).

In other words, I believe that we can make the invocation you mentioned
above work, by touching only t/Makefile (to pass SHELL_PATH as
TEST_SHELL_PATH) and t/test-lib.sh (to override the SHELL_PATH from
GIT-BUILD-OPTIONS with TEST_SHELL_PATH, if set).

Ciao,
Dscho
