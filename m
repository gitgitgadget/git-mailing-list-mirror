Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F9AE1F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 12:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbeKOWpI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 17:45:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:53051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbeKOWpI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 17:45:08 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhB9P-1fiyc00RYF-00oXZh; Thu, 15
 Nov 2018 13:37:23 +0100
Date:   Thu, 15 Nov 2018 13:37:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
cc:     git@vger.kernel.org, slawica92@hotmail.com
Subject: Re: [PATCH v2 1/2] [Outreachy] t3903-stash: test without configured
 user.name and user.email
In-Reply-To: <20181114222524.2624-1-slawica92@hotmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811151336330.41@tvgsbejvaqbjf.bet>
References: <20181114221218.3112-1-slawica92@hotmail.com> <20181114222524.2624-1-slawica92@hotmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4IR+c1EbfC99B4z4lIgl6fazNQTv8qsQuW+2GilZYO2wVd9hXli
 zp6aortT8Ei/FhTZYhA3piejWbUUOhGvfANybL7IVI4mHX8EBQ7/VWaQi1Pqz7mWNDJuB/I
 0nXqWkwbh8Q0veL/JXijZP9jN1Mdo1fgZieUHoPsquMFTISdRYxX37BDPQyIDdNYDJPh99A
 EsfeDuNuPIbC4aQJpB8zw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:macu/Vnz2xQ=:kh/ufbVhL/xM5o6WrE9fcR
 5S+bVi/NMWMx19HoBq+z+pXz/KkGbLAtqoQiW9onQ8KnkYl6dIqsIY1A/20D4oqk4qBy8WjTZ
 nvkCm5KlgGg7M6PVe+yx+ann7+bn3TJ8VAG5g8ehXangQ5masWwchpQUcqg6fYxtxMRQoLsJY
 +IeCEk3zpo3+BgoSkYSnnwPWbVWs4LFjBcKcg7FQVtIEC4UEbSEC89TZMgBtj4NQgL4rkpbB0
 ONNbUqb2UlpwXJqbfLBKFw/MfU2m7qG8ouDjfx75ULHCJu+okRKlhZ9iRj7oH81zkOMpnvmHA
 Z8wI0qGT1TN0jKiOK3akkFBeGyDvZi1V1SkoOTLUQi5IpwY5Mb9MG810JUdRSNQZo2IVPtZIx
 qzAx7C3j9r3OxnBo0rGwpkPwtoP/Z9TnqX8SXkNQa//Pot0il92lPyhc7AjpMW5TAGUi5EXs/
 Lgk7nY8OY4xxw7MpC0YNJQLPI0dFdk4zxGNl9Y/CbPVsEHcV6dC6EeyaNKKVKyUEYlEKt+/ev
 0IIBbk2dPaeaSdsJ3fBDnsYXgUkKMfw4xjmsjY2n8JWnaEY1WS7plf4EqUwpumlrYBS5eZ4sD
 NMPVfhgAzfxayO6UAkM9HU3/HiTFWiKNhf6i3XZdLX1Ts2UhxcoTtTKlqWxgpPh+ghnTvanCp
 rIponopwm4jY9IEuU/kHnt4QSUUGnLTVlyLbU6VkOYfc/9KmCxJwWVvJN1KShr/QO8C3uzU4I
 CkWYMRn9vUtsNPmclPPZ5Ar9p0lQhngKB0KAJn1X856EqSkasb7Z7ChECYZmWiJI75kW5V75r
 J1A+vw/fR0Ql1l7lmKeQZPOFA2X+3css8Y3RThO/gk/0/7vjc6B8MZgxGbhP2jB0jeUgt42jr
 zzplUREbji31Z7QfPBmZAZ3XVzxXcGOL310tA2eoI0lJkgoDtXlOzqmxUCaiJJ/XMMDTLQ/Q2
 OrFiHWeVYJA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Slavica,

this looks very good to me. Just one grammar thing:

On Wed, 14 Nov 2018, Slavica Djukic wrote:

> Add test to document that stash fails if user.name and user.email
> are not configured.
> In the later commit, test will be updated to expect success.

In a later commit [...]

Otherwise, I would be totally fine with this version being merged.

Ciao,
Johannes

> 
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  t/t3903-stash.sh | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index cd216655b..bab8bec67 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1096,4 +1096,27 @@ test_expect_success 'stash -- <subdir> works with binary files' '
>  	test_path_is_file subdir/untracked
>  '
>  
> +test_expect_failure 'stash works when user.name and user.email are not set' '
> +	git reset &&
> +	git var GIT_COMMITTER_IDENT >expected &&
> +	>1 &&
> +	git add 1 &&
> +	git stash &&
> +	git var GIT_COMMITTER_IDENT >actual &&
> +	test_cmp expected actual &&
> +	>2 &&
> +	git add 2 &&
> +	test_config user.useconfigonly true &&
> +	test_config stash.usebuiltin true &&
> +	(
> +		sane_unset GIT_AUTHOR_NAME &&
> +		sane_unset GIT_AUTHOR_EMAIL &&
> +		sane_unset GIT_COMMITTER_NAME &&
> +		sane_unset GIT_COMMITTER_EMAIL &&
> +		test_unconfig user.email &&
> +		test_unconfig user.name &&
> +		git stash
> +	)
> +'
> +
>  test_done
> -- 
> 2.19.1.1052.gd166e6afe
> 
> 
