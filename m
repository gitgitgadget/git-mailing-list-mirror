Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B8F6209B8
	for <e@80x24.org>; Tue, 12 Sep 2017 02:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbdILC2T (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 22:28:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59780 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751045AbdILC2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 22:28:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAC94A496B;
        Mon, 11 Sep 2017 22:28:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nkvc37EbIjwO9cdEziln9Q7+rVE=; b=wqkh2G
        cHF/Wo1L54KbJp8qXxL6KnRO3D7tHca1uKi4nPfbFr4p4f6XeUdfnZEEwnUgzf4C
        sRq24pooRGbQvuW8lA32SNeGXQHPZSjrpiwTl7lRGjASNMM/ylY1Hf7JGqrvvHpc
        opmMS1ORtOhJ6mkBctiBP9MjqIGyzxOmtUHD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ExjaSCSKlI2oOeLiGil2qs2Ky2W+qdxt
        /SQq9MdKHuKqE6DX9EIfGmF33QI7/vAH032ttLegSIp77LHF/SPQIgGw50oBDzOm
        ovlEZe0/2B8IOmENz9qXzCvM84iPx7qJoQ/atmqD6//iP34fCZQ0yZ8AKCzZZKuC
        mqXxwpvy5CU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3A67A4969;
        Mon, 11 Sep 2017 22:28:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 143F8A4967;
        Mon, 11 Sep 2017 22:28:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/2] doc/for-each-ref: consistently use '=' to between argument names and values
References: <20170901144931.26114-1-me@ikke.info>
        <20170911193338.25985-1-me@ikke.info>
Date:   Tue, 12 Sep 2017 11:28:00 +0900
In-Reply-To: <20170911193338.25985-1-me@ikke.info> (Kevin Daudt's message of
        "Mon, 11 Sep 2017 21:33:37 +0200")
Message-ID: <xmqq8thk3b2n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08F5991C-9762-11E7-A0A9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> The synopsis and description inconsistently add a '=' between the
> argument name and it's value. Make this consistent.
>
> Signed-off-by: Kevin Daudt <me@ikke.info>
> ---
>  Documentation/git-for-each-ref.txt | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Good idea, and I think it is in line with an earlier suggestion by
Jonathan (cc'ed).

Thanks.

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index bb370c9c7..1015c88f6 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -10,8 +10,9 @@ SYNOPSIS
>  [verse]
>  'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
>  		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
> -		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
> -		   [--contains [<object>]] [--no-contains [<object>]]
> +		   [--points-at=<object>]
> +		   (--merged[=<object>] | --no-merged[=<object>])
> +		   [--contains[=<object>]] [--no-contains[=<object>]]
>  
>  DESCRIPTION
>  -----------
> @@ -65,24 +66,24 @@ OPTIONS
>  	the specified host language.  This is meant to produce
>  	a scriptlet that can directly be `eval`ed.
>  
> ---points-at <object>::
> +--points-at=<object>::
>  	Only list refs which points at the given object.
>  
> ---merged [<object>]::
> +--merged[=<object>]::
>  	Only list refs whose tips are reachable from the
>  	specified commit (HEAD if not specified),
>  	incompatible with `--no-merged`.
>  
> ---no-merged [<object>]::
> +--no-merged[=<object>]::
>  	Only list refs whose tips are not reachable from the
>  	specified commit (HEAD if not specified),
>  	incompatible with `--merged`.
>  
> ---contains [<object>]::
> +--contains[=<object>]::
>  	Only list refs which contain the specified commit (HEAD if not
>  	specified).
>  
> ---no-contains [<object>]::
> +--no-contains[=<object>]::
>  	Only list refs which don't contain the specified commit (HEAD
>  	if not specified).
