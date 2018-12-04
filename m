Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E326211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 02:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbeLDCXL (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 21:23:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56671 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLDCXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 21:23:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E60E7197FD;
        Mon,  3 Dec 2018 21:23:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3zstgorJqzna
        e+icH4qPFVOfVDY=; b=F9Rz3Lni2HuwWxpOTE+d00VZzB5TrRkVXV1qIaZTegiT
        d6BCtmn3MD9Hca7ajAL1E0k1FgOcRRpmk7/G67OxqiJtGOjh0p7nMTkMilZHETFa
        +801vB7UF5lEOqEvWcKzHrGZuKr7fLfjeD5PxGxQQaMQzb9CpRizj8TEPFtc01k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=sHIgQb
        fJKyHlZqxTNfkxWsqgnRD0+m2qJV1flLQ3KEuf/5Pdeatc2W6B60o7WIxaPF8njw
        y/jRsF0qoksSxrumkKW7I3shPhIH3dCB7EVjCUlO/Q61t5FwRzI/YUlfEhRgermZ
        phwazynFL2VL7ZokgMAKj2vRaWp98Hr4ZTFl0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE07C197FC;
        Mon,  3 Dec 2018 21:23:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CF8F197F9;
        Mon,  3 Dec 2018 21:23:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] RelNotes 2.20: move some items between sections
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
        <cover.1543868120.git.martin.agren@gmail.com>
        <d69f63b5f6d2405f455664c936f329e7971ef1cc.1543868120.git.martin.agren@gmail.com>
Date:   Tue, 04 Dec 2018 11:23:03 +0900
In-Reply-To: <d69f63b5f6d2405f455664c936f329e7971ef1cc.1543868120.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 3 Dec 2018 21:21:49
 +0100")
Message-ID: <xmqq36reghdk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 88455F3A-F76B-11E8-AD1E-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Some items that should be in "Performance, Internal Implementation,
> Development Support etc." have ended up in "UI, Workflows & Features"
> and "Fixes since v2.19". Move them, and do s/uses/use/ while at it.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---

I agree with the early half of this change; I think it is OK to
consider lack of preparation for Travis transition and lack of
better testing in the maintenance track as bugs, though.

>  Documentation/RelNotes/2.20.0.txt | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes=
/2.20.0.txt
> index b1deaf37da..e5ab8cc609 100644
> --- a/Documentation/RelNotes/2.20.0.txt
> +++ b/Documentation/RelNotes/2.20.0.txt
> @@ -137,11 +137,6 @@ UI, Workflows & Features
>     command line, or setting sendemail.suppresscc configuration
>     variable to "misc-by", can be used to disable this behaviour.
> =20
> - * Developer builds now uses -Wunused-function compilation option.
> -
> - * One of our CI tests to run with "unusual/experimental/random"
> -   settings now also uses commit-graph and midx.
> -
>   * "git mergetool" learned to take the "--[no-]gui" option, just like
>     "git difftool" does.
> =20
> @@ -185,6 +180,11 @@ UI, Workflows & Features
> =20
>  Performance, Internal Implementation, Development Support etc.
> =20
> + * Developer builds now use -Wunused-function compilation option.
> +
> + * One of our CI tests to run with "unusual/experimental/random"
> +   settings now also uses commit-graph and midx.
> +
>   * When there are too many packfiles in a repository (which is not
>     recommended), looking up an object in these would require
>     consulting many pack .idx files; a new mechanism to have a single
> @@ -387,6 +387,14 @@ Performance, Internal Implementation, Development =
Support etc.
>     two classes to ease code migration process has been proposed and
>     its support has been added to the Makefile.
> =20
> + * The "container" mode of TravisCI is going away.  Our .travis.yml
> +   file is getting prepared for the transition.
> +   (merge 32ee384be8 ss/travis-ci-force-vm-mode later to maint).
> +
> + * Our test scripts can now take the '-V' option as a synonym for the
> +   '--verbose-log' option.
> +   (merge a5f52c6dab sg/test-verbose-log later to maint).
> +
> =20
>  Fixes since v2.19
>  -----------------
> @@ -544,14 +552,6 @@ Fixes since v2.19
>     didn't make much sense.  This has been corrected.
>     (merge 669b1d2aae md/exclude-promisor-objects-fix later to maint).
> =20
> - * The "container" mode of TravisCI is going away.  Our .travis.yml
> -   file is getting prepared for the transition.
> -   (merge 32ee384be8 ss/travis-ci-force-vm-mode later to maint).
> -
> - * Our test scripts can now take the '-V' option as a synonym for the
> -   '--verbose-log' option.
> -   (merge a5f52c6dab sg/test-verbose-log later to maint).
> -
>   * A regression in Git 2.12 era made "git fsck" fall into an infinite
>     loop while processing truncated loose objects.
>     (merge 18ad13e5b2 jk/detect-truncated-zlib-input later to maint).
