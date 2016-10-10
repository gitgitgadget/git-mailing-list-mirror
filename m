Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261B820989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbcJJT7m (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:59:42 -0400
Received: from mout.web.de ([212.227.17.11]:58283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbcJJT7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:59:41 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MYeys-1bODZq2puc-00VOFe; Mon, 10 Oct 2016 21:59:28
 +0200
Subject: Re: [PATCH] pretty: respect color settings for %C placeholders
To:     Jeff King <peff@peff.net>
References: <cb81631e-9623-9020-f955-ec215b493a50@hale.ee>
 <f35965e9-2901-b9b5-92e5-9bc7fe673637@web.de>
 <65d8def3-df62-6c45-7d8f-79b6a8769bf5@hale.ee>
 <25c17e16-2456-7da3-ae22-2dc812a3aa0d@web.de>
 <20161009234617.y6xfjyv6xjkf2afi@sigill.intra.peff.net>
 <CACsJy8CroyynVMctbPhuVr2VVQB7YyfcxDaMT25BikQ4R4We0Q@mail.gmail.com>
 <20161010142818.lglwrxpks6l6aqrm@sigill.intra.peff.net>
 <20161010151517.6wszhuyp57yfncaj@sigill.intra.peff.net>
 <42b3be14-fadb-4801-f377-59fb42b7ccdf@web.de>
 <20161010174257.b4uxplavefjyr6rl@sigill.intra.peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, Tom Hale <tom@hale.ee>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <19e59db7-f3dd-35ec-8cf1-b070b1c05abe@web.de>
Date:   Mon, 10 Oct 2016 21:59:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161010174257.b4uxplavefjyr6rl@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7dRr1SPQIcpysdrf2RVfgNMCxaYJ0HV9d6TUCF2pYbJNsFmmiKx
 fXiZrP+bFU3U12PgSaBso+DBRyfAUvsD55EAsVfD5hKd5jITre7TjKuk+xh13QKsMtZoTeJ
 22RqrT6QnCzm5MUFSp3eOW2NQdvuwq6v84On+kjFaGG+6Eo/hJeWAGaPQb5CkkQ9qmpIko+
 fD/mjyycfsq7jVq3ILLdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MuRgzcg6k+o=:ZTu/KRN1Rf14HGACZKVAdK
 1Vk/Xeb83bd2vslvXjywhaL5q02Sd9FkHkvPLlvhaEr4h8CmdzwaO9SKaXajXkvknvl+9L7mJ
 bLPS6pjEhS5jy7v6CBlgjiHkV5g9Jo7d6GJbLZ/FsQqAeDE3Y0fUno3tbw8eBtpSLYZfU8DeS
 3r/Uri1+/ZWReR8gPiX9F7Swbz7fUQhBHUXxZNIgeUp4+lukPGJYEqDPVHNfqGCG+rx2VynPQ
 AKLoydprkVv+ABrRzJFw4cGRABODs8knbnLeOky+vkapBiFhQhxc9BLyd2lT9gzcWKKWARkM0
 nFCXay93qp2flsZug2HBbBwjkxEgcu06gimUydO08/6FiToDZeyn0XzkJZgjk7SaBTfF6YWo3
 VbIoXM9/KZACX+7Q4vGlN1CLYapp6JsL/CDeUrDSFJGzs3vyMk0rJD38hbNpaRBhNUcW6M9rf
 VKVgpofDEw9v172WhiGTyZovT7Tl5CiwGNYzUSdTz8q2vex1RuUvCS/9FLjFeEVt/FRDufYOe
 TqjzRXfrVjxevIcN9JxCs5J1PEhtj5NFopUmXItTy6iDG2RKiuV8DlPbDDvARf5bJ144//0zu
 xX1F/SCBfZWAHEkBZkROsGjNaJfQb2+dZB9zVwswjFF/Mc0SO1EWCxRpAHnbE5TrXMzuQJGkJ
 hxk+mmwWRnV6dE5cgfDmSXihe8eFA7T1jsB6b3kh5k9Bd74mftubEpMwNtxGO5DQNKcZljkZV
 j/+rLUGRjjkTzXSLX//MKlNajVnEzP9tLTVVeFGrSCUIuKlDTeO82yiYs9oaWpIpjCCEc5pkB
 C6//LIt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.10.2016 um 19:42 schrieb Jeff King:
> On Mon, Oct 10, 2016 at 07:09:12PM +0200, René Scharfe wrote:
>
>>> diff --git a/pretty.c b/pretty.c
>>> index 25efbca..73e58b5 100644
>>> --- a/pretty.c
>>> +++ b/pretty.c
>>> @@ -965,22 +965,31 @@ static size_t parse_color(struct strbuf *sb, /* in UTF-8 */
>>>
>>>  		if (!end)
>>>  			return 0;
>>> -		if (skip_prefix(begin, "auto,", &begin)) {
>>> +
>>> +		if (!skip_prefix(begin, "always,", &begin)) {
>>>  			if (!want_color(c->pretty_ctx->color))
>>>  				return end - placeholder + 1;
>>>  		}
>>
>> Shouldn't we have an "else" here?
>
> I'm not sure what you mean; can you write it out?

 > -		if (skip_prefix(begin, "auto,", &begin)) {
 > +
 > +		if (!skip_prefix(begin, "always,", &begin)) {
 >  			if (!want_color(c->pretty_ctx->color))
 >  				return end - placeholder + 1;
 >  		}

		else {	/* here */

 > +		/* this is a historical noop */
 > +		skip_prefix(begin, "auto,", &begin);

		}

Otherwise "always,auto," would be allowed and mean the same as 
"always,", which just seems wrong.  Not a biggie.

>>> -	if (skip_prefix(placeholder + 1, "red", &rest))
>>> +	if (skip_prefix(placeholder + 1, "red", &rest) &&
>>> +	    want_color(c->pretty_ctx->color))
>>>  		strbuf_addstr(sb, GIT_COLOR_RED);
>>> -	else if (skip_prefix(placeholder + 1, "green", &rest))
>>> +	else if (skip_prefix(placeholder + 1, "green", &rest) &&
>>> +		 want_color(c->pretty_ctx->color))
>>>  		strbuf_addstr(sb, GIT_COLOR_GREEN);
>>> -	else if (skip_prefix(placeholder + 1, "blue", &rest))
>>> +	else if (skip_prefix(placeholder + 1, "blue", &rest) &&
>>> +		 want_color(c->pretty_ctx->color))
>>>  		strbuf_addstr(sb, GIT_COLOR_BLUE);
>>> -	else if (skip_prefix(placeholder + 1, "reset", &rest))
>>> +	else if (skip_prefix(placeholder + 1, "reset", &rest) &&
>>> +		 want_color(c->pretty_ctx->color))
>>>  		strbuf_addstr(sb, GIT_COLOR_RESET);
>>>  	return rest - placeholder;
>>>  }
>>
>> Perhaps it's a funtion like add_color(sb, ctx, color) or similar would be
>> nice?
>
> I actually wrote it that way first (I called it "maybe_add_color()"),
> but it felt a little funny to have a separate function that people might
> be tempted to reuse (the right solution is generally to check
> want_color() early as above, but we can't do that here because we have
> to find the end of each placeholder).

OK.  A variable then?  Lazy pseudo-code:

	if (RED)
		color = red;
	else if (GREEN)
		...

	if (want_color())
		strbuf_addstr(sb, color);

> What I have here is a little funny, too, though, as it keeps trying
> other color names if it finds "red" but want_color() returns 0.

Oh, missed that somehow.. O_o
