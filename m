Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE8581F600
	for <e@80x24.org>; Thu, 20 Jul 2017 15:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965507AbdGTP0g (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 11:26:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51473 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965003AbdGTP0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 11:26:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E7E476702;
        Thu, 20 Jul 2017 11:26:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WN9JlKRtbOBs
        GCh802gg4CBJjgk=; b=CYZ9JGmw5US/t08K2u3UrHQmdhAEh8sQvHJHq/KV/KRJ
        S3uJ4uHEugwxcr2//NSYZ/KwGAkZmSR/fcYLYAawP+Zj+hx5VA55AsmBoGXxGxJr
        z++AQMLrDiG1axnAQk15VNrP5drlC+GEg6I5fQuLt1pkD5hor53gZzt8bfquEqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jxNzK4
        58+RKotJEzGZmFNNrZaG2I36gkOcPqNvpsAJ1A3M5KM66MxFQCS2SZap4O3XIW/8
        uf4BsvCwaRpmPsI2x/6eg6T2z7eoHveovj/qR4FNg7abdBJIdD8kRQP7P4czMsO1
        diwm7f/a9YT1TDtRgpEc5tAP6FmsWRQTsMjqY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15B2B76701;
        Thu, 20 Jul 2017 11:26:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72ECF76700;
        Thu, 20 Jul 2017 11:26:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] RelNotes: remove duplicate mention of PCRE v2
References: <20170720141927.18274-1-avarab@gmail.com>
        <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
        <20170720141927.18274-6-avarab@gmail.com>
Date:   Thu, 20 Jul 2017 08:26:32 -0700
In-Reply-To: <20170720141927.18274-6-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jul 2017 14:19:26 +0000")
Message-ID: <xmqqvamnku3b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CFDD72DE-6D5F-11E7-AB8B-EFB41968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> That we can link to PCRE v2 is already covered above in "Backward
> compatibility notes and other notable changes", no need to mention it
> twice.

This is actually deliberate, as I'd prefer to have a description
that is written at the same detail-level (i.e. "just a bullet item,
if you want to know more, go read the doc") as the other items in
the list, whether a more detailed description is given elsewhere.



> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/RelNotes/2.14.0.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes=
/2.14.0.txt
> index 0e363f2af3..fb6a3dba31 100644
> --- a/Documentation/RelNotes/2.14.0.txt
> +++ b/Documentation/RelNotes/2.14.0.txt
> @@ -88,8 +88,7 @@ UI, Workflows & Features
>     learned to say "it's a pathspec" a bit more often when the syntax
>     looks like so.
> =20
> - * Update "perl-compatible regular expression" support to enable JIT
> -   and also allow linking with the newer PCRE v2 library.
> + * Update "perl-compatible regular expression" support to enable JIT.
> =20
>   * "filter-branch" learned a pseudo filter "--setup" that can be used
>     to define common functions/variables that can be used by other
