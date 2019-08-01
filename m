Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BCF51F732
	for <e@80x24.org>; Thu,  1 Aug 2019 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfHAP6Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:58:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53436 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732315AbfHAP4i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:56:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 779A9872E1;
        Thu,  1 Aug 2019 11:56:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=czFgz07WMsEw
        8y3z3+tagi68xz0=; b=Uq6HoIHHkn93V/ORYeW12FJR6qGBJ1EmCQf7GVyRu7tq
        Z8UXN3XSoj2jlBocwJcfXpmJXH7FBYuhsH/JqIo7LZeTeQXAlcI+4xQzvKDZDgP9
        k0Vot4h6+vm8vMEpdmwJlQzqc0ZE+LyM6XxrCahCzozyPMz/WCDMsAT2TZ62mDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=hTXKdF
        SAq1ZgnxbdtHXrTwgSjk5fuHsUua/lcX5UotbQBh6bNcwkufjaIqi5TkMEAy6NjF
        jDV8YIZoQo9UHlRyzjo7Ck0w6GCAkbPNXYRmw0h04jEb4P1zL2d3yWmZuYAFnn4O
        /YATxO0qYW6wOkccZTZBgAT9scM0ME0ozNmfc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 700DA872E0;
        Thu,  1 Aug 2019 11:56:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90D5A872DF;
        Thu,  1 Aug 2019 11:56:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes/2.23.0: fix a few typos and other minor issues
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
        <20190801141221.3626-1-martin.agren@gmail.com>
Date:   Thu, 01 Aug 2019 08:56:30 -0700
In-Reply-To: <20190801141221.3626-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Thu, 1 Aug 2019 16:12:20 +0200")
Message-ID: <xmqqa7csop5d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EEBD09AE-B474-11E9-BEC8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Fix the spelling of the new "--no-show-forced-updates" option that "git
> fetch/pull" learned. Similarly, spell "--function-context" correctly an=
d
> fix a few typos, grammos and minor mistakes.
>
> One of these is also in 2.22.1.txt, so fix it there too.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>

Thanks.

> ---
>  Documentation/RelNotes/2.22.1.txt |  2 +-
>  Documentation/RelNotes/2.23.0.txt | 14 +++++++-------
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.22.1.txt b/Documentation/RelNotes=
/2.22.1.txt
> index 78b2c5ea8a..76dd8fb578 100644
> --- a/Documentation/RelNotes/2.22.1.txt
> +++ b/Documentation/RelNotes/2.22.1.txt
> @@ -94,7 +94,7 @@ Fixes since v2.22
> =20
>   * The configuration variable rebase.rescheduleFailedExec should be
>     effective only while running an interactive rebase and should not
> -   affect anything when running an non-interactive one, which was not
> +   affect anything when running a non-interactive one, which was not
>     the case.  This has been corrected.
> =20
>   * "git submodule foreach" did not protect command line options passed
> diff --git a/Documentation/RelNotes/2.23.0.txt b/Documentation/RelNotes=
/2.23.0.txt
> index 19e894a44e..e1b1ce5680 100644
> --- a/Documentation/RelNotes/2.23.0.txt
> +++ b/Documentation/RelNotes/2.23.0.txt
> @@ -52,7 +52,7 @@ UI, Workflows & Features
> =20
>   * "git fetch" and "git pull" reports when a fetch results in
>     non-fast-forward updates to let the user notice unusual situation.
> -   The commands learned "--no-shown-forced-updates" option to disable
> +   The commands learned "--no-show-forced-updates" option to disable
>     this safety feature.
> =20
>   * Two new commands "git switch" and "git restore" are introduced to
> @@ -68,7 +68,7 @@ UI, Workflows & Features
>   * The conditional inclusion mechanism learned to base the choice on
>     the branch the HEAD currently is on.
> =20
> - * "git rev-list --objects" learned with "--no-object-names" option to
> + * "git rev-list --objects" learned the "--no-object-names" option to
>     squelch the path to the object that is used as a grouping hint for
>     pack-objects.
> =20
> @@ -106,7 +106,7 @@ Performance, Internal Implementation, Development S=
upport etc.
>     no longer be used.
> =20
>   * Developer support to emulate unsatisfied prerequisites in tests to
> -   ensure that the remainer of the tests still succeeds when tests
> +   ensure that the remainder of the tests still succeeds when tests
>     with prerequisites are skipped.
> =20
>   * "git update-server-info" learned not to rewrite the file with the
> @@ -121,7 +121,7 @@ Performance, Internal Implementation, Development S=
upport etc.
>   * Prepare use of reachability index in topological walker that works
>     on a range (A..B).
> =20
> - * A new tutorial targetting specifically aspiring git-core
> + * A new tutorial targeting specifically aspiring git-core
>     developers has been added.
> =20
>   * Auto-detect how to tell HP-UX aCC where to use dynamically linked
> @@ -181,7 +181,7 @@ Fixes since v2.22
>     the same repository was corrupt, which has been corrected.
> =20
>   * The ownership rule for the file descriptor to fast-import remote
> -   backend was mixed up, leading to unrelated file descriptor getting
> +   backend was mixed up, leading to an unrelated file descriptor getti=
ng
>     closed, which has been fixed.
> =20
>   * A "merge -c" instruction during "git rebase --rebase-merges" should
> @@ -306,7 +306,7 @@ Fixes since v2.22
> =20
>   * The configuration variable rebase.rescheduleFailedExec should be
>     effective only while running an interactive rebase and should not
> -   affect anything when running an non-interactive one, which was not
> +   affect anything when running a non-interactive one, which was not
>     the case.  This has been corrected.
> =20
>   * The "git clone" documentation refers to command line options in its
> @@ -339,7 +339,7 @@ Fixes since v2.22
>     having to consult the other end, which has been corrected.
> =20
>   * The internal diff machinery can be made to read out of bounds while
> -   looking for --funcion-context line in a corner case, which has been
> +   looking for --function-context line in a corner case, which has bee=
n
>     corrected.
>     (merge b777f3fd61 jk/xdiff-clamp-funcname-context-index later to ma=
int).
