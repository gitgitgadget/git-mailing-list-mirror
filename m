Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B5C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D27964E79
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 19:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBRTcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:32:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58069 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbhBRSwj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 13:52:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 570DAB08B4;
        Thu, 18 Feb 2021 13:51:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pMiYfczPNuKk
        N4mGSbGf1xO4I4Y=; b=v5T0+pbY/7RcyHHocUUkD9nGgIMpUnbI6WbFYvIP+ukH
        CzNxV5mzXz3PMLQD3SSyRdY9NAYm2w6HDXjtcJKoxJfqjBz3l+nAd8TX7IdfZ5N5
        dDXpGNFj+ZxeCekeqQe47ky2BEPpq8GM3+RIMsUXJYpaunRaN4gPKoa+P2tjWSc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ryLPQR
        0pKaFfkMbiRs5wJ0Rwh5pO7qlg2VXREDLsNsxKbRAvU+MHCKXP0ypBO8GyorjlwO
        3JLseRSaFYu3WzCKIwxJJKUwivuF23m3ERwgb8kKJ+I+lHEcttYAmsnkyHdbbygs
        1g/hBRfk4NS+/qC02B/Qhar/8cUa6fZiGF6Lk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D485B08B3;
        Thu, 18 Feb 2021 13:51:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C90FAB08B2;
        Thu, 18 Feb 2021 13:51:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/3] git.txt: fix monospace rendering
References: <cover.1613590761.git.martin.agren@gmail.com>
        <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
Date:   Thu, 18 Feb 2021 10:51:52 -0800
In-Reply-To: <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 17 Feb 2021 20:56:05
 +0100")
Message-ID: <xmqqim6pgqev.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5D815804-721A-11EB-A928-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> When we write `<name>`s with the "s" tucked on to the closing backtick,
> we end up rendering the backticks literally. Rephrase this sentence
> slightly to render this as monospace.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  doc-diff:
>  --- a/.../man/man1/git.1
>  +++ b/.../man/man1/git.1
>  @@ -77,8 +77,8 @@ OPTIONS
>              setting the value to an empty string, instead the environm=
ent
>              variable itself must be set to the empty string. It is an =
error if
>              the <envvar> does not exist in the environment.  <envvar> =
may not
>  -           contain an equals sign to avoid ambiguity with `<name>`s w=
hich
>  -           contain one.
>  +           contain an equals sign to avoid ambiguity with <name> cont=
aining
>  +           one.
> =20
>              This is useful for cases where you want to pass transitory
>              configuration options to git, but are doing so on OS=E2=80=
=99s where other
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d36e6fd482..3a9c44987f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -88,7 +88,7 @@ foo.bar=3D ...`) sets `foo.bar` to the empty string w=
hich `git config
>  	empty string, instead the environment variable itself must be
>  	set to the empty string.  It is an error if the `<envvar>` does not e=
xist
>  	in the environment. `<envvar>` may not contain an equals sign
> -	to avoid ambiguity with `<name>`s which contain one.
> +	to avoid ambiguity with `<name>` containing one.
>  +
>  This is useful for cases where you want to pass transitory
>  configuration options to git, but are doing so on OS's where

The "two" diffs may indeed be misleading.

The patch only changes one source and the "supporting material" is
not something that we need to use on the source file---it is only
showing the change in the output.

I did appreciate the inclusion of doc-diff myself, but it seems that
it confused Chris and Patrick.  I doubt that it is an improvement to
omit doc-diff.  We may want to find a way to make it easier for the
readers to tell which part is the patch to be applied and which part
is not in similar changes we discuss on the list in the future, and
apparently, a one column indentation alone was not quite sufficient
in this case.  Replacing "doc-diff:" label and patch header lines up
to the hunk header with a prose to explain what the intended diff is
may have helped, e.g.


...
slightly to render this as monospace.

Signed-off-by: A U Thor <au@thor.xz>
---

 The rendered output changes like the following excerpt from
 doc-diff output.

             ....  <envvar> may not
 -           contain an equals sign to avoid ambiguity with `<name>`s whi=
ch
 -           contain one.
 +           contain an equals sign to avoid ambiguity with <name> contai=
ning
 +           one.

 You can see that backquotes are gone, even though you unfortunately
 cannot see how <name> is typeset (it is in monospace--trust me ;-).

 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/....=20
index ....
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ ...
