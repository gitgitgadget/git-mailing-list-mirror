Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E68961F516
	for <e@80x24.org>; Tue, 26 Jun 2018 22:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932918AbeFZWYA (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 18:24:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:33009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932434AbeFZWX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 18:23:58 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgt3g-1flBtp2YzI-00M5X7; Wed, 27
 Jun 2018 00:23:53 +0200
Date:   Wed, 27 Jun 2018 00:23:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     git@vger.kernel.org, joel@teichroeb.net, gitster@pobox.com
Subject: Re: [PATCH v6 3/4] stash: convert branch to builtin
In-Reply-To: <ac0a24da8a583a137176d1d215df65bb1a3ada0e.1529943789.git.ungureanupaulsebastian@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806270018580.21419@tvgsbejvaqbjf.bet>
References: <cover.1529943789.git.ungureanupaulsebastian@gmail.com> <ac0a24da8a583a137176d1d215df65bb1a3ada0e.1529943789.git.ungureanupaulsebastian@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l3G8TdWFiAxa4wR6MGOC06QAfO2etw5TUyrNq5Kgy78u+Snh6g6
 amx+Z9muF2Z6n6rtEvYfS2MYx+9gLoBlWnFhSzWYGYO6x91sHIboNVxfiEGQu/6yHyX/CE/
 qQaUN4AveuJP3boW78F9miPDZECLSPQ1mSkxvCDMBDVdJ3BkU+bO+b8h3385ofRqUUCsWou
 DZ7lZ4IpMu1CHs4p0n95A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tl4GO73t7lo=:z0zdUrT5lZGQSmr8hCp8id
 YRJqFYr3UxtLd/IEMGHGF65RWmeTCPqovXpVCjeCdPd3Vpo6nwQu5JRmaTLrIytXpPeCQNr4Y
 Z6ox3buAj7hfvmIk1oSmrnVATGy/yrOjPfzjUufY8udoF7/psRQaYv90hqJL56oN46BSQ6U2E
 cBlL+Fy52rjMEZBrMQUB6nTkSD77sgebpOELwwJyE9eqEmUZscIO9swOj7zv3sJ0SEcJ92eWe
 GLYKKAkUgQ2sDnIVJ/RATNlURw64hQ0NtNPTixhkgE/0AtlQu8dYlLbixmf3rI7tOfJbHVi7y
 NxEMbTfbBJtQqLLAnA9KkNYLNM+g64f1PZ9d3xNlE2s78iNOJ9ns0yglpX6ecNbPxgA8tCXGb
 r2B/mzKS+Mw9QZID2d9enA4M0O05vQCm9u6zrmik4kT+blbqk+xhwqbocBR3kWs1K7sUEhXHQ
 vKbw6q6YNeBFpPoVF9893isdW6uHVtsHEqALmQcz8tW+PjHuY7nTfDXLmXPfTO+kZllKcI0hG
 hAP7HtsQvXF2gvvXkh4XhXCyKBLHK+fghHc+fP5vSkqlHHMCtYugZzGhbjZz9VjPcovA7e48a
 v4NU/DRxbCioqD7exuuqQPseJdMd4CmF8gsz5zwv+HSmobe39+mOj/1bD+rdXJ0j2yT6e248+
 rraUUmrN0uwvoGEsb8XqkkUC9JNq2jX7j2Yznql6onBJK7f9lbIWA/+NVdi66YXkt9LFZgBVJ
 WfaeOCHiuFH2zcqe/RFM0sv/4GomS81kBrLuAdCftJiiXe8ihqsSS5QMwLVTtEFXJSWFt3vc7
 uijmcxY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:

> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index 84a537f39..fbf78249c 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -522,6 +528,41 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
>  	return ret;
>  }
>  
> +static int branch_stash(int argc, const char **argv, const char *prefix)
> +{
> +	const char *branch = NULL;
> +	int ret;
> +	struct argv_array args = ARGV_ARRAY_INIT;
> +	struct stash_info info;
> +	struct option options[] = {
> +		OPT_END()
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options,
> +			     git_stash_helper_branch_usage, 0);
> +
> +	if (argc == 0)
> +		return error(_("No branch name specified"));
> +
> +	branch = argv[0];
> +
> +	if (get_stash_info(&info, argc - 1, argv + 1))
> +		return -1;
> +
> +	argv_array_pushl(&args, "checkout", "-b", NULL);
> +	argv_array_push(&args, branch);
> +	argv_array_push(&args, oid_to_hex(&info.b_commit));

Why not combine these? _pushl() takes a NULL-terminated list:

	argv_array_pushl(&args, "checkout", "-b", branch,
			 oid_to_hex(&info.b_commit), NULL);

> +	ret = cmd_checkout(args.argc, args.argv, prefix);

I guess it is okay to run that, but the cmd_() functions are not *really*
meant to be called this way... Personally, I would be more comfortable
with a `run_command()` here, i.e. with a spawned process, until the time
when checkout.c/checkout.h have learned enough API for a direct call.

Ciao,
Dscho
