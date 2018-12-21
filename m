Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827801F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbeLUQG6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:06:58 -0500
Received: from mout.gmx.net ([212.227.15.19]:45441 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728691AbeLUQG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:06:58 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4R6-1gjD0q16Ku-008udU; Fri, 21
 Dec 2018 17:06:56 +0100
Date:   Fri, 21 Dec 2018 17:06:40 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Orgad Shaneh <orgads@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t5403: Refactor
In-Reply-To: <20181220214823.21378-1-orgads@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812211659220.41@tvgsbejvaqbjf.bet>
References: <20181220214823.21378-1-orgads@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:AyFadkiuWv8ZEA9o1YMNKltVdP7ywJhDloOyL66L+DTWY8f83ou
 jp2UPRX8ezqA8BoGaJmP49AVg3yMYWj580ZmpbyV4jAQN1/dSfuM0sdp8nDJmK+haJu8HNN
 eZzVNkw7kCgwJsr9T0f80gMWaLagKIco2Vrf2k+f6ouWWYnDnzA4apWvPOnueISFWteoepC
 8z/v1YlnRI/xjSlybQH0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QOWvTcxMvcI=:H5+1p4yepTVLmZjFiLW1ZZ
 wvdYLd2Gdtahn/hWyUNXBi32E6B6ZeNOawfxHAYSYt0ez3E3xC41z9GuKr4Am6oFYPmnTy35R
 cKyhWBJQrHBE5t3kxGcJiiFoM9R1kwsUWqPky3L7YScrMsiHMt95Dbia0Pi3ovAtCdDnpZq4Y
 G/7p6UArvjgAeK3tUycUllBpTcwQfel0cfkhPeBSX/f1ofYTyOx0ogBp8c4zwhOsN1YKKdcmf
 T1kJDV0slhf3UYGGInaPtyOYJ+1NpqZyLW3BE+o/qe2cBXIuCT42lHKjvouinP6aBkvo1OVPb
 PS1tIYOoUhPLRrK0i+5QPU8Cvad1EiE0XY/jjzHcthsFQOiozRF5ULE+NUODqCjSLTuNlLaOX
 6g8gCF+6mETjiEyKPAG0Ya7HM5NcVlI/JS95WP0JKVNVcMNayN0lcwO8m9D8atJMTm0r7V2zG
 QCW3HmOAv0ket8I4i+UrKtK0ntG5EhwvKSNIHz3VOX5GeB2L3Ar3UzH3iRTiJuubCbW24HkJo
 T9hhf5RbmodVnu3UAC0+QsW1oKOxhnKRgQIdrU29qOIGGPXSM4JZCkGEjUm1Jf9elTUobyTNq
 62E7aIGjWfE9+AK0r1HBZy9uMuDBT46lUoYh8pTpmHq3pNSOhB9V1xyxSYYyI+gB88Xl9ybGp
 wjir1DpQDMIYL2510IvbFcYzbHNnQckQHjFEnLb96Rie/9LuAi+Y/RexQohHFrE5aO7GpuK8S
 oYiPI4UOqPcYSCltP6AKcTomuK9ai1wpH6mgurItVfZRNQ+t/Ka6+qgdoCScUZ2Y3nvPByNxC
 54dzdg1E704VI66pjUQwut5kd7ekXzAUAgs63b+eoqptFZkUxUhIUNNuzZdZKqPa8TWIW2OU4
 8duvU6z4NL9n6xVSmkRnP73jKVHHx3q6Lw7kTykKx2KaFEDVf/0xa889Zy2n0XharBBHl/SEF
 5dVVdu1pfTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Orgad,

On Thu, 20 Dec 2018, orgads@gmail.com wrote:

> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index fc898c9eac..7e941537f9 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -7,67 +7,48 @@ test_description='Test the post-checkout hook.'
>  . ./test-lib.sh
>  
>  test_expect_success setup '
> -	echo Data for commit0. >a &&
> -	echo Data for commit0. >b &&
> -	git update-index --add a &&
> -	git update-index --add b &&
> -	tree0=$(git write-tree) &&
> -	commit0=$(echo setup | git commit-tree $tree0) &&
> -	git update-ref refs/heads/master $commit0 &&
> -	git clone ./. clone1 &&
> -	git clone ./. clone2 &&
> -	GIT_DIR=clone2/.git git branch new2 &&
> -	echo Data for commit1. >clone2/b &&
> -	GIT_DIR=clone2/.git git add clone2/b &&
> -	GIT_DIR=clone2/.git git commit -m new2
> +	test_commit one &&
> +    test_commit two &&
> +    test_commit three three &&

A very nice simplification (but please use tabs to indent).

> +    mv .git/hooks-disabled .git/hooks
>  '
>  
> -for clone in 1 2; do
> -    cat >clone${clone}/.git/hooks/post-checkout <<'EOF'
> +cat >.git/hooks/post-checkout <<'EOF'
>  #!/bin/sh
> -echo $@ > $GIT_DIR/post-checkout.args
> +echo $@ > .git/post-checkout.args

While at it, you could lose the space after the redirector that we seem to
no longer prefer:

> +echo $@ >.git/post-checkout.args

And since we are already cleaning up, we could easily move use
write_script instead, *and* move it into the `setup` test case (which
makes it easier to use something like

	sh t5403-post-checkout-hook.sh --run=1,13

The rest looks good (modulo indentation issues). I would have preferred
the separate concerns to be addressed in individual commits (one commit to
replace the `awk` calls, one to avoid the clones, one to simplify by using
`test_commit`, etc), as that would have been easier to review. But others
might disagree (Junio recently made the case of smooshing separate
concerns into single commits, even squashing two of my patches into one
against my wish), so... I guess you don't have to change this.

Thank you,
Johannes

>  EOF
> -    chmod u+x clone${clone}/.git/hooks/post-checkout
> -done
> +chmod u+x .git/hooks/post-checkout
>  
>  test_expect_success 'post-checkout runs as expected ' '
> -	GIT_DIR=clone1/.git git checkout master &&
> -	test -e clone1/.git/post-checkout.args
> +	git checkout master &&
> +	test -e .git/post-checkout.args
>  '
>  
>  test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
> -	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
> -	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
> -	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
> +	read old new flag < .git/post-checkout.args &&
>  	test $old = $new && test $flag = 1
>  '
>  
>  test_expect_success 'post-checkout runs as expected ' '
> -	GIT_DIR=clone1/.git git checkout master &&
> -	test -e clone1/.git/post-checkout.args
> +	git checkout master &&
> +	test -e .git/post-checkout.args
>  '
>  
>  test_expect_success 'post-checkout args are correct with git checkout -b ' '
> -	GIT_DIR=clone1/.git git checkout -b new1 &&
> -	old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
> -	new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
> -	flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
> +	git checkout -b new1 &&
> +    read old new flag < .git/post-checkout.args &&
>  	test $old = $new && test $flag = 1
>  '
>  
>  test_expect_success 'post-checkout receives the right args with HEAD changed ' '
> -	GIT_DIR=clone2/.git git checkout new2 &&
> -	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
> -	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
> -	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
> +	git checkout two &&
> +    read old new flag < .git/post-checkout.args &&
>  	test $old != $new && test $flag = 1
>  '
>  
>  test_expect_success 'post-checkout receives the right args when not switching branches ' '
> -	GIT_DIR=clone2/.git git checkout master b &&
> -	old=$(awk "{print \$1}" clone2/.git/post-checkout.args) &&
> -	new=$(awk "{print \$2}" clone2/.git/post-checkout.args) &&
> -	flag=$(awk "{print \$3}" clone2/.git/post-checkout.args) &&
> +	git checkout master -- three &&
> +    read old new flag < .git/post-checkout.args &&
>  	test $old = $new && test $flag = 0
>  '
>  
> -- 
> 2.20.1
> 
> 
