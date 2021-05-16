Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04C0C433ED
	for <git@archiver.kernel.org>; Sun, 16 May 2021 11:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C27A26109F
	for <git@archiver.kernel.org>; Sun, 16 May 2021 11:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhEPLgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 07:36:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61251 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbhEPLf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 07:35:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A1B91339D7;
        Sun, 16 May 2021 07:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rqi13XzyI8Sn
        arh7bEXJu6NbX9f/b2/JYWjgp48DZkk=; b=x3Iqa+lYfEhjtycBYUVZAF/KF9ob
        k+/JltiYT4wOFNxXi9ogJ9YaU9WUzCiywwH92fiwdo1a2y346a6EMzs8UnTUdi80
        m18k/pY0I4jdrcfAB1xjL7UkJjUjgtUXCotdQd1VRq/nEk6INaW21YJXHeYQ1NTp
        VJWRiwo0kjAnLZ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7561C1339D6;
        Sun, 16 May 2021 07:34:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B8B51339D5;
        Sun, 16 May 2021 07:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Anders_H=C3=B6ckersten_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Anders =?utf-8?Q?H=C3=B6ckersten?= <anders@hockersten.se>
Subject: Re: [PATCH] describe-doc: clarify default length of abbreviation
References: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
Date:   Sun, 16 May 2021 20:34:37 +0900
In-Reply-To: <pull.1026.git.git.1621150366442.gitgitgadget@gmail.com>
 ("Anders
        =?utf-8?Q?H=C3=B6ckersten?= via GitGitGadget"'s message of "Sun, 16 May
 2021 07:32:45
        +0000")
Message-ID: <xmqq7djy7vzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B33EE34C-B63A-11EB-B387-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Anders H=C3=B6ckersten via GitGitGadget"  <gitgitgadget@gmail.com>
writes:

> From: =3D?UTF-8?q?Anders=3D20H=3DC3=3DB6ckersten?=3D <anders@hockersten=
.se>
>
> Clarify the default length used for the abbreviated form used for
> commits in git describe.
>
> The behavior was modified in Git 2.11.0, but the documentation was not
> updated to clarify the new behavior.
>
> Signed-off-by: Anders H=C3=B6ckersten <anders@hockersten.se>
> ---
>     describe-doc: clarify default length of abbreviation
>    =20
>     Clarify the default length used for the abbreviated form used for
>     commits in git describe.
>    =20
>     The behavior was modified in Git 2.11.0, but the documentation was =
not
>     updated to clarify the new behavior.
>    =20
>     Signed-off-by: Anders H=C3=B6ckersten anders@hockersten.se
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1=
026%2Fahockersten%2Fdescribe-doc-abbreviation-clarification-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1026=
/ahockersten/describe-doc-abbreviation-clarification-v1
> Pull-Request: https://github.com/git/git/pull/1026


.git/rebase-apply/patch:32: trailing whitespace.
	will vary according to the size of the repository with a default of=20
.git/rebase-apply/patch:34: trailing whitespace.
	as needed to form a unique object name.  An <n> of 0 will suppress=20
.git/rebase-apply/patch:46: trailing whitespace.
of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The=20
.git/rebase-apply/patch:47: trailing whitespace.
length of the abbreviation scales as the repository grows, using the=20
.git/rebase-apply/patch:48: trailing whitespace.
approximate number of objects in the repository and a bit of math=20
warning: 5 lines applied after fixing whitespace errors.
Applying: describe-doc: clarify default length of abbreviation

Will fix them up while applying, but please be careful the next
time.  A good way to double check is to do

    $ git format-patch -o my.patch origin..
    $ git checkout --detach origin
    $ git am --whitespace=3Dwarn my.patch

that is, (1) create a patch series out of the branch you have worked
on, designed to be applied on top of the origin, (2) detach HEAD at
the origin, and (3) apply the patch.  Once you are done, you can go
back to the original branch with

    $ git checkout -

The patch text looks good.

Thanks.


>  Documentation/git-describe.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-describe.txt b/Documentation/git-describ=
e.txt
> index a88f6ae2c6e7..f3f41cfac496 100644
> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -63,10 +63,11 @@ OPTIONS
>  	Automatically implies --tags.
> =20
>  --abbrev=3D<n>::
> -	Instead of using the default 7 hexadecimal digits as the
> -	abbreviated object name, use <n> digits, or as many digits
> -	as needed to form a unique object name.  An <n> of 0
> -	will suppress long format, only showing the closest tag.
> +	Instead of using the default number of hexadecimal digits (which
> +	will vary according to the size of the repository with a default of=20
> +	7) of the abbreviated object name, use <n> digits, or as many digits
> +	as needed to form a unique object name.  An <n> of 0 will suppress=20
> +	long format, only showing the closest tag.
> =20
>  --candidates=3D<n>::
>  	Instead of considering only the 10 most recent tags as
> @@ -139,8 +140,11 @@ at the end.
> =20
>  The number of additional commits is the number
>  of commits which would be displayed by "git log v1.0.4..parent".
> -The hash suffix is "-g" + unambiguous abbreviation for the tip commit
> -of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
> +The hash suffix is "-g" + an unambigous abbreviation for the tip commi=
t
> +of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`). The=20
> +length of the abbreviation scales as the repository grows, using the=20
> +approximate number of objects in the repository and a bit of math=20
> +around the birthday paradox, and defaults to a minimum of 7.
>  The "g" prefix stands for "git" and is used to allow describing the ve=
rsion of
>  a software depending on the SCM the software is managed with. This is =
useful
>  in an environment where people may use different SCMs.
>
> base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
