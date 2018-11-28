Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0AA1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 09:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeK1Uik (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:38:40 -0500
Received: from mout.gmx.net ([212.227.17.22]:47721 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbeK1Uik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 15:38:40 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1gNpYX12bR-004mG8; Wed, 28
 Nov 2018 10:37:36 +0100
Date:   Wed, 28 Nov 2018 10:37:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org, benpeart@microsoft.com
Subject: Re: [PATCH v1] mem_pool: add GIT_TRACE_MEMPOOL support
In-Reply-To: <20181127195337.3264-1-peartben@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811281036300.41@tvgsbejvaqbjf.bet>
References: <20181127195337.3264-1-peartben@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rqkrWRcDqRn3iHKAm6fGw6DPvnulTtb8k1+amAGozYMADvvqbvr
 HGED/kauSSiEBmV7DEqyZpZwsluUc9arMJlbhxTVPccY6QWwt17D4LCbKHxxz3rJPrf9blj
 kxVcy8vwxR25GpM0dMFuXx4CpikO2VDbviEomq+LuyjPiBUfdujwX/8zmE8uZiI5XX339Lz
 qvcJORkeB1wexfGJueaXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JhJEimuKPFo=:RPytRPcmwQvXuu4GdJc+zi
 xucD5wYeFeeA9DBpdsuc9tXL7m8XDT9VI0l4SAu63Obz1p85JQj/0WjMf2No/bTy1nwE6KNYM
 5P0C9gfmzvK8y92U6lwdKe1yUMYSskmsGHJS4cWX5b3bdKUGB58tp00wyG5DmKap6/MstcoGZ
 /HCbq7eWFT920zqlvUDfYBv4uttTLtl7Noqfuvq+FAGOeOhAxKYKeCgmDhrtFSRyC22RpN36a
 7AiMgImWYyfTDpSSkvuj/btdi7KTWtwTmbiIZUV6vF8WTWmsQaJNKjf9Y6LrISMXKPpHn4BjC
 7ry+Afdn0BQ+/3krGa+51c8XPPRetz4xoZpiCfhs0brOX/ftI2znJZUzCS1d8aEdoQscOpS1N
 KI+iQ2lAHWrdBVMoby+IEGTqjNbHhrRdH0Bgs6Y3kzn3a/rttIbJ3t/temtWjgaLifg7bex7M
 U3bKFe5fnvk3tItX4zQThB5nNGUqQd4fO6Xjv1lZ8EOotmnYAcZ1yRG+44xMzy1NSXri+H+pm
 rCX1GLYC7f26HgJ6HthybhElt7ue2rpJVrFt/d1ZdFl/H3koiTUdFlBzPw32KAR8KlgoHeNX5
 49vHtOa+Yjgs0o2rxv/SI/3jLA2S9qAofNftEZpz52qSgwQiFt0+zB83k+j4E5psbsL/jEgoM
 75EitCXfWoTFGyqmd7wYTKl2Hw3xXmCKPzuvy3+hMSNi7lCB3lzDYAiNuq0HaJzMdZAawg1nM
 HDlPEpeCIA2eybxncuUdzVJHRz2fhmaP3ZyPq5RjKu+erdzLuyhGLD2Piqo5HkDbL3Kv+JOix
 WshXUchKH36azAC2JNOhB4sqBLqdA2octH0hLIRUclnjdx5miSAwy4pzaVTZOyJYAk0H8hmXV
 rXrMXfcqfwTXs7yQfFrTMt8AO1nsAvTBcuLLbDO02LQDCZhvvgq1KkKDmTkwQZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Tue, 27 Nov 2018, Ben Peart wrote:

> From: Ben Peart <benpeart@microsoft.com>
> 
> Add tracing around initializing and discarding mempools. In discard report
> on the amount of memory unused in the current block to help tune setting
> the initial_size.
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---

Looks good.

My only question: should we also trace calls to _alloc(), _calloc() and
_combine()?

Ciao,
Johannes

> 
> Notes:
>     Base Ref: * git-trace-mempool
>     Web-Diff: https://github.com/benpeart/git/commit/9ac84bbca2
>     Checkout: git fetch https://github.com/benpeart/git git-trace-mempool-v1 && git checkout 9ac84bbca2
> 
>  mem-pool.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mem-pool.c b/mem-pool.c
> index a2841a4a9a..065389aaec 100644
> --- a/mem-pool.c
> +++ b/mem-pool.c
> @@ -5,6 +5,7 @@
>  #include "cache.h"
>  #include "mem-pool.h"
>  
> +static struct trace_key trace_mem_pool = TRACE_KEY_INIT(MEMPOOL);
>  #define BLOCK_GROWTH_SIZE 1024*1024 - sizeof(struct mp_block);
>  
>  /*
> @@ -48,12 +49,16 @@ void mem_pool_init(struct mem_pool **mem_pool, size_t initial_size)
>  		mem_pool_alloc_block(pool, initial_size, NULL);
>  
>  	*mem_pool = pool;
> +	trace_printf_key(&trace_mem_pool, "mem_pool (%p): init (%"PRIuMAX") initial size\n",
> +		pool, (uintmax_t)initial_size);
>  }
>  
>  void mem_pool_discard(struct mem_pool *mem_pool, int invalidate_memory)
>  {
>  	struct mp_block *block, *block_to_free;
>  
> +	trace_printf_key(&trace_mem_pool, "mem_pool (%p): discard (%"PRIuMAX") unused\n",
> +		mem_pool, (uintmax_t)(mem_pool->mp_block->end - mem_pool->mp_block->next_free));
>  	block = mem_pool->mp_block;
>  	while (block)
>  	{
> 
> base-commit: bb75be6cb916297f271c846f2f9caa3daaaec718
> -- 
> 2.18.0.windows.1
> 
> 
