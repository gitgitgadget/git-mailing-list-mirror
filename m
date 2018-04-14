Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC871F404
	for <e@80x24.org>; Sat, 14 Apr 2018 12:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750936AbeDNMat (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 08:30:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:36987 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeDNMas (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 08:30:48 -0400
Received: from [192.168.0.129] ([37.201.203.18]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZKF-1eyhal0I4Z-00RIRx; Sat, 14
 Apr 2018 14:30:40 +0200
Date:   Sat, 14 Apr 2018 14:30:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Guillaume Maudoux <layus.on@gmail.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] tests: fix PATH for GIT_TEST_INSTALLED tests
In-Reply-To: <20180414003338.27091-1-layus.on@gail.com>
Message-ID: <nycvar.QRO.7.76.6.1804141423530.234@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180414003338.27091-1-layus.on@gail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:G6bFvv0t5J+85006DXO8fYqa6+awK0veXKk7dPD1bAYgzGqid4p
 a//MTJGJWJSzF9jfPmFPvb81Cl0Nas4at9zfCmQpPPdiCXzEDS2ta3KYBOwYe4z/wXqHdNy
 XHmkqX8W75fTi6voxNAVLgnrir9BNSdr+aBtxANe4I6++lQ0CVC/maMlBmIZT2IfMcRVy2T
 MbVBGRYDSxORzYbe7WusQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XQXC26Uux5E=:9iprHJfmp1IVK+/cdtsfal
 XQYk198YLbcuDbIEoNLpxvQaA5yBIIpqvJff+gT9Pi1pIci1OxgADlRekNmfDrVoFuT8NGjmG
 Splxa72HtGaPtYrNAwW8oGgr8mxUKf/sN5xNwNlco+yZ8tz4oGzg0PA7nulxnYHIua/dwaTwT
 tjNZ5LrDYyMyBdvHJoMvXo+VG7f1mAPle6LCTSVv0YPHuIIOCXA/Pb1hPNKGgn2k3pYLCkbfJ
 c4l5sh70LhhZVRwKHv+fniEcjJYLnkdmTcUYG2qxob9/BevAVi6Ze2arh2HjbaWfo3yo5FmlK
 3Oehy86U1gOV8EduEXu+0pO9cxBLE68V2/XNl4rzJ5kxfMJmDr5z0Ycw7w8YEZhh5voCseMoq
 eZ32RS7WmG7D4XDySpIY9Mk9y6zpnttZGdvF6YnxhK4dWbvA4DP8lC6yJDDB6/kLs+aub0Q0u
 M1WM9JzBTjqjg2CmdhnpLNNLmyUudCrjI/dSGez+kW7Qblx+pflPgBJgo/37ZgtvK1ovrLbAb
 KD1SqD4rQK62PHZOf0HZO6KIFa+lGtUKRnJNdkicNfweqHmaByAKwLGpspgCc6XFLe3p17QDN
 fn8Ea15sAglagIDtAc1X28+p29uU9fRAkcF0Z7T1gyvCqxUuaErByFJFcLG2Wz1IerCfQKgvz
 zGpvwJZozXuBF7ecVI1LSka68eglUrN+6IAmEPzpVkKJl6hCNSDp/NdoiEydTtT0F8Sy9JcVH
 FDi2E0J/eHgKP1kADsxDwwu5uNS1gi7mzbbsMCNuNpUU7HOzAKUWEixh6KGMKzDluotqywnh1
 aD5wefj7YLzuJuAHBWDEW2vHO3EpzaXMEzvN8z1kCSrHqBSXKY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Guillaume,

On Sat, 14 Apr 2018, Guillaume Maudoux wrote:

> From: Guillaume Maudoux <layus.on@gmail.com>
> 
> When running tests on an existing git installation with
> GIT_TEST_INSTALLED (as described in t/README), the test helpers are
> missing in the PATH.
> 
> This fixes the test suite in a way that allows all the tests to pass.
> 
> Signed-off-by: Guillaume Maudoux <layus.on@gmail.com>
> ---
> 
> This is more a bug report than a real patch. The issue is described
> above and this patch does solve it. I however think that someone with
> more knowledge should refactor all that chunck of code that was last
> changed in 2010.
> 
> In particular, it seems that the GIT_TEST_INSTALLED path does not use
> bin-wrappers at all. This may imply that --with-dashes also breaks
> tests.
> 
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git t/test-lib.sh t/test-lib.sh
> index 7740d511d..0d51261f7 100644
> --- t/test-lib.sh
> +++ t/test-lib.sh
> @@ -923,7 +923,7 @@ elif test -n "$GIT_TEST_INSTALLED"
>  then
>  	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
>  	error "Cannot run git from $GIT_TEST_INSTALLED."
> -	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
> +	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$GIT_BUILD_DIR:$PATH
>  	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
>  else # normal case, use ../bin-wrappers only unless $with_dashes:
>  	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"

This is essentially identical to what we have in

http://github.com/git-for-windows/git/commit/e408b7517d

So: ACK.

You might also want to go a bit further and let the test suite run with
GIT_TEST_INSTALLED when Git has not actually be built, but only the test
helpers. I started something along those lines here:

http://github.com/git-for-windows/git/commit/a80f047abc5

I always meant to come back to polish those patches and submit them to the
Git mailing list, so: thank you for getting the ball rolling.

FWIW my use case is that I want to test a "MinGit" package, i.e. a subset
of Git for Windows intended to cater to third-party applications requiring
Git functionality (but not requiring any interactive parts of it).

What is your use case?

Ciao,
Johannes
