Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B949B1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 21:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbeKKGv7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 01:51:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:60999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbeKKGv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 01:51:58 -0500
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MMGWH-1gQpEW1jIL-0085I2; Sat, 10
 Nov 2018 22:05:33 +0100
Date:   Sat, 10 Nov 2018 22:05:42 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] p3400: replace calls to `git checkout -b' by `git checkout
 -B'
In-Reply-To: <20181109211923.6425-1-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811102205070.45@tvgsbejvaqbjf.bet>
References: <20181109211923.6425-1-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oOIPrp7goJAzfDMbwqFqA8b9kmnxTsczN9eQFA/9oX5EVV/EOZ+
 10JFfcMBoJuG8wuiW3gWqU3fTCS0nZHzZO4JR7VOxq1HOiQHnoBz+V8ObGh69WRJvoC9t8Z
 Fa3TThCoYcYxMoCt59J7GwQ9GkCebhPeZNXcQkAhwgiRvahD/RznWvIiWLZSNNRUYCMYyum
 CCoKreOUSJsdO3qOz5qLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DJDZ6vx5lLI=:qYGP9i1eLIr10eapG7m1zK
 0/L1Xz8fqBhCAkMm4fegthIhf1dqSB1JWSPSvO0APK/sXrYP07ixRvEe7lGi58vIv6Ppnbiwd
 5B7+Y2Po1Aqk2v5bUlc6O83ffKgp7XtMx6UHxIiQRmM/v47KbuMk+N/WndpQlDZ0slguDSfZC
 ui+s51jzQrv+JG1Gz3RBsTUVNJVoQ7XSbbviR26dPjisnOc21YGUT5kHIQnXnyIhe029QIWOV
 yqbqtoygfJAlZJ1DixmBnAkTaufgYl57VNjb+bQFE9bSH6CFAAp2U5LLAyEK7IhY+sq86z9dm
 7u21G+fjQmFE/pLgUDuttSQ7++LOw9a8CDehyKID8Ef+35J5Ye6W+POSmaVAnDyeYIXCev0QE
 7BsbBVqx//oiL9mSPh15iFsSvIiYzfJbMQPNlL50/q5MRj9/Z696wfqW3P7NCvkhQJKUnhAEQ
 Eo6+C3ApnYUk5PXGeTBsYATHT7Q9jqTfRqjj0FsSJC/jrhnM8boqzgfuzn+QH3W7koqVCnTI0
 AWRbirXAdw4a9DrKmA7uibfvr3KNJrTUp68+fR/idnLcSGVOuqzuROC28y+BquNEnGNKfCWr0
 +9/uZEnxjrHkkxvlqONPkqGYjyOMq0gV8di/MIrrPc6W3yNZoeTctdAVoHba1Asv1+0Zge5oz
 ckjT0PzdgsU+jzJ4NwrOFiVI0Lr7uYUjwpPG6/YS35rAiPOAwCwVjdkN0SxHiGTMkS0upcGwl
 ADHkQ3BjPlb7u7aXs5l8cWyIejAC/wazZ2EWhTDjcTheciwmqCN/v3G//On63lVpLTvVzhXC3
 Wt1a/+6y/mbxvtHWjJyFyOtOUtGi8Nfbn36A8vCFICzfxChAkM6YTt2fqey+wF2XnSnuAiRNU
 cINfTtZjZBZoGV3wdtWVZJpAYdaZvg+nvGJAQoycjpOQdVl+HAoL65qtI+RFrocoM+Ffk3tk1
 EWUM7L8RXkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Fri, 9 Nov 2018, Alban Gruin wrote:

> p3400 makes a copy of the current repository to test git-rebase
> performance, and creates new branches in the copy with `git checkout
> -b'.  If the original repository has branches with the same name as the
> script is trying to create, this operation will fail.
> 
> This replaces these calls by `git checkout -B' to force the creation and
> update of these branches.

Both the explanation and the patch make sense to me.

Thanks,
Dscho

> 
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  t/perf/p3400-rebase.sh | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/t/perf/p3400-rebase.sh b/t/perf/p3400-rebase.sh
> index ce271ca4c1..d202aaed06 100755
> --- a/t/perf/p3400-rebase.sh
> +++ b/t/perf/p3400-rebase.sh
> @@ -6,9 +6,9 @@ test_description='Tests rebase performance'
>  test_perf_default_repo
>  
>  test_expect_success 'setup rebasing on top of a lot of changes' '
> -	git checkout -f -b base &&
> -	git checkout -b to-rebase &&
> -	git checkout -b upstream &&
> +	git checkout -f -B base &&
> +	git checkout -B to-rebase &&
> +	git checkout -B upstream &&
>  	for i in $(seq 100)
>  	do
>  		# simulate huge diffs
> @@ -35,8 +35,8 @@ test_perf 'rebase on top of a lot of unrelated changes' '
>  
>  test_expect_success 'setup rebasing many changes without split-index' '
>  	git config core.splitIndex false &&
> -	git checkout -b upstream2 to-rebase &&
> -	git checkout -b to-rebase2 upstream
> +	git checkout -B upstream2 to-rebase &&
> +	git checkout -B to-rebase2 upstream
>  '
>  
>  test_perf 'rebase a lot of unrelated changes without split-index' '
> -- 
> 2.19.1
> 
> 
