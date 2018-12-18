Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55011F405
	for <e@80x24.org>; Tue, 18 Dec 2018 11:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeLRL6F (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 06:58:05 -0500
Received: from mout.gmx.net ([212.227.15.15]:50747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbeLRL6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 06:58:04 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaZrd-1goq7H2biT-00KCF2; Tue, 18
 Dec 2018 12:58:02 +0100
Date:   Tue, 18 Dec 2018 12:58:02 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] stripspace: allow -s/-c outside git repository
In-Reply-To: <20181217165957.GA60293@google.com>
Message-ID: <nycvar.QRO.7.76.6.1812181256290.43@tvgsbejvaqbjf.bet>
References: <20181217165957.GA60293@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:sD138FkXYci/gecr5hy8SqXklTWVGZDu2Rx0kTrctdz+IsTnsoo
 xTxBpyXokaaazEmGkL2QTpBQwSchUmyH56ahRwCL7DXtuGZqZfvBXKZSn3y4wuUCXQUJSfw
 Q0/CrwIjBPeJJKFyG2Ks4eo1uPAjDlYhmjQVp4R+3biaElTzjmAuXqv8Pn3Yf5/vG8oe4u7
 yiOLN5IAPpUmockCM09Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dT0QDvHOIgE=:33py+C6egDgsOwZOaV2F2k
 BFA3+bBISf7poTmhGOVp4ZQS/xf2et8XeV58pGsdwK6nBpV4WtORDWlbRHeS+3VcDe1/JQhib
 L0bWn7k1GEoBB+gzw5oFSD1bG/14qzhYjqACV+dzak5euJXqzL8YAEDdxYXsQ3dPYujS+Ajik
 NLj8k0NIiJVveB2oOlMi6QTij2UsSIBN6bHddnVknKf5gHwIkOGH6hNFmkvrpUNzj7ousSqkh
 EZRV3hg6CVfAXMMZonwG0GK+rcWFHeaKF1LrnOwZmTybm9LiFVm0yOZXu0v00L4uhir668JGo
 JZdQ+B1bxONby2EqvUl5KH/yCTiVht3OUejgs7p4g8obKrp0yprcGNPEni9YQDe+EJxfxvvDK
 jSEI+AxYKeP9w+z/x/mgdaslEb9l/4AmxrF3RZJrMjGoP33s/Z/RFsisqjs28fNO0Oe6Ieo/D
 PiQYOxptNcpQ3s5MUG0bEi/rMMQt9fd9h/GcR8E5VgHq+rxSS7hBovoo4HYMtt+rSbOejwaET
 pSmh9oo8iSeoC/QvAZjMObdTNOGzRpSBKTwX4VK/HDf4MDpcdLTjpTyJojFt6NQBYk1nINMKS
 GVKbLsywercbF8n81hQEI3AWNDWM0niYNyg4+mBn46hSNzTs1MyoJ/qQKy/Nf8qP9IZrL/3Wo
 G9kRxQ6t2NteyCM3ZeMTD1KKePEyHhulHnMJjjadfQmCd419b5EMz9MnxnZIWVaWJnjDEWpbT
 81so38eMuTR5eHwAlNdI5wl8phl+EUigMACuv+yQ5k+zMzBi7WUPVs6+MtFOPNUgdbi5pbizx
 8PWW7FLySZRgNH91kBwZjHriAmgUe7woAvAEOQKO8JyRgNPrBxxoJW+ZRQA7k0HhrASQTmrpi
 pWmfg07lKuZCGyYJktF+DZL1tRLZuJ5JVP4yOgNhbmp1rySc5YD9hfjdbc3owxGoQ402fsM/B
 qgji9cKvkGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 17 Dec 2018, Jonathan Nieder wrote:

> v2.11.0-rc3~3^2~1 (stripspace: respect repository config, 2016-11-21)
> improved stripspace --strip-comments / --comentlines by teaching them
> to read repository config, but it went a little too far: when running
> stripspace outside any repository, the result is
> 
> 	$ git stripspace --strip-comments <test-input
> 	fatal: not a git repository (or any parent up to mount point /tmp)
> 
> That makes experimenting with the stripspace command unnecessarily
> fussy.  Fix it by discovering the git directory gently, as intended
> all along.
> 
> Reported-by: Han-Wen Nienhuys <hanwen@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

ACK!

>  builtin/stripspace.c  |  3 ++-
>  t/t0030-stripspace.sh | 12 +++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index bdf0328869..be33eb83c1 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -30,6 +30,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf buf = STRBUF_INIT;
>  	enum stripspace_mode mode = STRIP_DEFAULT;
> +	int nongit;
>  
>  	const struct option options[] = {
>  		OPT_CMDMODE('s', "strip-comments", &mode,
> @@ -46,7 +47,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  		usage_with_options(stripspace_usage, options);
>  
>  	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
> -		setup_git_directory_gently(NULL);
> +		setup_git_directory_gently(&nongit);

What a fool I was to believe that _gently() was always gentle...

>  		git_config(git_default_config, NULL);
>  	}
>  
> diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
> index 5ce47e8af5..0c24a0f9a3 100755
> --- a/t/t0030-stripspace.sh
> +++ b/t/t0030-stripspace.sh
> @@ -430,9 +430,15 @@ test_expect_success '-c with changed comment char' '
>  test_expect_success '-c with comment char defined in .git/config' '
>  	test_config core.commentchar = &&
>  	printf "= foo\n" >expect &&
> -	printf "foo" | (
> -		mkdir sub && cd sub && git stripspace -c
> -	) >actual &&
> +	rm -fr sub &&
> +	mkdir sub &&
> +	printf "foo" | git -C sub stripspace -c >actual &&
> +	test_cmp expect actual
> +'

Sneaky. But I like it.

Thanks,
Dscho

> +
> +test_expect_success '-c outside git repository' '
> +	printf "# foo\n" >expect &&
> +	printf "foo" | nongit git stripspace -c >actual &&
>  	test_cmp expect actual
>  '
>  
> -- 
> 2.20.0.405.gbc1bbc6f85
> 
> 
