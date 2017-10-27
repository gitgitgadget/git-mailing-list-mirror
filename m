Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474E6202A0
	for <e@80x24.org>; Fri, 27 Oct 2017 01:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbdJ0B3c (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 21:29:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59267 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751457AbdJ0B3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 21:29:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFF70AE1E4;
        Thu, 26 Oct 2017 21:29:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xNCtlJa99ITi
        Pk7Rd5lWWN2rfx0=; b=u/Hn3taC7k+Cqlj2SoqrzW+4bjr7s0S0rWTP4yJcuYf5
        c0ot3sL7f8DsJKVZkJxu62AKn4N+CEI1uS3W7HhZeuQF3wpJxpPLR6DsWMofTcEU
        kgpv/mG6Q7MExMFLjPEG89REGDD1QDZ9Ilrc1JBCckLmdvVl3QUHk5JapBr4TEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IX6uVN
        PX9tqD09EXHAe7sNk73cxCSyKWwC1sfg50G588hqlEF1K5BEnWPpGT5udAfNAGuN
        rACy/2fbnMgA+BTOVQyZQSlPLg7b7WTGCBFhHUXM4y+2t6Fhq6WIdt7k6Jc/F9/n
        C/a5Fu3mSf1NtN4JNS8k5x/T5WFJZAN8hH13M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A81C5AE1E3;
        Thu, 26 Oct 2017 21:29:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21460AE1E2;
        Thu, 26 Oct 2017 21:29:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rev-list-options.txt: use correct directional reference
References: <20171026152637.21629-1-szeder.dev@gmail.com>
Date:   Fri, 27 Oct 2017 10:29:28 +0900
In-Reply-To: <20171026152637.21629-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 26 Oct 2017 17:26:37 +0200")
Message-ID: <xmqq4lqle5tz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 47529792-BAB6-11E7-9CD5-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> The descriptions of the options '--parents', '--children' and
> '--graph' say "see 'History Simplification' below", although the
> referred section is in fact above the description of these options.
>
> Send readers in the right direction by saying "above" instead of
> "below".
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---

Thanks. =20

It turns out that this is not a recent regression, but was done at
f98fd436 ("git-log.txt,rev-list-options.txt: put option blocks in
proper order", 2011-03-08), which moved Commit Formatting and Diff
Formatting sections, which used to appear very early, to near the
end of the sequence.

>  Documentation/rev-list-options.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-lis=
t-options.txt
> index 7d860bfca..13501e155 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -799,11 +799,11 @@ endif::git-rev-list[]
> =20
>  --parents::
>  	Print also the parents of the commit (in the form "commit parent...")=
.
> -	Also enables parent rewriting, see 'History Simplification' below.
> +	Also enables parent rewriting, see 'History Simplification' above.
> =20
>  --children::
>  	Print also the children of the commit (in the form "commit child...")=
.
> -	Also enables parent rewriting, see 'History Simplification' below.
> +	Also enables parent rewriting, see 'History Simplification' above.
> =20
>  ifdef::git-rev-list[]
>  --timestamp::
> @@ -846,7 +846,7 @@ you would get an output like this:
>  	to be drawn properly.
>  	Cannot be combined with `--no-walk`.
>  +
> -This enables parent rewriting, see 'History Simplification' below.
> +This enables parent rewriting, see 'History Simplification' above.
>  +
>  This implies the `--topo-order` option by default, but the
>  `--date-order` option may also be specified.
