Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78801F404
	for <e@80x24.org>; Thu,  4 Jan 2018 23:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeADXD0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 18:03:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:58296 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeADXDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 18:03:25 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lbd9v-1fCah61zqd-00lHc5; Fri, 05
 Jan 2018 00:03:23 +0100
Date:   Fri, 5 Jan 2018 00:03:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 3/6] fsmonitor: Update helper tool, now that flags are
 filled later
In-Reply-To: <fb10a998d5a8250f26d3504a1d1f5ca6723160d7.1514948078.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1801042348500.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20180103030456.8181-1-alexmv@dropbox.com> <fb10a998d5a8250f26d3504a1d1f5ca6723160d7.1514948078.git.alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5WGfjTpxqSDbpCHCZwLOtpbZfHIXdkEBPkttCl0B9EHkn+rqMi4
 GCdWDLXBYMr8NM6mxh12MQWAugIcRi5Lyn1em+TNFu1mFaC4Hm46hxXaGd4NyAQbYJBCB+/
 btYdDftoLK0I4OONAk3UKDmynEuLI8mxckA3IaXVkrV4pSPWa56pKURf7ErgZ9FQ950lVSC
 Kjto+bw15NSRTykaRAoCQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W0qxZRLn+7c=:uOTwCE21zwlLiJiFE9XGn6
 0Vh+HN49TlY/awUFXct2Cnv9EAQB01sk4BsVZivy9WpUXjnUzDynqu5Mg9q6RvH9uQ6hyXhg+
 dthJRA/kc14io79YPsq2bKDSOz7wJikt9FhyMgbk/2Q350JaBPXFEK+HI0StgGGag1cIOnUQe
 iWMjw7I+JbfPvjEJd/ATDo/GD4fW1QFOb7ISd9lAtX87Z19qOi7UAjNZgG2EMVqGhFt5kZ1Az
 eyjLaL+kF5Ue398GZedfkK2TZPIgbtVHrbHvkWyqJU4ZiL7c7CV+tUkc7qZn+L9lYVZzOfp7V
 J98OhUCxb32XoOFCh3yGjxDpwgzHxxdgANbhuldUqLWGuXAWe1d4KBHwA8G9l9REMjgMxqAG3
 j7DpRWqvrOJdSOv6MZETndukJMlJ95MbHLdO1zBfB8IwKVcsNqtG0mXRqhILfpl3fwGJjN6En
 vhoMb6SAbC5Isa6cQtpZleXnmC0J1GHrMNLjFfgzB1oDUPgqtr4wCdel5QjYw2S8OZLX3y2qY
 nh+Hwa4ugTlct4yc/6VJjo7sxaJY1FCOaxte5M2xITZV6Ner41cxozCDWrUCQFSm8TIj2KOHH
 ojFT1tkoQKEFRcTUEruJ5KA5/khitF/u2JE35i5AfS/7A/Dgl9NbT6CXTe/BwCMXuGrZ7ncUC
 neqqT7xxKQgJoYE/o38NfyliV5i9at3DD1Z//nh4kNmIbcJkF0huyLdVwmG+2nh8HJxWrwKiY
 J7U/aCNNkIvw9dYO9TBJZRpgNRUq48PgFLfT3BiMfiVmpGFR6rrk18IWvJbQQzWVhqwCiH4jF
 lVmqSsN8jZ7fAnfzlW40sfPlwv4KKkB1mjqSo1ZaQXk5uc9HtL1nP2RiTRCySMHiDKkOvrm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Tue, 2 Jan 2018, Alex Vandiver wrote:

> diff --git a/config.c b/config.c
> index e617c2018..7c6ed888e 100644
> --- a/config.c
> +++ b/config.c
> @@ -2174,8 +2174,13 @@ int git_config_get_fsmonitor(void)
>  	if (core_fsmonitor && !*core_fsmonitor)
>  		core_fsmonitor = NULL;
>  
> -	if (core_fsmonitor)
> -		return 1;
> +
> +	if (core_fsmonitor) {
> +		if (!strcasecmp(core_fsmonitor, "keep"))
> +			return -1;
> +		else
> +			return 1;
> +	}

It took me a while to reason about this:

- there is no existing code path that can return -1 from
  git_config_get_fsmonitor(),

- the callers in builtin/update-index.c (testing explicitly for 0 and 1)
  do not matter because they only trigger warnings.

- the remaining two callers are in fsmonitor.c:

  - tweak_fsmonitor() (which handles -1 specifically), and

  - inflate_fsmonitor_ewah(), which only tests whether
    git_config_get_fsmonitor() returned a non-zero value, but that test is
    inside a code block that is only triggered if the index has an
    fsmonitor_dirty array, meaning: it already had fsmonitor enabled.
    Therefore the test is legitimate.

This would take the next reader as much time, I would wager a bet. So
maybe you can include this information (or at least the information about
inflate_fsmonitor_ewah()) in the commit message?

> diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
> index ad452707e..48c4bab0b 100644
> --- a/t/helper/test-dump-fsmonitor.c
> +++ b/t/helper/test-dump-fsmonitor.c
> @@ -1,12 +1,14 @@
>  #include "cache.h"
> +#include "config.h"
>  
>  int cmd_main(int ac, const char **av)
>  {
>  	struct index_state *istate = &the_index;
>  	int i;
>  
> +	git_config_push_parameter("core.fsmonitor=keep");

The alternative would be to use an environment variable. We already use
GIT_FSMONITOR_TEST.

However, I wonder why we need this. Do we really update the index anywhere
in the tests, then *toggle* the core.fsmonitor setting, and *then* call
test-dump-fsmonitor?

And if we do, can't we simply avoid it?

Ciao,
Johannes
