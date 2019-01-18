Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9584A1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 10:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfARKzT (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 05:55:19 -0500
Received: from mout.gmx.net ([212.227.17.22]:59837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfARKzT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 05:55:19 -0500
Received: from [10.49.182.9] ([95.208.59.217]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MB2G8-1guJhq21HI-009yda; Fri, 18
 Jan 2019 11:55:10 +0100
Date:   Fri, 18 Jan 2019 11:54:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Patrick Hogg <phogg@novamoon.net>
cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH] pack-objects.c: Initialize read mutex in
 cmd_pack_objects
In-Reply-To: <20190118022736.36832-1-phogg@novamoon.net>
Message-ID: <nycvar.QRO.7.76.6.1901181150450.41@tvgsbejvaqbjf.bet>
References: <20190118022736.36832-1-phogg@novamoon.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jilFbm4CpBrYrLyCFWKwFhukHI3699toJqI7Kcn3gIrX+tr2T5e
 LtyvVgwO5G+Dr3ynSoB8bCw5hEyB4FHfzqU/QgNyLH6hdUlR+t9RuIIzEW70fQUoOwTtMUc
 76FH4rlzmnXep3FQZTes3J5EvaSarFJiWWYqaNDPeCaxnspbi2IjLA9V+DethRCiZpl0GM0
 dgwrIJ954F3m3WXPy7hlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DegCtJrOjs8=:g4ptTAftwuHtXOo+3Lwlfh
 Kd4C7/98pWlMb638Jqc/IjyOFRtyAVp/djaeddFang23hJbC6mDwH5c5faKVVgFZ5m8lROUev
 59qkY7upqHJ3v1V1NIxtm4hOiw2dtFQqaZOMAYWKagOX8xGnF8Cz0eynHm5kzx5Ut6kOJ7PZY
 +gbgDSnoJOt9pxsf8y7Z0AY4jAoWx2TBJ19QDV745QtUntIsAHtSWiNrjejpE8ItpIz81pRhS
 bIDUE5Xu7nluK20/HqsbXNsakzMewZuEM3biKgvda0W5pf6g1yBgTdBWMegG4ahnJbgUtuEBW
 dFbXjfyLrn6TT5r7n31ru3guhvMMYA/Li3BUE9bpM9w8aOJbp0C8mY1DqlqI7Gt45gbBCCKYD
 PW3jp3ygIYWNra2l6nKeChe1PBAS2R95Dq5Ixjijk3G6AEwPzDwipoP+Cn/8BA4lJLxmKozhD
 NrJgK6seQj1lZmUqcT4pf66VwhAULpR8heL+dFb6gdL6z+6HUkwzpNC1Q0WCDfGRbCM0AYA+M
 xo1P9K0orLEMWEiGTw1OntmcG9ftJV3QFl9VNmK/LmHoaFbUmuwyStbeL4erbqTkA87JVHQP1
 lnc+DKOSPCGhexG/qby61AzEul2ViHeX10kwDGXApxoPFkR7865tckyiqWeZG5v5gHrpwkgnx
 zTi3En01igu8WncFE01yWsJt9yx/3dVW6lR3t6bLskqrdCSqjEwakHGxWswRQ1NtPd9DE0+Fh
 YORfDg7wcAg+mn7pAAutsEXbzx7SQAGS0qEDhCrDTUiQCo30SlpCTy77f98EUm5bOEfZCa9hR
 NxH76gmVvb9eqgwbTJz7yyx3TsAy0JPtvZQPnYZw+zSurqM5Y8NB1faYfMgegYV0eogTBsyun
 v30je7P1gZNn8/sT2wmNSUDVfknS4WlI9A9Cam6rYPL7jpzp2tvXMfvBCTXvGI5vkngiEsp1B
 As2sTte1o5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick,

On Thu, 17 Jan 2019, Patrick Hogg wrote:

> ac77d0c37 ("pack-objects: shrink size field in struct object_entry",
> 2018-04-14) added an extra usage of read_lock/read_unlock in the newly
> introduced oe_get_size_slow for thread safety in parallel calls to
> try_delta(). Unfortunately oe_get_size_slow is also used in serial
> code, some of which is called before the first invocation of
> ll_find_deltas. As such the read mutex is not guaranteed to be
> initialized.
> 
> Resolve this by splitting off the read mutex initialization from
> init_threaded_search. Instead initialize (and clean up) the read
> mutex in cmd_pack_objects.

Very good explanation.

Two suggestions:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 411aefd68..9084bef02 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2381,22 +2381,30 @@ static pthread_cond_t progress_cond;
>   */
>  static void init_threaded_search(void)
>  {
> -	init_recursive_mutex(&read_mutex);
>  	pthread_mutex_init(&cache_mutex, NULL);
>  	pthread_mutex_init(&progress_mutex, NULL);
>  	pthread_cond_init(&progress_cond, NULL);
>  	old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
>  }
>  
> +static void init_read_mutex(void)
> +{
> +	init_recursive_mutex(&read_mutex);
> +}
> +
>  static void cleanup_threaded_search(void)
>  {
>  	set_try_to_free_routine(old_try_to_free_routine);
>  	pthread_cond_destroy(&progress_cond);
> -	pthread_mutex_destroy(&read_mutex);
>  	pthread_mutex_destroy(&cache_mutex);
>  	pthread_mutex_destroy(&progress_mutex);
>  }
>  
> +static void cleanup_read_mutex(void)
> +{
> +	pthread_mutex_destroy(&read_mutex);
> +}
> +
>  static void *threaded_find_deltas(void *arg)
>  {
>  	struct thread_params *me = arg;
> @@ -3319,6 +3327,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  		OPT_END(),
>  	};
>  
> +	init_read_mutex();

As the `read_mutex` is file-local, and as it really is only initialized
(or for that matter, cleaned up) in *one* spot, why not just spell out the
one-liner instead of introducing two new functions?

> +
>  	if (DFS_NUM_STATES > (1 << OE_DFS_STATE_BITS))
>  		BUG("too many dfs states, increase OE_DFS_STATE_BITS");
>  
> @@ -3495,5 +3505,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  			   _("Total %"PRIu32" (delta %"PRIu32"),"
>  			     " reused %"PRIu32" (delta %"PRIu32")"),
>  			   written, written_delta, reused, reused_delta);
> +
> +	cleanup_read_mutex();

This misses one early `return`:

	if (non_empty && !nr_result)
		return 0;

I'd still suggest to just write out

	if (non_empty && !nr_result) {
		pthread_mutex_destroy(&read_mutex);
		return 0;
	}

even if there are now two call sites.

Ciao,
Johannes

>  	return 0;
>  }
> -- 
> 2.20.1.windows.1
> 
> 
