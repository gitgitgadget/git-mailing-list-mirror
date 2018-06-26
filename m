Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076951F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeFZWR5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:17:57 -0400
Received: from mout.gmx.net ([212.227.15.18]:37417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932883AbeFZWR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:17:56 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0y47-1gRgSf31ah-00v8du; Wed, 27
 Jun 2018 00:17:50 +0200
Date:   Wed, 27 Jun 2018 00:17:51 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, joel@teichroeb.net, gitster@pobox.com
Subject: Re: [PATCH v6 2/4] stash: convert drop and clear to builtin
In-Reply-To: <5373f422a82da2357828b8cc4a2b84fb2bedd780.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806270015060.21419@tvgsbejvaqbjf.bet>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <5373f422a82da2357828b8cc4a2b84fb2bedd780.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tVwPUX8i9jDIe2Lo9s3kG/SITnN/Zl5eEdcfj6/iVAZpjYfMWQW
 v0L+eO0wvb4aIEmiPTKBNj0r3I9zAhzd+BocPFvDR9PILRlWRVt3QwZDH5vpKQvn/NgJhil
 N8Co4ES5bRFw6/Vj9zXngQKj6g3Mphk/Uwb/CdT2ZaSXFO6ZX8l5kNEu/XDxtWastIJftIq
 8RorXbEsxKO0dYoTmAsOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ZkRgoRCa+Q=:6tqRc/ajesGDqY6sIKJ+S0
 +XVR9Y+zyUqI+IuoCV08fMuOOmeRjXpJSHOWwPtruPaVtubk7iU+vqmKK4/OdEccLAtuAGDTk
 nHnIO/GQWchluyho0dZZF8j02qOdrO0AN6KYBpChD35meheJfW//1SWE4h3B20iTkineuTMeR
 Bk8Ju1e3YYmj5XDY2x1TfPBv8rFl1fIFAEdb/UcUJQ/YwQGAb1fawCLGI3YCJJXn9aRITG6Jr
 k7QW6RjKElkjwrCmvfkEjP1e7McZn/hqjDn/J53m+SqDHBRqW1YdKJGlR3Z9NRKQvTOorD9k8
 NYRYg+/lcLhas/xydrpI/kwqS9hkRo7vLOQ7lzskYd6XxEnP4Pk3XtRebCq7iB4BlhI7tLjkN
 D9vxrZsuROJvuza+0GVBI9aqboupUi5w02mLiTmRP5ZJIEIVTCyqvo1ONzb0HaIkUTsGnpGT6
 NSD1fZ7OdNffSNHPfTTmv70YcNhzje1zbXW93dLFy5KSTImd+xHRMoNM1xb4DiKps4U/83mHq
 CdfF0D4HiOHJrWGuXnvzy+YBth1IlYKknhOJllmrfYpvJVcImr1yQuuvpdQtH4HyfdaNTbQgS
 R4fJfZcv48n3RYGJQUjIcYBYuDUJCfc852MQwCu2MtEqHujhQfNG1UtbKc5x/rkGtnYBmEjK/
 wO97ssFb8PWBuEr7l0eH5dtYppgPoM9W09eK0MgY1QKQhNX3V1e/Dcwu1hGNjkUnKdYfbeRYy
 TvBQESaLZYAIdXs2SGWs74IQPrj0U1tPgGbQrxfyN+uHSzjAgUr3hiuiNUUHEicGg1Yj7G/Oq
 S0CzRjB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 1c4387b10..84a537f39 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -414,6 +451,77 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int do_drop_stash(const char *prefix, struct stash_info *info)
> +{
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	int ret;
> +
> +	/*
> +	 * reflog does not provide a simple function for deleting refs. One will
> +	 * need to be added to avoid implementing too much reflog code here
> +	 */
> +	argv_array_pushl(&args, "reflog", "delete", "--updateref", "--rewrite",
> +			 NULL);
> +	argv_array_push(&args, info->revision.buf);
> +	ret = cmd_reflog(args.argc, args.argv, prefix);
> +	if (!ret) {
> +		if (!quiet)
> +			printf(_("Dropped %s (%s)\n"), info->revision.buf,
> +			       oid_to_hex(&info->w_commit));
> +	} else {
> +		return error(_("%s: Could not drop stash entry"), info->revision.buf);
> +	}
> +
> +	/*
> +	 * This could easily be replaced by get_oid, but currently it will throw a
> +	 * fatal error when a reflog is empty, which we can not recover from
> +	 */
> +	cp.git_cmd = 1;
> +	/* Even though --quiet is specified, rev-parse still outputs the hash */
> +	cp.no_stdout = 1;
> +	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
> +	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
> +	ret = run_command(&cp);

I thought you had introduced `get_oidf()` specifically so you could avoid
the `rev-parse` call... `get_oidf(&dummy_oid, "%s@{0}", ref_stash)` should
do this, right?

Ciao,
Dscho
