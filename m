Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A596A1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 16:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfHAQA3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 12:00:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53847 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfHAQA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 12:00:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E2DE14F8B0;
        Thu,  1 Aug 2019 11:57:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dA7FvNBuiD7B
        JvQ2yvVSeuLSFTY=; b=ZloMwb4WCEXk2dJVSCCOZ9U7T9R5RirnOTKHhE6X3W7a
        lvUU8pg9Cz2zWmXspYCwFsQF1tbKD6281QIzS0jYWC/qMJsxSWArLAmEFT2OhZGc
        8aPr94CzvEM5G10zM8H2TUrKWb4/p9AoTuK6HVMHdJl8sBuO87w3RgDWvVOkPl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yZxy3b
        pQBb9lCjXih9NiW632R+7Yp1jcsGTrJoNJPYRPmTZiLTCqDI7mG+s5F69S9R5kfm
        uPr3WOjf7zq6HYFVZfOFFneyIpv6EpsdWxzwBhBbyy6EZeXHqkqFqXfpd/GTfT/F
        VljVF5Fkbkh8tGhK4IGJXujkseg6Lxcl8dcjw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 560A914F8AF;
        Thu,  1 Aug 2019 11:57:06 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A71A814F8AC;
        Thu,  1 Aug 2019 11:57:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RelNotes/2.23.0: fix a few typos and other minor issues
In-Reply-To: <20190801141221.3626-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Thu, 1 Aug 2019 16:12:20 +0200")
References: <xmqqh874tssp.fsf@gitster-ct.c.googlers.com>
        <20190801141221.3626-1-martin.agren@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date:   Thu, 01 Aug 2019 08:57:04 -0700
Message-ID: <xmqq8sscop4f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 02766D8C-B475-11E9-9993-72EEE64BB12D-77302942!pb-smtp2.pobox.com
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

Thanks, but it would have been better for this to be in two
patches.  I'll split them up.


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
