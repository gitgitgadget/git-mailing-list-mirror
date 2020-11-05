Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE635C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C3A5206CB
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 20:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NMO1uBp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgKEUlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:41:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56770 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEUln (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 15:41:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E977F101AC9;
        Thu,  5 Nov 2020 15:41:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GdjY/TYwPkaSo/FhlNmkfuzOevM=; b=NMO1uB
        p22GIS/4g13qSgFgQFeVP6MCE8RQTgcwueNVi0Cp5ZJ18So2lo5cvigzBuu7IRUj
        0/R1/R9GPiHAt2H0VJqE4vfX7Thm8Chu3xnx+Nrz89Qp9CoS5mvfi9NeKYXOgDW3
        +oB+Ith8Rn7thkruYdTI6jNOOZ7x9Gl8CCF7s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DYs722s49Q+S1ofQ0amgAcA1wdEa1/+E
        lz6Db7L+mScJaGR5R98pwVIAXyl2iyetO/kcCosXjJEXfp1XcI4u0Yj+ywSbPG2a
        c6OI7w+8FsWrZKGKMtMIDQ8fo3RUKrwSoD9jmCuitDKvasJgnsaO+xXaIGZeVCRQ
        mTUzzMPLAdM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E304E101AC8;
        Thu,  5 Nov 2020 15:41:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B28B101AC7;
        Thu,  5 Nov 2020 15:41:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marlon Rac Cambasis <marlonrc08@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: fixing two trivial typos in Documentation/
References: <20201105091136.GA28535@marlonpc-debian>
Date:   Thu, 05 Nov 2020 12:41:37 -0800
In-Reply-To: <20201105091136.GA28535@marlonpc-debian> (Marlon Rac Cambasis's
        message of "Thu, 5 Nov 2020 20:11:36 +1100")
Message-ID: <xmqq4km3k03i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DF0BF44-1FA7-11EB-9A64-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marlon Rac Cambasis <marlonrc08@gmail.com> writes:

> Changed "speficied" to "specified" in config.txt and "occured" to
> "occurred" in githooks.txt. This should help any readers of these
> files.

Thanks.  Will apply.


>
> Signed-off-by: Marlon Rac Cambasis <marlonrc08@gmail.com>
> ---
>  Documentation/config.txt   | 2 +-
>  Documentation/githooks.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 025ca4df11..f292c2689e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -265,7 +265,7 @@ color::
>  The basic colors accepted are `normal`, `black`, `red`, `green`, `yellow`,
>  `blue`, `magenta`, `cyan` and `white`.  The first color given is the
>  foreground; the second is the background.  All the basic colors except
> -`normal` have a bright variant that can be speficied by prefixing the
> +`normal` have a bright variant that can be specified by prefixing the
>  color with `bright`, like `brightred`.
>  +
>  Colors may also be given as numbers between 0 and 255; these use ANSI
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 4e097dc4e9..ffccfc7760 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -655,7 +655,7 @@ p4-post-changelist
>  This hook is invoked by `git-p4 submit`.
>  
>  The `p4-post-changelist` hook is invoked after the submit has
> -successfully occured in P4. It takes no parameters and is meant
> +successfully occurred in P4. It takes no parameters and is meant
>  primarily for notification and cannot affect the outcome of the
>  git p4 submit action.
