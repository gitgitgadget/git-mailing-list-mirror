Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396CB1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 09:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeJ3St7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 14:49:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:41335 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbeJ3St6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 14:49:58 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1gQk9o27bW-009NKi; Tue, 30
 Oct 2018 10:56:58 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCfcc-1gQk9o27bW-009NKi; Tue, 30
 Oct 2018 10:56:58 +0100
Date:   Tue, 30 Oct 2018 10:57:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Antonio Ospite <ao2@ao2.it>
cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v7 09/10] submodule: support reading .gitmodules when
 it's not in the working tree
In-Reply-To: <20181025161813.17252-10-ao2@ao2.it>
Message-ID: <nycvar.QRO.7.76.6.1810301053540.4546@tvgsbejvaqbjf.bet>
References: <20181025161813.17252-1-ao2@ao2.it> <20181025161813.17252-10-ao2@ao2.it>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ugPLgvCAYXm6gs9Qr6JdzW7vu4g2cnv97ZhZ9uxweWpZdHIDgsq
 H6BjxT8Nxg9ztwJmZKSzDytnRmYlYfj5BhyX0gcRrDh2fHrx1BgY8RntLSX0zITzK+bOGto
 hBj+rIJlkbLZfNj1Lws3gg8YCopA7vjkMmChrG2nN3mFVE6RjhfTDus633e9YwRuS5j6uk0
 WB4UDOvxythVOh/zR1tFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mE9QbLCgbRM=:cZBhB2eYaULbSMqlhhtOoP
 T3t6LLjRpTOAcRGsjr+3PJIgg6XjUPQz9YV/KLFrFmOLvy2460Xtj6peMtBBcUvF3HPXbaeyR
 fBKtRZ7hGBZ0Ny+SP/7qc04mvOQSVACsv72yDyMjbvGXPY7Z/hhjcub3n0DjE8F+IkLCHON9L
 qk0l8Ig8a7wPxJxAGc4ktzTDuddW+RsYAsUIYk+xxjdOlvL2N7ASSNR3cPBi5StYbhiadk95P
 iKT1IIVny44W+gwPf+o+usD/nTpIaeDm8ZQReMC4FQBzIflcLVQoua7l/651Sguj455+sVArL
 r2EG3BtpiAus9SZHbWpnYZv+iwkFoWHTfQV/HB7ZWakPhXDMploQWTDMDkjUEyojLRq2596a4
 5fjeO3WsBkj5okLeIkfE0cxvfhOwflrNYWZJLFAoxsNWdN3t28v9gQc/8DrQr4k8QOG+rBDse
 fszj11BRgc2JH4slgn3tcJ5v7nYi4t9Fxv5Oo95GY6DWHS83fiE2QG8jDnJ82RHKQwrqMEqVc
 Bcp5pzdevFMP2Pr/HS511SHTkkTXh4jFUGZtqz8rY4LmsEOd6vwEJ6yMRltu2MZoQOfRpWImR
 4Cec2JL3JuMjUgLBKNOsxQnXQlDft4iBIF5Ta86MnHkievHCgSt9JBxCfZAqkfbRTBO9WogRu
 43sP7pe1hm/uoaMc0JBmPeVRgPi0fwTsAbTMRvYHFxlzK0ar24jq1o7Yh+em6RNYOy+cYg96r
 vtjbOWdN1OM/nEPfE9cg40jzF2pYJS3wuYtjf/7YTH5bHQNe/x1A9MzgcY/+PU+rKTqtPLpPk
 yhzYF0WtLcyw8bzBX1UjZDrdg0fguNAMKO9vAoPZ6rU6y45Alk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

On Thu, 25 Oct 2018, Antonio Ospite wrote:

> diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
> new file mode 100755
> index 0000000000..21a86b89c6
> --- /dev/null
> +++ b/t/t7418-submodule-sparse-gitmodules.sh
> @@ -0,0 +1,122 @@
> +#!/bin/sh
> +#
> +# Copyright (C) 2018  Antonio Ospite <ao2@ao2.it>
> +#
> +
> +test_description='Test reading/writing .gitmodules when not in the working tree
> +
> +This test verifies that, when .gitmodules is in the current branch but is not
> +in the working tree reading from it still works but writing to it does not.
> +
> +The test setup uses a sparse checkout, however the same scenario can be set up
> +also by committing .gitmodules and then just removing it from the filesystem.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'sparse checkout setup which hides .gitmodules' '
> +	git init upstream &&
> +	git init submodule &&
> +	(cd submodule &&
> +		echo file >file &&
> +		git add file &&
> +		test_tick &&
> +		git commit -m "Add file"
> +	) &&
> +	(cd upstream &&
> +		git submodule add ../submodule &&
> +		test_tick &&
> +		git commit -m "Add submodule"
> +	) &&
> +	git clone upstream super &&
> +	(cd super &&
> +		cat >.git/info/sparse-checkout <<-\EOF &&
> +		/*
> +		!/.gitmodules
> +		EOF
> +		git config core.sparsecheckout true &&
> +		git read-tree -m -u HEAD &&
> +		test_path_is_missing .gitmodules
> +	)
> +'
> +
> +test_expect_success 'reading gitmodules config file when it is not checked out' '
> +	echo "../submodule" >expect &&
> +	git -C super submodule--helper config submodule.submodule.url >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'not writing gitmodules config file when it is not checked out' '
> +	test_must_fail git -C super submodule--helper config submodule.submodule.url newurl &&
> +	test_path_is_missing super/.gitmodules
> +'
> +
> +test_expect_success 'initialising submodule when the gitmodules config is not checked out' '
> +	test_must_fail git -C super config submodule.submodule.url &&
> +	git -C super submodule init &&
> +	git -C super config submodule.submodule.url >actual &&
> +	echo "$PWD/submodule" >expect &&

Would you mind squashing this fixup in?

-- snip --
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
index 21a86b89c6cb..3f7f27188313 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -55,7 +55,7 @@ test_expect_success 'initialising submodule when the gitmodules config is not ch
 	test_must_fail git -C super config submodule.submodule.url &&
 	git -C super submodule init &&
 	git -C super config submodule.submodule.url >actual &&
-	echo "$PWD/submodule" >expect &&
+	echo "$(pwd)/submodule" >expect &&
 	test_cmp expect actual
 '
 
-- snap --

On Windows, `$PWD` and `$(pwd)` are *not* synonymous. The former
reflects the "Unix path" which is understood by the Bash script (and
only by the Bash script, *not* by `git.exe`!) while the latter refers to
the actual Windows path.

Without this fix, your new test case will fail on Windows all the time,
see e.g.
https://git-for-windows.visualstudio.com/git/_build/results?buildId=22913&view=logs

Thanks,
Johannes


> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'updating submodule when the gitmodules config is not checked out' '
> +	test_path_is_missing super/submodule/file &&
> +	git -C super submodule update &&
> +	test_cmp submodule/file super/submodule/file
> +'
> +
> +ORIG_SUBMODULE=$(git -C submodule rev-parse HEAD)
> +ORIG_UPSTREAM=$(git -C upstream rev-parse HEAD)
> +ORIG_SUPER=$(git -C super rev-parse HEAD)
> +
> +test_expect_success 're-updating submodule when the gitmodules config is not checked out' '
> +	test_when_finished "git -C submodule reset --hard $ORIG_SUBMODULE;
> +			    git -C upstream reset --hard $ORIG_UPSTREAM;
> +			    git -C super reset --hard $ORIG_SUPER;
> +			    git -C upstream submodule update --remote;
> +			    git -C super pull;
> +			    git -C super submodule update --remote" &&
> +	(cd submodule &&
> +		echo file2 >file2 &&
> +		git add file2 &&
> +		test_tick &&
> +		git commit -m "Add file2 to submodule"
> +	) &&
> +	(cd upstream &&
> +		git submodule update --remote &&
> +		git add submodule &&
> +		test_tick &&
> +		git commit -m "Update submodule"
> +	) &&
> +	git -C super pull &&
> +	# The --for-status options reads the gitmodules config
> +	git -C super submodule summary --for-status >actual &&
> +	rev1=$(git -C submodule rev-parse --short HEAD) &&
> +	rev2=$(git -C submodule rev-parse --short HEAD^) &&
> +	cat >expect <<-EOF &&
> +	* submodule ${rev1}...${rev2} (1):
> +	  < Add file2 to submodule
> +
> +	EOF
> +	test_cmp expect actual &&
> +	# Test that the update actually succeeds
> +	test_path_is_missing super/submodule/file2 &&
> +	git -C super submodule update &&
> +	test_cmp submodule/file2 super/submodule/file2 &&
> +	git -C super status --short >output &&
> +	test_must_be_empty output
> +'
> +
> +test_expect_success 'not adding submodules when the gitmodules config is not checked out' '
> +	git clone submodule new_submodule &&
> +	test_must_fail git -C super submodule add ../new_submodule &&
> +	test_path_is_missing .gitmodules
> +'
> +
> +# This test checks that the previous "git submodule add" did not leave the
> +# repository in a spurious state when it failed.
> +test_expect_success 'init submodule still works even after the previous add failed' '
> +	git -C super submodule init
> +'
> +
> +test_done
