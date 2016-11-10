Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFEB20229
	for <e@80x24.org>; Thu, 10 Nov 2016 22:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755916AbcKJWHe (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 17:07:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56612 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755881AbcKJWHd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 17:07:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5F594F90A;
        Thu, 10 Nov 2016 17:07:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hMfdgMcSke3Wpu2JF8OsKtfj8X8=; b=a09y1y
        BbH8uXxS1700HPIBw8Rg/zhuY1vOR/bjchLI0WxWIFXsRqFXh9A28GzK2FnvoqCw
        sBPvWKQwKXjwOCMhdy/B/4rYdpSCUJoWzAq5iLmJ4GutU8z1c643CIomY6L1wyTW
        1IsWs8eemhOWub4eo2S4NzdX/k/nmAi/+Rr5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TpRGa5RMJ1AappTjpiN+W99E2qzeU7Y/
        yXtutYtCTW8c8UUsWlnLkalNepy0vKBYEtDBg0OAlIyPUfKfGxpf392i3bmczXPG
        bo3uWH2GvSgHyCJ8uuueJRPRXXfAAK8rh67CX5Pxh3WhR6m/BfXPt240E1ANIk6z
        X1eB9dFg54o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDACE4F909;
        Thu, 10 Nov 2016 17:07:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29BFC4F908;
        Thu, 10 Nov 2016 17:07:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fill in omitted word
References: <20161104214357.32477-1-kristoffer.haugsbakk@gmail.com>
Date:   Thu, 10 Nov 2016 14:07:30 -0800
In-Reply-To: <20161104214357.32477-1-kristoffer.haugsbakk@gmail.com>
        (Kristoffer Haugsbakk's message of "Fri, 4 Nov 2016 22:43:57 +0100")
Message-ID: <xmqqd1i356ql.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13473968-A792-11E6-9E75-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com> writes:

> Signed-off-by: Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
> ---
>  Documentation/gitcore-tutorial.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> index 4546fa0..9860517 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -25,7 +25,7 @@ you want to understand Git's internals.
>  The core Git is often called "plumbing", with the prettier user
>  interfaces on top of it called "porcelain". You may not want to use the
>  plumbing directly very often, but it can be good to know what the
> -plumbing does for when the porcelain isn't flushing.
> +plumbing does for you when the porcelain isn't flushing.

I need an English teacher here to help me out, but I think this
changes the meaning of the sentence from what the original author
intended..

The way I've read this statement for the past ten years since it was
written originally at 8c7fa2478e ("Add first cut at a simple git
tutorial.", 2005-05-31) and then slightly reworded at f35ca9ed3e
("tutorial.txt: start describing how to copy repositories",
2005-06-01) is that 

 * there are unfortunate occasions in which the porcelain is not
   flushing, and 

 * the knowledge of what the plumbing does is a good thing to have
   for such occasions.  It will help you figure out what needs to be
   done.

The rewritten text means a very different thing, at least to me.

 * there are things plumbing does for you.

 * the knowledge of what they are helps when the porcelain isn't
   flushing.

Just dropping "for" instead of adding "you" may make it easier to
read, grammatically more correct and retain the original intent
better, I suspect.

