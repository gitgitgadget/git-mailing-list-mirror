Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AD471FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 17:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbdA3RAr (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 12:00:47 -0500
Received: from mout.web.de ([212.227.15.4]:56253 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752788AbdA3RA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 12:00:26 -0500
Received: from [192.168.178.36] ([79.237.55.102]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvBJK-1cOvxy27aU-010KxW; Mon, 30
 Jan 2017 17:59:52 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <11e27272-c1cd-a127-eb44-385d827af63d@web.de>
Date:   Mon, 30 Jan 2017 17:59:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701301643260.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:PJjb2j/MHNEr9DNg4XoeKvRgNiuvnPySfhKY2fZyDn4D3LZc4rK
 u+dCEzNdeQqU9Ko/XA9ewFWpPpb0/5h4tlTbRFRtWLy98AuWey5fKcjXiKlEMXOst57sxIw
 +uoYIPgsnPn4zb+SmKahsCeyWbwZd10p7UkgOsaora8FHEmX7XihjZHzFgqveg7nptthIOt
 zZa5TuWSGZDVzIBoYLvtw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iTj9/q35/dY=:WIqDzHMBlBGCnBNGnHsV1p
 F++ekO5vHLbqoYxoOYNLxydBBw2Yq6TWK1eREA/RKuOb9IP40Ih0sqdYjVCmpocBq2KLOC2C1
 yiHDkPTUR3li0EcPUMbwmZ0ydVVKhgBYY1b74o9LBwrDFu+0qHG1DL5XhIUpXsmK9/tkb02Dg
 zTmPCVVamj4ep3/8gIAjDJiCYb1DFectnsvJj6tw66aNHnU3fBAVKK6SSI4ntFR0uQCf7Znwg
 Bm1Eb0advDU8dsQg5q/FuGb+O83tBImfZm5Uk4FZnA0wkit299VB63hKHLkSSoEG6+cyMOyy9
 czy61N7QzU+RHQhb3vfP16LOISUQajsRai2LI7LaKYIIokl1UhHXM0UZwHPvuD0r2j5fp1dEq
 nB1SvcS0wzeUevWP+Ftk9kwqUSbgl0GHfe48sC+6xMKqLaHkVJl0HE6YZx1T+rhDEsjBoqchY
 x8VvGcyKS2hPw7wUE1PwjH17tMSOKqJYNcLGHVUa54CH7fYr7leuwx/vCLFesdcPmc+e0g/49
 A6NsMXsw/b7ZocD79pY6lPpJX4t176ycH/+K7nUj0RZxt+xEKWk/ebK5XPpkAwM0ROpyomCbg
 4v14U8yxf4FvkH1oTxNJLKiPozkxnvgrlGPPfXYiEuuEi7wNbP3GuNYpGKtjLMYQ7VgSlntsO
 AHl4MSw//nsGh44l1lji3smy1DJMv4G6zS1R/A3VJ4fTe7+IvsgTB43fJx5EWun4wfbBJ2tvc
 vmqf+WRDvPy3b4DnSwvafjMM2DzpaUA2u6xq0m5KVXbERp2bshMfMU9pgmIKOqXKLVb8p/Mye
 477zEa7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 17:01 schrieb Johannes Schindelin:
> Hi René,
>
> On Sat, 28 Jan 2017, René Scharfe wrote:
>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 87237b092b..66cd466eea 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -527,6 +527,16 @@ static inline int ends_with(const char *str, const char *suffix)
>>  	return strip_suffix(str, suffix, &len);
>>  }
>>
>> +#define SWAP(a, b) do {						\
>> +	void *_swap_a_ptr = &(a);				\
>> +	void *_swap_b_ptr = &(b);				\
>> +	unsigned char _swap_buffer[sizeof(a)];			\
>> +	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
>> +	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
>> +	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
>> +	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
>> +} while (0)
>> +
>>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
>
> It may seem as a matter of taste, or maybe not: I prefer this without the
> _swap_a_ptr (and I would also prefer not to use identifiers starting with
> an underscore, as section 7.1.3 Reserved Identifiers of the C99 standard
> says they are reserved):
>
> +#define SWAP(a, b) do {						\
> +	unsigned char swap_buffer_[sizeof(a)];			\
> +	memcpy(swap_buffer_, &(a), sizeof(a));			\
> +	memcpy(&(a), &(b), sizeof(a) +				\
> +	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
> +	memcpy(&(b), swap_buffer_, sizeof(a));			\
> +} while (0)

We can move the underscore to the end, but using a and b directly will 
give surprising results if the parameters have side effects.  E.g. if 
you want to swap the first two elements of two arrays you might want to 
do this:

	SWAP(*x++, *y++);
	SWAP(*x++, *y++);

And that would increment twice as much as one would guess and access 
unexpected elements.

> One idea to address the concern that not all C compilers people use to
> build Git may optimize away those memcpy()s: we could also introduce a
> SWAP_PRIMITIVE_TYPE (or SWAP2 or SIMPLE_SWAP or whatever) that accepts
> only primitive types. But since __typeof__() is not portable...

I wouldn't worry too much about such a solution before seeing that SWAP 
(even with memcpy(3) -- this function is probably optimized quite 
heavily on most platforms) causes an actual performance problem.

René
