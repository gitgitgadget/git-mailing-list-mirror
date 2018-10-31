Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE3031F453
	for <e@80x24.org>; Wed, 31 Oct 2018 14:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbeJaXwa (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 19:52:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:40411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729271AbeJaXwa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 19:52:30 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxPAo-1fTfqo2pHW-016vQx; Wed, 31
 Oct 2018 15:54:04 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxPAo-1fTfqo2pHW-016vQx; Wed, 31
 Oct 2018 15:54:04 +0100
Date:   Wed, 31 Oct 2018 15:54:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] sequencer: break out of loop explicitly
In-Reply-To: <20181030080937.11118-1-martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810311553480.4546@tvgsbejvaqbjf.bet>
References: <xmqqva5l76zs.fsf@gitster-ct.c.googlers.com> <20181030080937.11118-1-martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-141794484-1540997644=:4546"
X-Provags-ID: V03:K1:TV4Dai6h4gO/U9btFntOsnr3oOczE1VAXim+QkkjEVVO1Fb+H08
 rkbiTxvoafuQJIIYLSr9gJxsM8UoB+ExtXgq/JSL95Y4mEGRBIJ6utcR21pvN/oST8Epi6r
 TrQBm2nco8SKCZ/3HyO3yIA1Il/4cVkQW8r4twWOniGqmkn4os1lOZBqEHvJjZ4TIHazMOi
 4vDh137Zxk+F3Uy+2dgCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yqO5eYI4lx4=:Zf87ho5HbyJx/RKsrt0PIN
 T1yy3b3fDWbZK95qkWnUVcMhi4DSyVAIwhf5LwJXq6Konp8MPStnUNPaVjJetCgWXNCOoXmOc
 hOehf5DPiCHLiuAQbe/adHG1xzHxq+Q5wmOi2oDAl1rB4tgYgJTAj5dsSItINZ+cdtK0ESbNI
 rclvTMByy1F0vyd1HTeik5CqdQK7CjXinsPz54XL4QEMmHlo9rY6WlWwNWTglb2Re9Ng9yQzZ
 9vIhCJBmBUwTX3nNldQ6eQajRndaN7o8hZaJjie8FnRMtTnM/AVxBqQoOC0QuO9k8/mGmbidN
 4Pmco4tNtp9+lfE0gb9fLvMC/KWxnmaQ9/kChulvHopcxUoVVdr2aFO0bX3Euq24Nbu9X7wgU
 shMgLGotvQl4xVHYpzifV45rl0J0ckTU7Gg7nBLYmrY25LxKFnHojxd4iDG7H7mKRezuU/ePV
 xZA7Q7wfXt5ioSSIkyZ7mTIDwAS5zRVq4jD9xG8WRJcg6UWSg4jipYENszASdaPTTVFvreFH6
 7HaOjnJ2rWfqqhCMOEVorL8lhlqlab/KLapmgOlv+lDuuS1XoT2j2NioxHyN80TdEo9xR1pHc
 YFVoYbfswj+ysCJE5eLI9u/GvkKsX6dnXWCv66LnDK2aXX9kPvoQWsB38aISNTGeDD/A9Fsev
 2J6YG+gLgo2ZOOGDmAhdDmV/Y+B96Mxf6oA6jjHWzWjTT4cLCEv1QYjXqtVWppM4Ofm10A4ih
 VZHU636PXr8PN9/9XYI/VvUf0kmbZSBLsS6hnfK0WhCDISosxnGa7XugkM6gSTD6nZxt5g4VP
 Og+oxavZMYYAWOLAxgBCpR1ms+RxXxEQQRwufmit+tTuaTcgzk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-141794484-1540997644=:4546
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Martin,

On Tue, 30 Oct 2018, Martin Ågren wrote:

> It came up in review [1, 2] that this non-idiomatic loop is a bit tricky.
> When we find a space, we set `len = i`, which gives us the answer we are
> looking for, but which also breaks out of the loop.
> 
> It turns out that this loop can confuse compilers as well. My copy of
> gcc 7.3.0 realizes that we are essentially evaluating `(len + 1) < len`
> and warns that the behavior is undefined if `len` is `INT_MAX`. (Because
> the assignment `len = i` is guaranteed to decrease `len`, such undefined
> behavior is not actually possible.)
> 
> Rewrite the loop to a more idiomatic variant which doesn't muck with
> `len` in the loop body. That should help compilers and human readers
> figure out what is going on here. But do note that we need to update
> `len` since it is not only used just after this loop (where we could
> have used `i` directly), but also later in this function.
> 
> While at it, reduce the scope of `i`.
> 
> [1] https://public-inbox.org/git/CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com/
> 
> [2] https://public-inbox.org/git/CAPig+cRjU6niXpT2FrDWZ0x1HmGf1ojVZj3uk2qXEGe-S7i_HQ@mail.gmail.com/
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---

ACK. Thanks for cleaning up after me,
Dscho

>  Thanks for the comments on v1. Based on them, I decided to go for
>  Eric's option 2, and to make the log message less technical in favor of
>  "compilers and humans alike can get this wrong".
> 
>  sequencer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 0c164d5f98..e7aa4d5020 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2829,7 +2829,7 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
>  	struct tree_desc desc;
>  	struct tree *tree;
>  	struct unpack_trees_options unpack_tree_opts;
> -	int ret = 0, i;
> +	int ret = 0;
>  
>  	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
>  		return -1;
> @@ -2849,10 +2849,13 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
>  		}
>  		oidcpy(&oid, &opts->squash_onto);
>  	} else {
> +		int i;
> +
>  		/* Determine the length of the label */
>  		for (i = 0; i < len; i++)
>  			if (isspace(name[i]))
> -				len = i;
> +				break;
> +		len = i;
>  
>  		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
>  		if (get_oid(ref_name.buf, &oid) &&
> -- 
> 2.19.1.593.gc670b1f876.dirty
> 
> 
--8323328-141794484-1540997644=:4546--
