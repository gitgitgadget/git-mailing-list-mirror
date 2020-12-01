Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32401C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F6C20643
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 18:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lgZvBM3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgLAS6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 13:58:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57268 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLAS6A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 13:58:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6293B10D60B;
        Tue,  1 Dec 2020 13:57:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1bZgpOLLekmJ
        G8wdBgts5QrK1wk=; b=lgZvBM3UBBLAZfe65USpWc9U4/8a+kI1HMMfSpzk/UJd
        D7b+ch9hMRHyi+gcCCjyu1hipvLq5bjqPPRKg7SHolUeKIrV0EWS1cj6Yi8Qztwc
        Cc5gK6VRgh2OvW1VmUKymIx027GqPGluvP69hZL1IXrkeUCBwA3lAfDausYaxk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NpmzSO
        A/pt33abENzTDFXHHc2kvXQQWBD3OtY1ktgwV5fEzU4q/DAx9xRd1VYhQ5LqV+02
        dz3yxuSbhJUiKbhzh+Xf2CMmO/sAy9Zfp2TOrA93TMIlisZJ7WOv6FISC6ThCXrx
        WxkjQR7/X21M0cnKS1GHOFxXj5GYTXTkstoj4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A35310D60A;
        Tue,  1 Dec 2020 13:57:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6FFCF10D609;
        Tue,  1 Dec 2020 13:57:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] cook: add github.com/git-vcs/git as a URL
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
        <20201201094623.4290-1-avarab@gmail.com>
Date:   Tue, 01 Dec 2020 10:57:12 -0800
In-Reply-To: <20201201094623.4290-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 1 Dec 2020 10:46:23 +0100")
Message-ID: <xmqq7dq1qrqv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 069432EC-3407-11EB-A1FF-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

As Peff noticed, the typo in the title is at exactly the right place
as if designed to confuse all readers.  I had to read the body twice
before I realized s/hub/lab/ is needed.

> I maintain this mirror, but hopefully we can make it semi-official. It

As Peff hinted, all the current list entries are repositories I push
into directly, and obviously I do not want to increase the number of
such direct non-mirrors (I managed to drop sourceforge some time ago
and I was happy).  But the list is described with a weasel-out
phrase "My public ... repositories are (mirrored) at:", hinting that
some of the entries can be mere mirrors.  To most end-users, as long
as the contents are genuine and lag is minimum, it makes no
difference if it is a mirror or a directly pushed non-mirror, I
would think.

So it is OK to add one, as long as it benefits the community.

I would consider adding this repository to the list only if it is
hosted on GitLab's infrastructure with commitment from GitLab to
back it officially, as opposed to a mirror being maintained by a
random GitLab user running a cronjob.  What I expect is that the
former would get transfer quota boost if/when the mirror gets
popular enough while the latter would probably not, and I would like
to make sure we advertise to our users a service that they can rely
on.

> has the same refs as the GitHub one except for the GitHub "pull" refs:
>
>     $ diff -u \
>         <(git ls-remote https://gitlab.com/git-vcs/git.git/) \
>         <(git ls-remote https://github.com/git/git/|grep -v refs/pull)
>     $
>
> Although I had to delete the stale "pu" manually just now.
>
> As an aside there are also https://gitlab.com/gitlab-org/git and
> https://gitlab.com/git-vcs/git which mostly mirror but also carry some
> GitLab Employee topic branches.

These I suspect falls into "are we advertising a service of a
company, or are we offering service to the community?" bin.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  MaintNotes | 1 +
>  cook       | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/MaintNotes b/MaintNotes
> index 0dc03080de..bb3064e9ac 100644
> --- a/MaintNotes
> +++ b/MaintNotes
> @@ -136,6 +136,7 @@ My public git.git repositories are (mirrored) at:
>    https://kernel.googlesource.com/pub/scm/git/git
>    git://repo.or.cz/alt-git.git/
>    https://github.com/git/git/
> +  https://gitlab.com/git-vcs/git/
> =20
>  This one shows not just the main integration branches, but also
>  individual topics broken out:
> diff --git a/cook b/cook
> index 03ac0cfbe4..2258390114 100755
> --- a/cook
> +++ b/cook
> @@ -295,8 +295,8 @@ the integration branches, but I am still holding on=
to them.
> =20
> =20
>  Copies of the source code to Git live in many repositories, and the
> -following is a list of the ones I push into.  Some repositories have
> -only a subset of branches.
> +following is a list of the ones I push into or their mirrors.  Some
> +repositories have only a subset of branches.

This harmonises the description with the phrase used in MaintNotes,
and because "What's cooking" is issued much more often than the "A
note from the maintainer", it matters more to have the new entry
here (having said that, the text here is only used when starting
"What's cooking" from scratch, and because we have already issued
many many issues of "What's cooking" report so far, it makes no
difference to edit the text above and list below with this patch).

>  With maint, master, next, seen, todo:
> =20
> @@ -304,6 +304,7 @@ With maint, master, next, seen, todo:
>  	git://repo.or.cz/alt-git.git/
>  	https://kernel.googlesource.com/pub/scm/git/git/
>  	https://github.com/git/git/
> +	https://gitlab.com/git-vcs/git/
> =20
>  With all the integration branches and topics broken out:
