Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F20A1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 12:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfAUMOZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 07:14:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:36961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbfAUMOZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 07:14:25 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaW7Z-1gVxQM0dNR-00K72z; Mon, 21
 Jan 2019 13:14:23 +0100
Date:   Mon, 21 Jan 2019 13:14:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 63/76] diff.c: convert -O
In-Reply-To: <20190117130615.18732-64-pclouds@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901211311320.41@tvgsbejvaqbjf.bet>
References: <20190117130615.18732-1-pclouds@gmail.com> <20190117130615.18732-64-pclouds@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1052056259-1548072863=:41"
X-Provags-ID: V03:K1:at02NG6NSLKV8DKO4WtLEPPULKuOFIt17dYuNffl3EjtkyEfLfO
 O3rE3n+w9SFgXCIoVk4Q2GmxT0J+TuD5RAV0SChaLF90eAev0bW03H7jCSk/lW3zTGVwnLF
 zqRIgq/85JLDLmZ3byVLTdvg4sT+2lwpztEMrnQ/fQUhCBN11yX6CcW0+NIZXiuMqSv7VJl
 Z3g6fmEgaD1MqIzRhb0xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OqPaKyuscg4=:/gIXIUB9DHq9gve86VYpiG
 pb4tMwT82YcdLWKG7x27hhJpnwmFa2UJ0jAGOqCZPLyYF6E893ucBBQdXgI5Q+ADAiFTb4vr+
 whXH6v7msVBhuYOoI+Ewp99pk4slTFQrGevwzQMSpDJaJPbIIERU38FE+Ji1R/BE0xnv4YBei
 b0NM92g2eCr3B0tpZoNBcDYPhThN3KI4w6MVwIHyCZsua1cRWd25iC6raSjn1jeO+CYYtUna+
 7NkYT3dSqLFpHHhE/JWTNiV0lSLTyTYRdrxIIQJSB6PAWrxisCXrcYiURJUyD4hzaO61oIw+4
 kmYnd08J81DlZq9fiGhR701joAtwfFITOEe410gC/Ce1ktpn44Ff3NMl4KCiVjK/JhsP69I8G
 k8EEk9emC+S4FhQ17p6oI4dSH34HGkRO2jz0hj4ijwVqII79mZ58OgsR4JX/fvG8rcquOYbrC
 bxwEenuM5IztrL8psjndfNkd5siUBdDAgwIW+p0MgeBlMmANQFDJKbgwFDiDeUK+L95UtsWQ+
 ep8B8bfBLugnti8ZwzK/7xF+JsCbI8GDc9R/178+/Y1sheRYgyOQvnlAmGfpwg7tgZfRjNWpi
 SxhDiA4i7iIb3bltaJ4UJWIV/RFbg3j6flFjHIQoLnM6eCKP4KR6O3Vj1etEQVAG1qZKEru8A
 Pq6GxmwaK06DOpVmX/RO1CqkHHQu9yfOu6LMZs7S+PtWkyZRhQSp8DqH9itogorYEJOgMgGt9
 FCRFVdb0wVgO4YAo1Y05CVHI0fMbjmkGZYXg4WYzLdl2p/WSjkObeQOXHxw84oFa4AxR2/kIL
 RnaDKSS5b2LEPpqKglBLmXq5qoLYx8Rrx86YMTClZrhWAD+36gIN6FNrxTKv1NtWW/XdB6x/Y
 TshQ0JToAmQ9lM7TuaOwqbfp6hhzqBPln+o+HIh4CX2KatyVpxM8AgHr4uZUFjS6L9PKPt9t4
 qGSf73uHc+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1052056259-1548072863=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Duy,

On Thu, 17 Jan 2019, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/diff.c b/diff.c
> index ae993f5551..4e004a2195 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5401,6 +5401,8 @@ static void prep_parse_options(struct diff_options *options)
>  		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
>  			  N_("treat <string> in -S as extended POSIX regular expression"),
>  			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
> +		OPT_FILENAME('O', NULL, &options->orderfile,
> +			     N_("override diff.orderFile configuration variable")),
>  		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
>  		  N_("Output to a specific file"),
>  		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
> @@ -5453,10 +5455,7 @@ int diff_opt_parse(struct diff_options *options,
>  	}
>  
>  	/* misc options */
> -	else if ((argcount = short_opt('O', av, &optarg))) {
> -		options->orderfile = prefix_filename(prefix, optarg);
> -		return argcount;
> -	} else if (skip_prefix(arg, "--find-object=", &arg))
> +	else if (skip_prefix(arg, "--find-object=", &arg))

You probably used GCC and therefore missed that this patch removes the
last user of `short_opt()`, and therefore leaves `short_opt()` unused.
Apparently Clang v9.1.0 (which is used in Azure Pipelines' macOS builds)
is smart enough to notice that, though. So please squash this in when you
send another iteration of this patch (in a hopefully smaller package than
that six-and-a-half-dozen patch series):

-- snip --
diff --git a/diff.c b/diff.c
index 381259e987a5..5e1ab7daec44 100644
--- a/diff.c
+++ b/diff.c
@@ -4692,22 +4692,6 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 }
 #endif
 
-static inline int short_opt(char opt, const char **argv,
-			    const char **optarg)
-{
-	const char *arg = argv[0];
-	if (arg[0] != '-' || arg[1] != opt)
-		return 0;
-	if (arg[2] != '\0') {
-		*optarg = arg + 2;
-		return 1;
-	}
-	if (!argv[1])
-		die("Option '%c' requires a value", opt);
-	*optarg = argv[1];
-	return 2;
-}
-
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg)
 {
-- snap --

Ciao,
Johannes

>  		return parse_objfind_opt(options, arg);
>  	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
>  		int offending = parse_diff_filter_opt(optarg, options);
> -- 
> 2.20.0.482.g66447595a7
> 
> 
> 
--8323328-1052056259-1548072863=:41--
