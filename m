Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62303C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 22:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbiBPWMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:12:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiBPWMg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 17:12:36 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAFE107D0D
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 14:12:23 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DC70F9090;
        Wed, 16 Feb 2022 17:12:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=arIesL0LfA6dRcvTHu1nxAEhmLnKsguA5AucMp
        kR4ZE=; b=rFDKmkdnc64eJ65jiOKEWSlCn/Xfy64geDjnenNVC6/ZHTUogRFMVY
        s0NV4Ce0JKP6Pao88eNfC/w+fr4MLz5YIZEGxjj5aIUhLSRmYE7/nhnZguukqk7t
        JEzuEeZ4HgLuBM5CkJ87DW87bNDa1aRRPGPITKdvGcFne14qnEFFY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35872F908F;
        Wed, 16 Feb 2022 17:12:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8740DF908D;
        Wed, 16 Feb 2022 17:12:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "Merlin (they/them)" <merlinpatt+githubgit@gmail.com>
Subject: Re: [PATCH] docs: update coding guidelines to be more inclusive
References: <pull.1070.git.git.1645029267415.gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 14:12:20 -0800
In-Reply-To: <pull.1070.git.git.1645029267415.gitgitgadget@gmail.com> (Merlin
        via GitGitGadget's message of "Wed, 16 Feb 2022 16:34:27 +0000")
Message-ID: <xmqq4k4ycvgb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 832315E2-8F75-11EC-82E0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>     These changes make this documentation more inclusive.

I am not sure about this claim, though.

>      * Using "male" and "female" as examples of gender is unnecessary.

It feels somewhat more excluding for those of us who are non-native
speakers to use a heavier-weight word "gender".  After all, it warns
against writing "he", "him", "she" or "her"---the reason why we warn
against the first two is because the author has to implicitly assume
the person in question is "male".  Similarly the latter two needs to
assume "female".  These two words, "male" and "female", are both
easier to understand to even non-native speakers like us, and at the
same time quite in line with the suggestion being offered.

Maybe the motivation behind this change is a misunderstanding that
somehow the original of what this patch touches says that "male" and
"female" are the only two possible values of "gender", but I cannot
read it that way even when I squint my eyes.

>      * The use of "it" shouldn't be used to refer to people even in an
>        example of what not to use. People are never "it"s.

People are never "it", but I do not think that is relevant.  Reading
the original of what this patch touches, the subject is either a
person or a program, and for program, referring to "it" would be
perfectly sensible, no?

>      * There's no need to specify a person or group of people that learned
>        "they" is only plural.

Again, this change assumes/requires too much knowledge of the
language, which is more excluding for non-natives who may think
there is only one kind of the English language taught everywhere in
the world uniformly unless told explicitly.  If you are familiar,
there may be "no need", but does it actively hurt those of you who
are familiar if the explanation gives such an example?  Removing it
may actively hurt those who did learn English as a second language.

So, I can applaud for the desire to be inclusive, but I am not sure
if the patch succeeds in doing so.

Thanks.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1070%2Fmerlinpatt%2Fpatch-1-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1070/merlinpatt/patch-1-v1
> Pull-Request: https://github.com/git/git/pull/1070
>
>  Documentation/CodingGuidelines | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 711cb9171e0..ffd7fa9c0f4 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -552,9 +552,9 @@ Writing Documentation:
>   Documentation/SubmittingPatches file).
>  
>   In order to ensure the documentation is inclusive, avoid assuming
> - that an unspecified example person is male or female, and think
> - twice before using "he", "him", "she", or "her".  Here are some
> - tips to avoid use of gendered pronouns:
> + the gender of an example person, and think twice before using
> + "he", "him", "she", or "her". Here are some tips to avoid the use
> + of gendered pronouns:
>  
>    - Prefer succinctness and matter-of-factly describing functionality
>      in the abstract.  E.g.
> @@ -566,8 +566,8 @@ Writing Documentation:
>       --short:: Use this to emit output in the short-format.
>       --short:: You can use this to get output in the short-format.
>       --short:: A user who prefers shorter output could....
> -     --short:: Should a person and/or program want shorter output, he
> -               she/they/it can...
> +     --short:: Should a person and/or program want shorter output,
> +               he/she/they can...
>  
>      This practice often eliminates the need to involve human actors in
>      your description, but it is a good practice regardless of the
> @@ -586,15 +586,13 @@ Writing Documentation:
>        versions.
>  
>    - If you still need to refer to an example person that is
> -    third-person singular, you may resort to "singular they" to avoid
> +    third-person singular, you may resort to singular "they" to avoid
>      "he/she/him/her", e.g.
>  
>        A contributor asks their upstream to pull from them.
>  
>      Note that this sounds ungrammatical and unnatural to those who
> -    learned that "they" is only used for third-person plural, e.g.
> -    those who learn English as a second language in some parts of the
> -    world.
> +    learned that "they" is only used for third-person plural.
>  
>   Every user-visible change should be reflected in the documentation.
>   The same general rule as for code applies -- imitate the existing
>
> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
