Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9291F40E
	for <e@80x24.org>; Thu,  4 Aug 2016 00:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbcHDAEn (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 20:04:43 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38566 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbcHDAEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 20:04:37 -0400
Received: by mail-it0-f48.google.com with SMTP id j124so249574008ith.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 17:04:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CwQ6tptH/l8QUgfJXcBdY+VqH0PjpmVVlAz4vNPcW5E=;
        b=gnAbVeh8Efm+xnwrS4nFp8NBV5b2CP3JG8nU7ARJLkJaIBtksv1qBIIST+5gZmKARP
         ujO+cKhwRkK0EvB6JsSjSVKZ0Wb6znIkH+ZKKfKnzUcK7G73PbPQ3LJkrg9SACI6xXdT
         npuQ/BR8wIDLJ2TsntyIwVSSZ1ulscO+m5pHYy36D7KSFtf1qIlaaXgoPuX3QWnt9ZUQ
         X6x9u8AHsCXFRxWt745DxSmJ9H89TYKgnlli7BMk40GFZVoXP4UiKodonPS6A1weJYFL
         OcT5FRirR+Knif9D7wZCCU4zieLH6667pCsAfZ/e1zaVcuKgG7wJ2YPsIf/0ryUsdLLj
         dmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CwQ6tptH/l8QUgfJXcBdY+VqH0PjpmVVlAz4vNPcW5E=;
        b=kqLXFc4nXN3lpqkrvFsnz5wk4BkoFYZuFsNhfWx9ZhGSqvyEFxi+/SCXUb9pTb6rfw
         P46UCjV6gWYvEf+FzCpQdpUVJkDywq+I0kWqFNNyEoUhhU/gG0SITHLmUvPAX7+JP6hy
         UPD3uKZJb+JdW5woo+H/PxvZqFjfUtwEbzQ+AZQkIPF+JT6q8CVDpAGWwaMsCDrwjK9E
         5Z2yzApQIyOH5ateGa/bOHrb9AY0l6AMi+owo/59OodVkCSrUYtY3DHZ2ezZGAGejytb
         Fip38QVeGiPUNV7HbtQveMHlHvREmyAOTkvCpXMzwf+ksyYTz2zv+wqNZ2h1iNK5ySCr
         GQ/Q==
X-Gm-Message-State: AEkoouuBFTj9/CzngTvBbIOBTdGLG95s+Zzwhehxgshd7ikR+MtHYmT27ofl75DGIq5c2qVq1qB5VRSEK+ETSaLn
X-Received: by 10.36.92.206 with SMTP id q197mr2242202itb.46.1470269075855;
 Wed, 03 Aug 2016 17:04:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 3 Aug 2016 17:04:35 -0700 (PDT)
In-Reply-To: <f84cc951-4eb0-153c-7984-fc0993d215a7@alum.mit.edu>
References: <cover.1470259583.git.mhagger@alum.mit.edu> <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kbzB-bogaqco1+fbRuoQ-4a4GBwTKkuSNnpXUxTFaxcXw@mail.gmail.com>
 <bffbbd7b-3e1b-fa6d-ed53-b75a54fd6f69@alum.mit.edu> <CAGZ79kYs9dnRzyAV_MXXUDbRCLuxQeETHKRpVsczQMCMHkQUPw@mail.gmail.com>
 <f84cc951-4eb0-153c-7984-fc0993d215a7@alum.mit.edu>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 3 Aug 2016 17:04:35 -0700
Message-ID: <CAGZ79kY40AbZ=tSRjSHtNsO26Wj9PS2AzD6qF_ZhsOF=9tzeuA@mail.gmail.com>
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in diffs
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 3, 2016 at 4:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

> This is an important point for the optimization, but less so for the
> implementation of the heuristic here. I was dynamically optimizing the
> ten other variables, and everything that goes into the bonus includes
> one of those factors. If I had also let this factor of 10 vary, then the
> net behavior of the algorithm would be completely unchanged if I would,
> say, double all eleven parameters. This is bad for optimization, because
> (1) it increases the search space unnecessarily, and (2) it means that
> whole lines in the parameter space give identical behavior, making the
> algorithm waste time searching along those lines for a minimum.
>
>> So another way to write it
>> would be
>>
>>     score - bonus/10;
>>
>> assuming the values of score and bonus are large enough.
>
> Score is the number of columns that some line is indented, so it can be
> 0 or 1 or any other positive integer. It is not "large enough", which is
> why the "10" can't be "1".

Right, I should have made it more clear that it was a hypothetical rewrite,
just to point out we are looking at only one of score or bonus.

>> but if I look at the boni definitions ranging from -63..50 they are scaled up
>> so much that the bonus may become larger than '1' unit of 'score', i.e.
>> it is not an epsilon any more. Or to put it another way:
>> If we were to s/10/100/ the results would be worse.
>
> If you would change s/10/100/ and simultaneously multiply the other
> constants by 10, the end results would be unchanged.

Right, so maybe a good name would be CONSTANT_SCALE_OF_ONE_INDENT
as it has the meaning that a bonus of 10 is equivalent of "one indent"
in the weighting.

Speaking of which, do we want to "over-optimize" to make that constant a
power of 2 as that is a supposedly faster multiplication?
(Just asking, feel free to reject; as I can imagine the numbers itself are
already magic, so why scale them with 42?^H^H^H 16?)

>
>> Rather the 10 describes the ratio of "advanced magic" to pure indentation
>> based scoring in my understanding.
>
> No, it's basically just a number against which the other constants are
> compared. E.g., if another bonus wants to balance out against exactly
> one space of indentation, its constant needs to be 10. If it wants to
> balance out against exactly 5 spaces, its constant needs to be 50. Etc.

So another interpretation is that the 10 gives the resolution for all other
constants, i.e. if we keep 10, then we can only give weights in 1/10 of
"one indent". But the "ideal" weight may not be a multiple of 1/10,
so we approximate them to the nearest multiple of 1/10.

If we were to use 1000 here, we could have a higher accuracy of the
other constants, but probably we do not care about the 3rd decimal place
for these because they are created heuristically from a corpus that may
not warrant a precision of constants with a 3rd decimal place.


Stefan
