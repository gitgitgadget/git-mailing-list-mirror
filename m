Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A3642095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933158AbdCUS0N (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:26:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64601 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933141AbdCUS0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:26:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8352A6532D;
        Tue, 21 Mar 2017 14:26:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v0fCUgkSiLlN
        Cm5N441fl4274jg=; b=pFMxnWxUlXhodFhPr9U84sS1yai/xzbOdll4GHrLfN1k
        mdq6HqFwrAmGok3TiqsA6BuWehF9SnY7De5EzxWUt/gZN4/6nBHNzqtvJOmCdSfy
        LbMtxMATY7ropGPfaJPAiAzT0t2050LFCnnm0GGOgPggT715VvP36qbc6Km1GIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=j/6mvP
        BcFatrHVv3Cc9rsXSuogVbikzJ2FmBZu0vs6xDU5q7N+LEzzI3NpTCsRrbk1F+pI
        zwVdaoqBhmx5jAGR8P8vJQlebROFeuG1QIdTPCuyCtp9sGBplWDayegU97wIq8d1
        Frbh9AD5e3Kn1I7X0RP0z0JB0AK0Wj5v328Do=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7C0426532C;
        Tue, 21 Mar 2017 14:26:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AFD656532B;
        Tue, 21 Mar 2017 14:26:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 02/16] tag doc: split up the --[no-]merged documentation
References: <20170321125901.10652-1-avarab@gmail.com>
        <20170321125901.10652-3-avarab@gmail.com>
Date:   Tue, 21 Mar 2017 11:26:03 -0700
In-Reply-To: <20170321125901.10652-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 21 Mar 2017 12:58:47 +0000")
Message-ID: <xmqq60j2qyf8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D81695DA-0E63-11E7-97BE-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Split up the --[no-]merged documentation into documentation that
> documents each option independently. This is in line with how "branch"
> and "for-each-ref" are documented, and makes subsequent changes to
> discuss the limits & caveats of each option easier to read.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---

This is consistent with a possible future (i.e. you do not have to
be the one to realize it) where "--merged A --no-merged B" can be
given together.  Makes sense.

>  Documentation/git-tag.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 33f18ea5fb..68b0ab2410 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -124,10 +124,13 @@ This option is only applicable when listing tags =
without annotation lines.
>  	Only list tags which contain the specified commit (HEAD if not
>  	specified).
> =20
> ---[no-]merged [<commit>]::
> -	Only list tags whose tips are reachable, or not reachable
> -	if `--no-merged` is used, from the specified commit (`HEAD`
> -	if not specified).
> +--merged [<commit>]::
> +	Only list tags whose tips are reachable from the specified commit
> +	(`HEAD` if not specified).
> +
> +--no-merged [<commit>]::
> +	Only list tags whose tips are not reachable from the specified
> +	commit (`HEAD` if not specified).
> =20
>  --points-at <object>::
>  	Only list tags of the given object.
