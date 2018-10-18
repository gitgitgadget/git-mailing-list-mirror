Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C27F1F454
	for <e@80x24.org>; Thu, 18 Oct 2018 09:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJRRve (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 13:51:34 -0400
Received: from mout.gmx.net ([212.227.17.20]:35435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbeJRRve (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 13:51:34 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1fkJmO0lip-00flXV; Thu, 18
 Oct 2018 11:51:15 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LpwZn-1fkJmO0lip-00flXV; Thu, 18
 Oct 2018 11:51:15 +0200
Date:   Thu, 18 Oct 2018 11:51:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v4] branch: introduce --show-current display option
In-Reply-To: <20181017103902.GA12137@flurp.local>
Message-ID: <nycvar.QRO.7.76.6.1810181146250.4546@tvgsbejvaqbjf.bet>
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com> <20181012133321.20580-1-daniels@umanovskis.se> <CAPig+cRCfO=3BB6bvDSKLKkhiSA-4=p4-zZkAXvN446_6B1_HA@mail.gmail.com> <xmqqk1mhxzcz.fsf@gitster-ct.c.googlers.com> <CAPig+cRwy2Xhq7uJJ0OfY2nRZgPK9yHr=G+KMKuWx-PXyWv8Gg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1810171211440.4546@tvgsbejvaqbjf.bet> <20181017103902.GA12137@flurp.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:voU14rvmJ/tDk4H4pqxyaPsgMhQqerAHfexaC9EuTBCnfusru8G
 j8OkpYHGsWgeP2vDX7WSLP8fGhvz5iCMysKDhp8c5wPa06QERvAlUCf1WCAKwZFlqzauRHe
 yxnAHYFpJHssOAv7hCcEfgwS0vNZWBcfUixhUVHiC4NMNyzrk+ODzq/3vASqhsMLReGURTv
 GkQ6BvHMhL0ZpV+4lsptQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:26PijWLXiRg=:8WHNcTGDgAeWuiqocvC5z+
 UYKN8UbqfOQITtDJrQhX49Vw3OvbJMsrsMx/ct1yItJeJQVKqed3YN/nFb67BGahuUATmSC53
 xNPu/oTBYXYHS+CrAhaNAGOn9e2qEoeUB2QxgYGZVlOvDYARUI62uNGFFbNAy0ihi+Wm1Li+l
 d2daTWMCtsNUNcR7+tlnLlMdx388opSMLhX2rm6s1buHyumI/nNrz7SbjJseLF0X1nCqBQxqv
 h3dhu8NFBNUEaOhD0MWX0cPgtqPnjjLxAbeFGjVI7SLYgmhhFV053ll8WP5c4IYAZYH/WetYy
 HY0JPLTiYbE/sOzQ/4OFXLN9vy4xgBqyEb31dzd4IhM1rpT/bmIYVocN1bpWr1/8EHfIU1ygh
 HiPVMCvyj9TgTbJWeauaT1ICYSJ41IHUqbcNXFJpfjHyxaVKCb17tb4XDuEyw3qcp/CI/hghI
 iXeYf7KOsCDlLMRGfbHXhANkIRnxsniSbxlh+38WSv/oyOS3L70E7p9AVhIzBYe1sVTPP1Wre
 E+Z5xNNtu0egGC5eua8JGlG5lLNZDcyTeIClzmXqgGWMIAG5X1CfctWiCBfCuFnH+uuxrlsv7
 RlU+Fozj2GPx0Ph71uQ/2cn0NPq0syCOSH5my02GXA3q910eoJTimOLO0hCBRq1yIosCCUvWS
 AFSX4U/5FJx+eVVP0vAupxaC8ChcKkUjqPamK/lny6P321i6I438Iaw5RhSgKWA3MGr5STMgF
 i2i0MA0S7M4K4G1RYWCj+Mor7zpEiZ+JlB+vqK9Zxp2u2tsBKiM07s15fvianSJWeTMIg4ECR
 0ReT69f7R2o8sj5Hc7hDz4EK8cFilmRxEDueofi73qPgK+GJKA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Wed, 17 Oct 2018, Eric Sunshine wrote:

> On Wed, Oct 17, 2018 at 6:18 AM Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I realized yesterday that the &&-chain linting we use for every single
> > test case takes a noticeable chunk of time:
> >
> >         $ time ./t0006-date.sh --quiet
> >         real    0m20.973s
> >         $ time ./t0006-date.sh --quiet --no-chain-lint
> >         real    0m13.607s
> >
> > My suspicion: it is essentially the `(exit 117)` that adds about 100ms to
> > every of those 67 test cases.
> 
> The subshell chain-linter adds a 'sed' and 'grep' invocation to each test which doesn't help. (v1 of the subshell chain-linter only added a 'sed', but that changed with v2.)
> 
> > With that in mind, I would like to suggest that we should start to be very
> > careful about using subshells in our test suite.
> 
> You could disable the subshell chain-linter like this if you want test the (exit 117) goop in isolation:
> 
> --- 8< ---
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 3f95bfda60..48323e503c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -675,8 +675,7 @@ test_run_ () {
>  		trace=
>  		# 117 is magic because it is unlikely to match the exit
>  		# code of other programs
> -		if $(printf '%s\n' "$1" | sed -f "$GIT_BUILD_DIR/t/chainlint.sed" | grep -q '?![A-Z][A-Z]*?!') ||
> -			test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
> +		if test "OK-117" != "$(test_eval_ "(exit 117) && $1${LF}${LF}echo OK-\$?" 3>&1)"
>  		then
>  			error "bug in the test script: broken &&-chain or run-away HERE-DOC: $1"
>  		fi
> --- 8< ---

You're right! This is actually responsible for about five of those seven
seconds. The subshell still hurts a little, as it means that every single
of the almost 20,000 test cases we have gets slowed down by ~0.03s, which
amounts to almost 10 minutes.

This is "only" for the Windows phase of our Continuous Testing, of course.
Yet I think we can do better than this.

How difficult/involved, do you think, would it be to add a t/helper/
command for chain linting?

Ciao,
Dscho
