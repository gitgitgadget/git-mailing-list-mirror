Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05E601F600
	for <e@80x24.org>; Thu, 20 Jul 2017 15:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965305AbdGTPYn (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 11:24:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62103 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965251AbdGTPYm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 11:24:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00BAAA181F;
        Thu, 20 Jul 2017 11:24:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eGKaThDOtB0M
        f+wUcMWcRKkOs70=; b=OgQabZohIn2RNdgV3DC8ORj0bz3hWykIbRm8qRbMOKv8
        /f59JJEyWKSmlVfHPdGsIjSw1/Xx/mWGg3rZzjfzmjdL5lL5S3CMv0VuZwjvkE4J
        U5DroNMric0H7Ni2HOUNlSnhrN96xLn2D5f5nVI4CrgoKP1hyDQNV0yWenrmJkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bhHbma
        m3y5DwGrb6/QnLbWORaqlSKCdJssfCCnrB0VNuk/9SefhVg/MYYZYJuF8xA2BCET
        T7nslB94YwatfNV9BxG/6Z8fUq4+QvqYpG2rxuUTB7zoVq5dyTi+M7mrhw9/lyOK
        bQMjHlUFaccgZGd+YW1I/41Miqsj61V81ejb4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECF51A181E;
        Thu, 20 Jul 2017 11:24:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32964A181C;
        Thu, 20 Jul 2017 11:24:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] RelNotes: mention that PCRE v2 exposes the same syntax
References: <20170720141927.18274-1-avarab@gmail.com>
        <xmqq7ez6hk2y.fsf@gitster.mtv.corp.google.com>
        <20170720141927.18274-5-avarab@gmail.com>
Date:   Thu, 20 Jul 2017 08:24:33 -0700
In-Reply-To: <20170720141927.18274-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 20 Jul 2017 14:19:25 +0000")
Message-ID: <xmqqzibzku6m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88C75040-6D5F-11E7-A7E7-61520C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> For someone not familiar with PCRE or having read its own
> documentation this isn't obvious, let's explicitly mention it so
> package maintainers won't fear upgrading least they break things for
> their users.

If packagers trust our assessment on one external library's backward
compatibility, our using and recommending it is sufficient to them.
If the don't trust us but rather want to verify themselves, the new
paragraph is not all that useful to them, and more importantly, we
are not in the position or business of giving extended warranty to
other people's library.

For these reasons, I'd feel a bit hesitant to add something like
this.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/RelNotes/2.14.0.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes=
/2.14.0.txt
> index 7ed93bca37..0e363f2af3 100644
> --- a/Documentation/RelNotes/2.14.0.txt
> +++ b/Documentation/RelNotes/2.14.0.txt
> @@ -28,6 +28,9 @@ Backward compatibility notes and other notable change=
s.
>     upstream PCRE maintainer has abandoned v1 maintenance for all but
>     the most critical bug fixes, use of v2 is recommended.
> =20
> +   Version v2 of the library is fully backwards compatible with the
> +   Perl-compatible regular expression syntax exposed by git (sans a
> +   few obscure bugfixes).
> =20
>  Updates since v2.13
>  -------------------
