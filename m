Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86EF1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 20:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdBJUr4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 15:47:56 -0500
Received: from mout.web.de ([217.72.192.78]:52558 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751060AbdBJUrz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 15:47:55 -0500
Received: from [192.168.178.36] ([79.197.218.233]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MY712-1cyLCI1ZWi-00Unlh; Fri, 10
 Feb 2017 21:47:26 +0100
Subject: Re: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc
 shell function in C
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pranit Bauva <pranit.bauva@gmail.com>
References: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <128b4de6-7b8e-27b9-414d-c6c6529cb491@web.de>
Date:   Fri, 10 Feb 2017 21:47:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RRnXRVxzGoFx+iE0rEGL8eoPBGI54LLnrzD9SEK64WZYU43nDpa
 doF5pJzywOahKduIpF6Y0ZODAxDksd5TdjZr6xdT7epmorhlb0oqnTsODYEwSCkV32A9Fhb
 A8BzMSMiVPwUtB0sRZoYedSaS5QK52HOOtPA1Hmt9wfD3hOT2lzw+/nYLE3chU7Yyv+wAGN
 /Lcc+huLjIODHbP+tozsg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/XG40iRHQn0=:CruZ4uXM0uJEIgP88yWtgF
 +SQ2P56rf8vRMw/NMcZzHQ72Uj4VlW69+4j/x8VSmD49kbSiuyWKri16v3SJgWifrQsdDvLRI
 Ov+wqs/f5FuX6WqAf2yLEn0ggLte11hShHLePJfuWaHeTacU4wx1ZDSJTFVK9I4PHVD1gkJtc
 98qJhiBCIpAMZUz4Wy8VmFCHzLXNDhQ9Bkn5dYBsA3GY4A5rJAU8OlHsqsLAV7pTlAAtSani1
 h9po9/sCplMML9BjsGeD7yrF4MLAgyMSu8QzAfLSl5s/WrejeDYqh2VDk9H9/jZXprLrv8Udz
 yKy53lYIiuM2VrQurIptH0O7qAzSiwwYLipZ1o84m6KvTXT0jnMnXOD0VXa9qpVkWZ5Xf4f3l
 y7wpHvH0L0EVq5bsT0CMJ0sA3T73W+WG/w6lx5ShAcq01jJu9m0fh825oDZIUU9FvFcxDVcyp
 fY3SRJYGjKhyvCCt0xhJQxx8hth/PZqBYq3Y1dNqM/bRZyBgEfZuK90XCz+QkCR0u/36KdL8t
 MslnwLvuytiaOdvbptW2BbUv4tPVKWd1MxIBjmxkihPPNW5sXpUss9mDhgcfntGaXW+n9+y3R
 1ilmtLAYvqczdfBY84OqHs0/r0yyb28qHKb/wOKFxfOmhdKcHWpJouySm4GeLA0UX7oHOpkQR
 SXzAJxM6IVlxI8lX5e6ZETkxYz148rXWj5o3HE0ZC2JBcWWB3Hy6XpBYbgql9SjrA2j8LF7DW
 1Cy2ciHUxViWGo4FEQLik8sOEU8+q3AEiax044/0qLcnDWASzMccr8FPdDm1W7Mc75otTWj2w
 4QLXlSZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.02.2017 um 15:20 schrieb Johannes Schindelin:
> It is curious that only MacOSX builds trigger an error about this, both
> GCC and Clang, but not Linux GCC nor Clang (see
> https://travis-ci.org/git/git/jobs/200182819#L1152 for details):
>
> builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used
> 		uninitialized whenever 'if' condition is true
> 		[-Werror,-Wsometimes-uninitialized]
>         if (missing_good && !missing_bad && current_term &&
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> builtin/bisect--helper.c:350:7: note: uninitialized use occurs here
>         if (!good_syn)
>              ^~~~~~~~

The only way that good_syn could be used in the if block is by going to 
the label finish, which does the following before returning:

	if (!bad_ref)
		free(bad_ref);
	if (!good_glob)
		free(good_glob);
	if (!bad_syn)
		free(bad_syn);
	if (!good_syn)
		free(good_syn);

On Linux that code is elided completely -- freeing NULL is a no-op.  I 
guess free(3) has different attributes on OS X and compilers don't dare 
to optimize it away there.

So instead of calling free(3) only in the case when we did not allocate 
memory (which makes no sense and leaks) we should either call it in the 
opposite case, or (preferred) unconditionally, as it can handle the NULL 
case itself.  Once that's fixed initialization will be required even on 
Linux.

René
