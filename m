Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3B220A10
	for <e@80x24.org>; Sun,  1 Oct 2017 23:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbdJAX4B (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 19:56:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54742 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751430AbdJAX4A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 19:56:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41142A0873;
        Sun,  1 Oct 2017 19:55:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FoupeJXSBO6O6R3nWnLsT5Y0TTo=; b=Y0qMSv
        I5rS6DBjCBphNSbKytLaRLTV10NZcflyJwkKuWGc/HqWXZm+DajjQludhmMd2lGM
        T0lSryFn5ZeAZ2ehemo8hyu3oraTtSEnGDdiheh9n/zzS35w97kZpMk2octE0ti7
        KjiIajo1Ru1svKWDe5qjAwZmVGx1DofOSf72E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rhqrVdDYh8Gy0UO8D/k6RsX1pT0XuwEf
        mf91xHIWlHOEXTPmX7qD+jHuIhm260oZA/rjWJkuq7x5o//Oi86ynPiYr2g6HCyd
        4RrbYqr+KvocuvaV6PaMcdeRFOq8D+ftzEAX7wWprmhQ9JSNFKg0AHq48A9YCR/e
        5VeFJSFY7xA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39360A0872;
        Sun,  1 Oct 2017 19:55:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8060FA0871;
        Sun,  1 Oct 2017 19:55:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 4/6] doc: use modern "`"-style code fencing
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161852.84571-1-me@ttaylorr.com>
        <20171001161852.84571-4-me@ttaylorr.com>
Date:   Mon, 02 Oct 2017 08:55:53 +0900
In-Reply-To: <20171001161852.84571-4-me@ttaylorr.com> (Taylor Blau's message
        of "Sun, 1 Oct 2017 09:18:50 -0700")
Message-ID: <xmqqlgkutoc6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FD4A4E2-A704-11E7-9FE5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> "'"- (single-quote) styled code fencing is no longer considered modern
> within the "Documentation/" subtree.
>
> In preparation for adding additional information to this section of
> git-for-each-ref(1)'s documentation, update old-style code fencing to
> use "`"-style fencing instead.

Is this just me who wants to do s/fenc/quot/g?  Unless somebody
objects, I'd do so while queuing.

Thanks.

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/git-for-each-ref.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 323ce07de..1279b9733 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -213,12 +213,12 @@ and `date` to extract the named component.
>  The complete message in a commit and tag object is `contents`.
>  Its first line is `contents:subject`, where subject is the concatenation
>  of all lines of the commit message up to the first blank line.  The next
> -line is 'contents:body', where body is all of the lines after the first
> +line is `contents:body`, where body is all of the lines after the first
>  blank line.  The optional GPG signature is `contents:signature`.  The
>  first `N` lines of the message is obtained using `contents:lines=N`.
>  Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
> -are obtained as 'trailers' (or by using the historical alias
> -'contents:trailers').
> +are obtained as `trailers` (or by using the historical alias
> +`contents:trailers`).
>  
>  For sorting purposes, fields with numeric values sort in numeric order
>  (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
