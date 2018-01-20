Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443521F424
	for <e@80x24.org>; Sat, 20 Jan 2018 12:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeATMbQ (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 07:31:16 -0500
Received: from mout.web.de ([212.227.15.14]:62581 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbeATMbO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 07:31:14 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUSOp-1eBgXo2WKR-00RJZX; Sat, 20
 Jan 2018 13:30:59 +0100
Subject: Re: [PATCH v2 2/6] Add tar extract install options override in
 installation processing.
To:     randall.s.becker@rogers.com, git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
 <20180119173406.13324-4-randall.s.becker@rogers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1153e1c0-c7d5-3e0d-ce41-ffb1230164f7@web.de>
Date:   Sat, 20 Jan 2018 13:30:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180119173406.13324-4-randall.s.becker@rogers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:F03eMq5H+trlnkjP0+gD1PRGewlxzNNJAxPujcsJ7Op6080E1+0
 SFvzJPmKgBWY70nDzn8bccRV6PLXQQPSDe8h+rcxhuRw6PMUgwJPwfoNiB3MEj6B1yv8EYY
 Px5uhsMTbE1shORtMf9Zv4kOeQQF1Hjq1G8stMpBqRYIJndtQdXShcF+kUHP2pydtePaz0F
 uLDo7WD2ZeG7ZcMkC1ujQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/uVlTQyvoHA=:zeb5NVA64Nm+cVwH6jBmcr
 Qb0CWfq1ikvACKdQvlAjgjwpZyTjLfQWi7A/2dx3UxsFJgRtnu1mN9WbxF7S5wxpSZ+ND8f5Q
 sjmO/zrrSjKAfIaxQPA6geh2ZWTWeOn0Kpo8aRi8JGuNFCqK7wTeXIjGxeI2F7rVGXCpBYzN4
 g8OHvy84Tb+Gv3+Ep+ZNCvWTIUMs/sQv2E+dQQDBST7khu46OJoFd1EzyI0MbKUBV0PwV/6+y
 m7N6ocVu2riOG5V+a88FRZpsMs7wuWNDBoQSSbpTRnOWtcx9l+tDWdpl/4sqknLASGcbG3Q+J
 IXPkfGS9v9fVUJbiXwT/PKfM1JzS43M+lrayGKoNtPOpeuamuDwhPw1eSnNHqO2JjBLrmLL5L
 v3K1L+/NRuHoga6ZVZb+RYVVavHR5vy0KowX3U85N7WLBEwPkafFbGCRgF0mrK/WkIdOfinz1
 1EwxeOa0QIaNYiIGT7mk4HkMRsndvgVqKJZmgJopeyxlUL9oK7sKskTvvTwJjvLfG2981UQDw
 M8wWVkIFfmaalWeJ7emKA1LZX3iKlrVksnY0cr4I6xNYc9b2rDQAgdBxWnA6tNCkIZj/gqiTT
 Rn4KRbV2B2Xigl/1ldkP/1oKTyTI7pEZBWniQmE/cNI5R2DLMih+vr3YuYSaMcXm9zGsA9sIo
 TkRExgyTHEs6AzMZY5B53QXksL3ftycx72XiZRmb/VwTvLW4WqA2bzU87NyTuvOlxAlVNbMJY
 Ewc6odgtVGQMfEp7kUAy9NbWB4p0s6M2mP48PSME9d3jqnNWMUOFQESnqQSkzPaJeld57MoMb
 YSQXfKCN+Mk1RrHZy4/l2e/pSWlBOEeYqp0Z6+bAWCdIW9BkYM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.01.2018 um 18:34 schrieb randall.s.becker@rogers.com:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> * Makefile: Add TAR_EXTRACT_OPTIONS to allow platform options to be
>    specified if needed. The default is xof.
> 
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>   Makefile | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 1a9b23b67..040e9eacd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -429,6 +429,9 @@ all::
>   # running the test scripts (e.g., bash has better support for "set -x"
>   # tracing).
>   #
> +# Define TAR_EXTRACT_OPTIONS if you want to change the default behaviour
> +# from xvf to something else during installation.

"xof" instead of "xvf"?

> +#
>   # When cross-compiling, define HOST_CPU as the canonical name of the CPU on
>   # which the built Git will run (for instance "x86_64").
>   
> @@ -452,6 +455,7 @@ LDFLAGS =
>   ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>   ALL_LDFLAGS = $(LDFLAGS)
>   STRIP ?= strip
> +TAR_EXTRACT_OPTIONS = xof
>   
>   # Create as necessary, replace existing, make ranlib unneeded.
>   ARFLAGS = rcs
> @@ -2569,7 +2573,7 @@ install: all
>   ifndef NO_GETTEXT
>   	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
>   	(cd po/build/locale && $(TAR) cf - .) | \
> -	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) xof -)
> +	(cd '$(DESTDIR_SQ)$(localedir_SQ)' && umask 022 && $(TAR) $(TAR_EXTRACT_OPTIONS) -)

Hmm.  TAR_EXTRACT_OPTIONS always needs to have f (or -f, or --file) at
the end to go together with the following dash, meaning to extract from
stdin.  And x (or -x, or --extract) is probably needed in all cases as
well.  So wouldn't it make more sense to only put the o (or -o, or
--no-same-owner) into TAR_EXTRACT_OPTIONS and enforce x and f?

>   endif
>   ifndef NO_PERL
>   	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> 
