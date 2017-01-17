Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF4C20756
	for <e@80x24.org>; Tue, 17 Jan 2017 21:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdAQVlI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 16:41:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55325 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750922AbdAQVlH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 16:41:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EAB961BF3;
        Tue, 17 Jan 2017 16:41:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=luNPZEWxUjaQod8GuGOGG4jUYBI=; b=kARE73
        BQ3VSS2i34ijnXwS6poY/+0Pfs0WFKxCIw9BChIOyu4CE/QXxvqzhqoyV2Jm4Fzk
        5sx98O7uTPdg8s5P0vW05jSCOrwxshNV0O1bag9VnEfl5iBYT4MzN7675w6MwHlV
        pRxW9kT3MdDD7aW88xUKorbRIFwC2v4hnpPs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KfZeC/rLguMkcA2IJ+L0Ks9LxRZe8DtN
        Xy3doraWoj8VWQhTkCuJ/yp6nTCp2/cdpwmXxEF0ps7be28a/fllzHdcbNquCxvN
        F5W2XeFTzW5D4emf/lwO/xy6hMiUaHTA6vBNlAk8V6dd86j1BO5VuxNeF2uIiRAX
        6qzgcq6U9Rw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5781861BF1;
        Tue, 17 Jan 2017 16:41:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8FAC61BEF;
        Tue, 17 Jan 2017 16:41:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: clarify multi-line brace style
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
        <alpine.DEB.2.20.1701161251100.3469@virtualbox>
        <20170116160456.ltbb7ofe47xos7xo@sigill.intra.peff.net>
        <alpine.DEB.2.20.1701161746200.3469@virtualbox>
        <20170116220014.bwi5xi2br56lyqsw@sigill.intra.peff.net>
        <20170116220821.4tji5mrfcdbdpfuo@sigill.intra.peff.net>
        <xmqqfukhfpcc.fsf@gitster.mtv.corp.google.com>
        <20170117200503.3iwaedrgfq544b4i@sigill.intra.peff.net>
Date:   Tue, 17 Jan 2017 13:41:04 -0800
In-Reply-To: <20170117200503.3iwaedrgfq544b4i@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 17 Jan 2017 15:05:04 -0500")
Message-ID: <xmqqshohcqkv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6596C1C-DCFD-11E6-83BD-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah. I obviously was adapting the original text, and I think I left too
> much of the wishy-washy-ness in. As the point of the patch is to avoid
> that, let's take your suggestion. A re-rolled patch is below.
>
> Now the patch is at least self-consistent. The bigger question remains
> of: do we want to dictate these rules, or did we prefer the vague
> version?

I would say no to make all of them "rules to be dictated".  It is OK
to leave some things "gray".  

But obviously others can vote differently ;-)

> I _thought_ the vague rules were doing fine, but this whole discussion
> has made me think otherwise. And I'd just as soon not ever have to
> repeat it. ;-/
>
> OTOH, I really do not want to review a bunch of patches that do nothing
> but change brace style (and I am sure there is a mix of styles already
> in the code base).

Yes, exactly, that is why the last sentence is in there below.

>> 	When the project says it does not have strong preference
>> 	among multiple choices, you are welcome to write your new
>> 	code using any of them, as long as you are consistent with
>> 	surrounding code.  Do not change style of existing code only
>> 	to flip among these styles, though.

> The existing document says:
>
>     Make your code readable and sensible, and don't try to be clever.
>     
>     As for more concrete guidelines, just imitate the existing code
>     (this is a good guideline, no matter which project you are
>     contributing to). It is always preferable to match the _local_
>     convention. New code added to Git suite is expected to match
>     the overall style of existing code. Modifications to existing
>     code is expected to match the style the surrounding code already
>     uses (even if it doesn't match the overall style of existing code).
>     
>     But if you must have a list of rules, here they are.
>
> I guess that is the place to expound on how to interpret the rules. I
> dunno. Some of the individual rules that go into "gray areas" already
> spell out the "surrounding code" rule.


We are not saying one important thing and that was what invited
useless arguing this time: For "gray" things, the choice is yours in
your new code, but do not churn existing code for "gray" guidelines.

If we made _that_ clear as a rule we dictate, hopefully we'd have
less chance to see "a bunch of patches that do nothing but change
brace style", I would think.

> -- >8 --
> Subject: [PATCH] CodingGuidelines: clarify multi-line brace style
>
> There are some "gray areas" around when to omit braces from
> a conditional or loop body. Since that seems to have
> resulted in some arguments, let's be a little more clear
> about our preferred style.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/CodingGuidelines | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 4cd95da6b..a4191aa38 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -206,11 +206,38 @@ For C programs:
>  		x = 1;
>  	}
>  
> -   is frowned upon.  A gray area is when the statement extends
> -   over a few lines, and/or you have a lengthy comment atop of
> -   it.  Also, like in the Linux kernel, if there is a long list
> -   of "else if" statements, it can make sense to add braces to
> -   single line blocks.
> +   is frowned upon. But there are a few exceptions:
> +
> +	- When the statement extends over a few lines (e.g., a while loop
> +	  with an embedded conditional, or a comment). E.g.:
> +
> +		while (foo) {
> +			if (x)
> +				one();
> +			else
> +				two();
> +		}
> +
> +		if (foo) {
> +			/*
> +			 * This one requires some explanation,
> +			 * so we're better off with braces to make
> +			 * it obvious that the indentation is correct.
> +			 */
> +			doit();
> +		}
> +
> +	- When there are multiple arms to a conditional and some of them
> +	  require braces, enclose even a single line block in braces for
> +	  consistency. E.g.:
> +
> +		if (foo) {
> +			doit();
> +		} else {
> +			one();
> +			two();
> +			three();
> +		}
>  
>   - We try to avoid assignments in the condition of an "if" statement.
