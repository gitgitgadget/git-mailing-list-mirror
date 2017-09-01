Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2193A1F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 23:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdIAXbl (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 19:31:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:60235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdIAXbk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 19:31:40 -0400
Received: from virtualbox ([37.201.193.79]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKt5A-1dnvPG3Nui-0005mX; Sat, 02
 Sep 2017 01:31:22 +0200
Date:   Sat, 2 Sep 2017 01:31:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH] hashmap: add API to disable item counting when
 threaded
In-Reply-To: <20170830185922.10107-2-git@jeffhostetler.com>
Message-ID: <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com> <20170830185922.10107-1-git@jeffhostetler.com> <20170830185922.10107-2-git@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Ki9gFs9uoDbWRM++KO35ApQwXGARWzzCQkjwV98WgFXYT9gZwMJ
 W256cNBmipu4CElRzSQrkwevm88WfTMfnbmTLm7ntDbRLfoSnl2k5Om2+5tEMumfESzo/5R
 4AX+szZPh3e3/vlm8POv4FQQowHU173dpveMIcNE0KsFhbmqhNHgxFnbRWXCT2YnkDCo0Ev
 40etXxIIYUy28MbV5mTgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vuedOU4ukps=:oUA155MkraDayA+Tz/LsDg
 LqWBQ7EwNNYc81mt2RimGScm7uSlp+eb9mArfu+4woiR2lCTGlpiD5dT8t2Mmdduri4TWpd/X
 x7+YMnQyWXOyhUYtcxAWi3dpTBoZuUWHPCyeaFqIgGx4KvJAV2aZNycrhCzDncRrU3WqluNhR
 H5jhDdcb4AuEknshbKRytOVdS5u/jvTEEZuga2iIZmlvRyDLlrbi+f4cTdIH7dnbYnXi8P/5+
 QMYHnxNhC47ZL9zhJ6okNSR0E/u6wpfItoM8TaU0rMSO3VxkQzu1SHYsHzyEt/t/yNLdLlA1Z
 ty/lvj1FNwF8t4r+A2yG8xZXrxNhpT6aVhE+ny7MgbROlbJkWITo7ykHWgM5FLD3YALY1DHja
 HxAnQPXTuYwOddTP8EGn6uIuvt746kKvZKAdmxW/ZnHbUFLn/ugS/axEIECMxcMixY/2hUJwG
 CCyoLYzT5UTeau7irBUrrV4Pvl2eL+zog8FZ/WeyEuGsWIETlDCClPewvXHz4bK/ANlOq36HC
 hyiYoEQ5bS1kFS/RrjBo738vnhAOiv6y0stiGMsT9Ui/YXXsFdjVCEpFhK70rJO+OuzSkwDHo
 6xyYeDZcsv8ftGz2eMQ7FHAlRyv6mkJZpKdigb4jj5a8auXVx0xtS6ESJSJQKeACw9RPa9wCn
 sv+rQy5+zJV6jVlSrg1v0Er4Lj8xsrSTIeLltsaunmPQoR53bFCd+QcU+yaifQf9kx7OAQZIY
 AVp23PRhLJ9Y6lGeezuay5re+wQsfRx1yMkVFF0hfUC3LXW9c/DjFdKyFWE6e8sLLHA1SOSl7
 y0ILJVv/SanTwq+vn2k4VrnCZYw2hzOAH8eICx8f54JY7Uw4cdQuNk6W8+DX9jVd+SXStPZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Wed, 30 Aug 2017, Jeff Hostetler wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This is to address concerns raised by ThreadSanitizer on the mailing
> list about threaded unprotected R/W access to map.size with my previous
> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).
> See:
> https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
> 
> Add API to hashmap to disable item counting and to disable automatic
> rehashing.  Also include APIs to re-enable item counting and automatica
> rehashing.
> 
> When item counting is disabled, the map.size field is invalid.  So to
> prevent accidents, the field has been renamed and an accessor function
> hashmap_get_size() has been added.  All direct references to this field
> have been been updated.  And the name of the field changed to
> map.private_size to communicate thie.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---

The Git contribution process forces me to point out lines longer than 80
columns. I wish there was already an automated tool to fix that, but we
(as in "the core Git developers") have not yet managed to agree on one. So
I'll have to ask you to identify and fix them manually.

> @@ -253,6 +253,19 @@ static inline void hashmap_entry_init(void *entry, unsigned int hash)
>  }
>  
>  /*
> + * Return the number of items in the map.
> + */
> +inline unsigned int hashmap_get_size(struct hashmap *map)
> +{
> +	if (map->do_count_items)
> +		return map->private_size;
> +
> +	/* TODO Consider counting them and returning that. */

I'd rather not. If counting is disabled, it is disabled.

> +	die("hashmap_get_size: size not set");

Before anybody can ask for this message to be wrapped in _(...) to be
translateable, let me suggest instead to add the prefix "BUG: ".

> +static inline void hashmap_enable_item_counting(struct hashmap *map)
> +{
> +	void *item;
> +	unsigned int n = 0;
> +	struct hashmap_iter iter;
> +
> +	hashmap_iter_init(map, &iter);
> +	while ((item = hashmap_iter_next(&iter)))
> +		n++;
> +
> +	map->do_count_items = 1;
> +	map->private_size = n;
> +}

BTW this made me think that we may have a problem in our code since
switching from my original hashmap implementation to the bucket one added
in 6a364ced497 (add a hashtable implementation that supports O(1) removal,
2013-11-14): while it is not expected that there are many collisions, the
"grow_at" logic still essentially assumes the number of buckets to be
equal to the number of hashmap entries.

Your code simply reiterates that assumption, so I do not blame you for
anything here, nor ask you to change your patch.

But it does look a bit weird to assume so much about the nature of our
data, without having any real-life numbers. I wish I had more time so that
I could afford to run a couple of tests on this hashmap, such as: what is
the typical difference between bucket count and entry count, or the median
of the bucket sizes when the map is 80% full (i.e. *just* below the grow
threshold).

> diff --git a/name-hash.c b/name-hash.c
> index 0e10f3e..829ff59 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -580,9 +580,11 @@ static void lazy_init_name_hash(struct index_state *istate)
>  			NULL, istate->cache_nr);
>  
>  	if (lookup_lazy_params(istate)) {
> -		hashmap_disallow_rehash(&istate->dir_hash, 1);
> +		hashmap_disable_item_counting(&istate->dir_hash);
> +		hashmap_disable_auto_rehash(&istate->dir_hash);
>  		threaded_lazy_init_name_hash(istate);
> -		hashmap_disallow_rehash(&istate->dir_hash, 0);
> +		hashmap_enable_auto_rehash(&istate->dir_hash);
> +		hashmap_enable_item_counting(&istate->dir_hash);

By your rationale, it would be enough to simply disable and re-enable
counting...

The rest of the patch looks just dandy to me.

Thanks,
Dscho
