Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66831F453
	for <e@80x24.org>; Tue, 22 Jan 2019 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfAVOfu (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:35:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:38603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbfAVOfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:35:50 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMT1y-1gqugx20kA-008ICP; Tue, 22
 Jan 2019 15:35:37 +0100
Date:   Tue, 22 Jan 2019 15:35:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org, asottile@umich.edu, benpeart@microsoft.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v2 2/2] checkout: fix regression in checkout -b on intitial
 checkout
In-Reply-To: <20190121195008.8700-3-peartben@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901221529210.41@tvgsbejvaqbjf.bet>
References: <20190118185558.17688-1-peartben@gmail.com> <20190121195008.8700-1-peartben@gmail.com> <20190121195008.8700-3-peartben@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Dt5hJ1YaYe7jIb4jzdVDnIQlnrXtW5j0NJu1TuWtYzTMcKLXuNu
 mNhuA6ntE7nCRtUSvICs7yjD7cXVpeTj2ri8zIda9JIveZZG63Z60F6LxT9lpUqRZtV1dcb
 tQJ0Lllzj4W82WGeIn7Iwn0u3Xrss258X8yBhJ0xqwAWhwwR6nCmU0tfMbIRawHK8NGoJAj
 VLz1R3Dd3pZw9/h4ERcKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mvBMTc5M37k=:ihBpXcT+tYt7DHhAAE/K1C
 ONW3MgZ9qzTE/TLaeM9x3T6Y483sIckLkaQb8lDpvXCo/uF4fjXQcgAlODBphnSUMip5Nn3jh
 2dFKFYe6ttd+rCy0X8W+CSzLUmqozp/DPpH8hTFivItlLBIA6jJAItJi7+qf318hT6CCukSp9
 OVCTwhM8HDLN+ifFujtR/6YluPoCcsj4cdwHkThxCAjY5KxKJESZ24JZ93OEqqtJbkl2nQ4XU
 ow46kbG8h3dER4nFgIkqVlsjfeQGb0SIPOKM1Vc4HBImCSxcFnr4daVMZlwhZWL6yrz76yO0x
 gn4Jx2dh9/Nsrs9F/05bmTdykKbW5JJ2cB8Zbw28wPFfgOgcMAPk29OvHug3w7UnZebjY7V44
 Zy3NvBCGrXllplwFCAYRRXJxvJ/AAoR5axU7vnjVsheUgheJQs+p1KhJguCwMdyHVRAYL2N9x
 8vGK9AdWem7qmxqvLExWjfpcXuZoQeVWti+vYIwtR+BjfWA37Ys1AnlOHDYRUgKiI6tYr36wV
 2qWvY7aFm/h5Jg1T51ebFRicupD/Tb4cPyeAw6rIF+43pctERW64jEwnL3Ic4azEfTcWJyM+Q
 NeY+VTkEtYfQeUwR0aqiYS4Uat5krCCxkWbLv9JKJeljToQJJbN2WvDv4/OWLKNyuDtiL01s5
 1ePhLiSzkTKnClKOPgoFskDjc/NM+i/XyE1BMCbsD7NNbj6Z3Ax9UmDHRTfrgZPOnmO5pnrcr
 wTrSEZdBQzfRxtq66mS4aBO2ErUE1jE5FrIrJl3BYBkGxjasrsRm7zANaLS5d3KXR1JMjwjCE
 uaBcV8E0M02RD0INQpHEWsAHXWbVvbI7FScs1WBq1MD82NFn3QxOGXVmN0QBsVvREFbHaA8hB
 U0pDXvu2xipyVqnIkkLEMMD7EbdmA3kSYgVJXFb9DNirrDvrBO+hNJMcbye+JXNyqSuD3g/zG
 62IayKh4rhw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 21 Jan 2019, Ben Peart wrote:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 6fadf412e8..9c6e94319e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -592,6 +592,13 @@ static int skip_merge_working_tree(const struct checkout_opts *opts,
>  	 * Remaining variables are not checkout options but used to track state
>  	 */
>  
> +	 /*
> +	  * Do the merge if this is the initial checkout
> +	  *
> +	  */
> +	if (!file_exists(get_index_file()))

We had a little internal discussion whether to use `access()` or
`file_exists()`, and I was pretty strongly in favor of `file_exists()`
because it says what we care about.

And when I looked, I found quite a few callers to `access()` that look
like they simply want to test whether a file exists.

I also looked at the implementation of `file_exists()` and found that it
uses `lstat()`. Peff, you introduced this (using `stat()`) in c91f0d92efb3
(git-commit.sh: convert run_status to a C builtin, 2006-09-08), could you
enlighten me why you chose `stat()` over `access()` (the latter seems more
light-weight to me)? Also, Junio, you changed it to use `lstat()` in
a50f9fc5feb0 (file_exists(): dangling symlinks do exist, 2007-11-18), do
you think we can/should use `access()` instead?

Thanks,
Dscho

> +		return 0;
> +
>  	return 1;
>  }
>  
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 6da2d4e68f..c5014ad9a6 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -198,7 +198,7 @@ test_expect_success 'checkout -B to the current branch works' '
>  	test_dirty_mergeable
>  '
>  
> -test_expect_failure 'checkout -b after clone --no-checkout does a checkout of HEAD' '
> +test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '
>  	git init src &&
>  	test_commit -C src a &&
>  	rev="$(git -C src rev-parse HEAD)" &&
> -- 
> 2.19.1.gvfs.1.16.g9d1374d
> 
> 
