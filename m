Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 881F41F954
	for <e@80x24.org>; Thu, 23 Aug 2018 14:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbeHWSBR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:01:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:40515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbeHWSBR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:01:17 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nt7-1g2pyb2aYX-00yxxd; Thu, 23
 Aug 2018 16:31:16 +0200
Date:   Thu, 23 Aug 2018 16:31:15 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
In-Reply-To: <20180823032238.GI92374@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1808231629540.73@tvgsbejvaqbjf.bet>
References: <20180823023955.12980-1-kyle@kyleam.com> <20180823024719.GG92374@aiede.svl.corp.google.com> <87wosh7pjj.fsf@kyleam.com> <20180823032238.GI92374@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gxT5BP4DBWtrZUY8Wm/AtE8UgFSwLmWbTSON3A55OHHHvq5Lyoc
 UyUrVFWWDq5pEsRYZgTnc0wvlsjWuPCVC1E/Nq+XPZLxoXt7uXZYdByeEbl9OqBqrUPLRUs
 Kx/RHE3mPovrvWyA6+uRHbSBWux3NEnJsfwbyTnvUlvQqfXtNdAMxmjZRPcbe79fRRaiIg+
 NHCwdwX5QYljHCiwbPSFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:awF8oW+ylX4=:zU3XJsa+jZW1z13JovtHaO
 v70FgmVK2cQ+Fw0vRSzC4OviOVgMiT7SuXSE9xN/q6Vc7PWCfnDp+wqxOARC6idYTxcQYhBnU
 wTmR+4RKfbz4Pih1PI3J0EjiV9PY9hRLDDibxMiglc7l9pFTESZfoH6lKKHDLZDuJBjk97HaX
 gwj8I6NINSRISMOBWy4X8KR0/shas3hAZaAmrki0jEUF8k/K0kufuZ2eKRop3E56zHrMjtHaY
 HAmhC1RaHhlKkYpYKJsIMk0i5dzTyuSWWvc2RJdHAMSk5CSBqUL3+qNIh7jknatR1t53zd2o8
 Hs5kx6OGOpQSjgOpakiPECHhANkxWHSzVbgtXINZ0JblS4aXJlhDksX6OdV8mItZCuz76EHek
 TCkW8o/PyT9cxAr3FM0DHWdyy6tvD2rzQoXX046PI7306ecF+AHZCD+2OZiFh31Bq0gxlpNVj
 w2Fk2Qj1i6TQq5DAVb/eU4beBF9hsSe92v/5foUNJ9wj/bKcTbbGvriT0seVl1Z0kXRH7BT/S
 gWFAceOciwGS+HZ5vFH5GvXTDiMESCZ2v+qaRX2r3HoszVm9UQW7Z9xDTPSan28AEnbYqkZq+
 zumNgvwBHR5RC41+287S4J2hdff7p4bUBdN7L003wycPF/X9xH3fhPJQ/zy+maxY2GCBSKoAL
 AJdaiucQlgN5uPnd2DDX7BpQbH2mZpIErskTB3torni/4ncVH4yiyAhT2d5+w8GOTih6ecjV/
 TYhEaipn/zzDLRL0R5NikMaoCtjjmcCsPkbqGF0q9ze1cDHbjAyIIqwdKnv6IXxF2CaTdg7lv
 0xQKtA6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Wed, 22 Aug 2018, Jonathan Nieder wrote:

>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("Percentage by which creation is weighted")),
> -		OPT_BOOL(0, "no-dual-color", &simple_color,
> -			    N_("color both diff and diff-between-diffs")),
> +		OPT_BOOL(0, "dual-color", &dual_color,
> +			    N_("color both diff and diff-between-diffs (default)")),

There is one very good reason *not* to do that. And that reason is the
output of `git range-diff -h`. If anybody read that the option
`--dual-color` exists, they are prone to believe that the default is *not*
dual color. In contrast, when reading `--no-dual-color`, it is clear that
dual color mode is the default.

Ciao,
Dscho

>  		OPT_END()
>  	};
>  	int i, j, res = 0;
> @@ -63,8 +63,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
>  			     builtin_range_diff_usage, 0);
>  
> -	if (simple_color < 1) {
> -		if (!simple_color)
> +	if (dual_color != 0) {
> +		if (dual_color > 0)
>  			/* force color when --dual-color was used */
>  			diffopt.use_color = 1;
>  		diffopt.flags.dual_color_diffed_diffs = 1;
> 
