Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DFCC11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 16:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F77F61DC1
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 16:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhF2QiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 12:38:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58807 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhF2QiN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 12:38:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B4481384C3;
        Tue, 29 Jun 2021 12:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mTofsqN/dlzr
        zkZeuQiNxzH/SSLrBoV4SqhLidUZuBg=; b=ctO8tAdUbFLp6YjHqbElp97RvwgZ
        5TFcRNK+E0pZLXQQ6ju7seYfbof1B738VFWGM+7V7R06KAPDzRQYiW8Mw0ekF6MC
        F5pjN75+rT7hxPUs5x7CVyJooXsYxS6RBDjORHSN06jF4XgjTDMsWMHUI/0DsWim
        wDZ0h9MhAemCWLk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 231081384C2;
        Tue, 29 Jun 2021 12:35:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B67F1384C1;
        Tue, 29 Jun 2021 12:35:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin <git@mfriebe.de>
Cc:     git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
Date:   Tue, 29 Jun 2021 09:35:41 -0700
In-Reply-To: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de> (Martin's
        message of "Tue, 29 Jun 2021 17:28:48 +0200")
Message-ID: <xmqqk0mcy6g2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0C495208-D8F8-11EB-80A1-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> Below is a patch, that I believe would improve the documentation of
> git switch.
>
> The exact new wording is of course open for debate.
>
> Reasoning for the change.
>
> The current doc does not explain why the option is a "forceful" option.
> Nor does explain the consequences.
>
> Instead it leaves it to the user to lookup the alternate command, and
> find the meaning of
> =C2=A0=C2=A0=C2=A0 git branch -f newbranch
>
> Only if the user does that successfully, the user may learn about the
> full consequences of their actions.
>
> I believe this info should be part of the "git switch" doc,
> itself. (Especially due to the severity that the action may have).

Please place all of the above below the three-dash line.

> From 46580d07f95a18c94925afd141ba55e52a82c8e1 Mon Sep 17 00:00:00 2001

Lose this line.

> From: Martin <User4martin@users.noreply.github.com>

Get rid of this line, too, as you have your own e-mail address on
the real "From" line of the e-mail.

> Date: Tue, 29 Jun 2021 17:22:25 +0200

This too.

> Subject: [PATCH] Update git-switch.txt

And this one, too.

>

And then justify and describe the change here (see
Documentation/SubmittingPatches::describe-changes)

Immediately before the three-dash line below, have your sign-off
(see Documentation/SubmittingPatches::sign-off).

> ---
>  Documentation/git-switch.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.tx=
t
> index 5c438cd5058758..80acafad1f4a46 100644
> --- a/Documentation/git-switch.txt
> +++ b/Documentation/git-switch.txt
> @@ -70,8 +70,12 @@ $ git switch <new-branch>
>  -C <new-branch>::
>  --force-create <new-branch>::
>  	Similar to `--create` except that if `<new-branch>` already
> -	exists, it will be reset to `<start-point>`. This is a
> -	convenient shortcut for:
> +	exists, it will be reset to `<start-point>`.
> +	This forces the branch to the new location.

I would have written "This forces the branch to point at a different
commit", as we do not have to use a fuzzy word "location" in this
context (is it a location in the directory structure in the working
tree?  is it a location in the history dag?  is it a location in
some other dimension?).

Up to this point, it makes sense.

> + It also forces
> +	any commit hold by the branch to be dropped, unless the
> +	commit is also part of any other branch too. You may
> +	therefore loose some of your data.

Aside from typo on "lose" (not "loose") and "held" (not "hold"),
this paragraph does not seem to add much value, at least to me, and
I suspect that it makes things even more confusing to new readers.

 * Repointing the branch tip to a different commit is not limited to
   "git switch -C".  Any commands that allow you to move the branch
   tip, like "git branch -f", "git checkout -B", "git push --force",
   "git reset", share the same property and singling "switch -C" out
   gives a false impression that all other commands are OK.

 * "to be dropped" is unnecessarily alarming (and not even correct).
   "gc" will not reclaim while the reflog entries hold onto them.

   "Some commits that used to be reachable from the original branch
   tip may become unreachable." would not be an incorrect
   description per-se (and would be a vast improvement over what is
   in the posted patch), but it is dubious to stress the obvious,
   especially given that the whole point of "branch -f" is to make
   wrong commits disappear by pointing at corrected commits with the
   branch tip.

Because "switch -c <new-branch>", unlike "switch <existing-branch>"
would not have to touch the working tree at all, the only reason why
the user has to force the operation by using "-C" is to override the
safety offered by "-c" that protects existing branches from accidental
overwriting.  Perhaps adding some description on "why" -c prevents
an existing branch from being overwritten would help reduce the
confusion better than an additional warning on "-C"?

Thanks.
