Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC481F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 20:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbeKPGKt (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 01:10:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:49079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbeKPGKt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 01:10:49 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MI5JG-1gKeGw0pgM-003uR1; Thu, 15
 Nov 2018 21:01:24 +0100
Date:   Thu, 15 Nov 2018 21:01:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ga=C3=ABl_Lhez?= <gael.lhez@gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
In-Reply-To: <20181115164300.GA29290@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811152059060.41@tvgsbejvaqbjf.bet>
References: <pull.79.git.gitgitgadget@gmail.com> <pull.79.v2.git.gitgitgadget@gmail.com> <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com> <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
 <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com> <20181115043409.GA3419@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet> <20181115133749.GA26164@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811151725310.41@tvgsbejvaqbjf.bet>
 <20181115164300.GA29290@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-563690476-1542312084=:41"
X-Provags-ID: V03:K1:z61crdJ0TD/PfWZllkL6n1J/4+YkBf8VdyBXwv59iHl1rVCz59r
 5kdOhnuOlWIfzK4hmfb8H3R/LM9txoVWtcPIQYzscJuX0Z02qfNN7drZD5E6bNwrh6iP/J/
 VTt5W4jRQq/NJLCaPuWpyrUuwAC4JDwSEcba1OASDZzaFDHgmFXUI1v2icmCIP078MB5ko4
 osR0Xx8jKqUqpJb2GpTvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3zVkKjWVBgw=:ox35Qv8C8IrpJBMZvnX8CY
 +g4T9BANZgWkAAo1Yi/YANqqFVXrfWRsLAi0AxDvV8LyFrsztcwb70KYmrbwb+VHrey+8vqUl
 VHJk78+SHTcGjCnNHRXcnRE773lBNeb/FCQp1Cmf+Zov0HH938W4cK1NyA9EYclfj6H/Nw4Oc
 6qq4Yu6GrvynosGsdq4WtLIFKfjOQQAjHlfXFU2Ts5SRr9Ez4brqlgKO7FKJWKvsb3XoDiYkE
 i/HPg1vIKRpO0mpaXEEZnL43nvshyK+c2ZSoqX+fggrmTRp5oPuenz9OpRLauZ7+OihIV4GGy
 lf9kMQsSSM1ABfMVZ17v+UJSIul3lRKSBuj2x7PC0vSUs+FQk1wNk2XrGl1AopFGbwZNCHGsa
 8+yPEV0tCLsvpEDax3hRLIWmM8ZWI4BLF+lmoC06NgC/v0T+WI6bQjm9LXeUQSNJ0BRKF9Uyt
 S1Z9dQcv1PQ8gfibose95bhGDY+75OXHsyDxHcgHlVsnWM4IiEl2JQjlb7G/QYzwN9aanLSFf
 hAae4xLu316RxPfKq/SSvjWx6VgwLNDHVmQr0a0NwjVLgA65kwXlgTqNse3gJzh2Xoh7shW6u
 YnqknwuwWi9x56wJnFxkgry1DSuwofGZkHdhgNtuttxTNnIqJhYKCJmSpNGw7AtqGoRbVrD3K
 pKJ4lO10l7W9uLFakMC31m2K2ozX2MwWJZ8WbNXgvylRFAM93hIQ7ZRQu06lwk9pLQy0cveEy
 IWWK54jgdpm6KdhedfDoTELc/8EzGfGPvk97wVMQJVLIFyBr3L8JzDCarTNW0Rn8dN1PQ7zLZ
 CtIILg9RIMnRTBYWBHz7LYbEPerXKa+hWMaBDQfUGkihpTKvopPMJoKv2yEV/kXMwioxTYNlp
 y+BbGU7UGjIZqvlNniRi+nm2XCYcpjvTXjRAj5OB7Dj+bp3dnJSRAV0D9+2wG0bCPnm7rwnSs
 RoF2aMt1xYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-563690476-1542312084=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Thu, 15 Nov 2018, Jeff King wrote:

> On Thu, Nov 15, 2018 at 05:32:15PM +0100, Johannes Schindelin wrote:
> 
> > I cannot claim that I wrapped my head around your explanation or your
> > diff (I am busy trying to prepare Git for Windows' `master` for
> > rebasing to v2.20.0-rc0), but it does fix the problem. Thank you so
> > much!
> > 
> > The line `test_expect_code 1 ...` needs to be adjusted to
> > `test_expect_code 128`, of course, and to discern from the fixed
> > problem (which also exits with code 128), the error output should be
> > verified, like so:
> > 
> > -- snip --
> > test_expect_success 'try to create a bundle with empty ref count' '
> > 	test_must_fail git bundle create foobar.bundle master..master 2>err &&
> > 	test_i18ngrep "Refusing to create empty bundle" err
> > '
> > -- snap --
> 
> It seems like we should be checking that the stale lockfile isn't left,
> which is the real problem (the warning is annoying, but is a symptom of
> the same thing). I.e., something like:
> 
>   test_must_fail git bundle create foobar.bundle master..master &&
>   test_path_is_missing foobar.bundle.lock
> 
> That would already pass on non-Windows platforms, but that's OK. It will
> never give a false failure.
> 
> If you don't mind, can you confirm that the test above fails without
> either of the two patches under discussion?

This test succeeds with your patch as well as with Gaël's, and fails when
neither patch is applied. So you're right, it is the much better test.

> > Do you want to integrate this test into your patch and run with it, or
> > do you want me to shepherd your patch?
> 
> I'll wrap it up with a commit message and a test.

Thank you so much!
Dscho
--8323328-563690476-1542312084=:41--
