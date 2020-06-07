Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C9EC433DF
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0969520659
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DUuJNFwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFGRBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 13:01:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56173 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgFGRBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 13:01:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A04B5BC1D;
        Sun,  7 Jun 2020 13:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MS6ZZCoHoK5F6MekPbgAtcwOROI=; b=DUuJNF
        wF/epIHhSJQvO43rB/x0eY+9NEuDxYidctPz6Hocd4ki5VTO9CfPoMUZV3XEaDoc
        BMC51ZlrkA+HodojX8Nyi1mVZC52OTIIf9/8LQSbACJFZAtenu8j2JTAgLZY6dAc
        KEnk3ZzN4X2g6iCxbUntII1KD2yT/KKg0tzGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eJ6KxFo4B+T0yyqHoDgIf/thFyrQ/z3e
        wVzTGBj1pVezMUl90VVEs1qSW8KbZJj4c3H3fXVMz1O3UtPoTFh81SESwb/asvNn
        5hlExl6F+VXdVmK6Jz0sbn9yq/mMugBHFl0jdR622hnlWz7YOBrlRCQ+DbryCkBj
        lBuPDloqP30=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 323415BC1B;
        Sun,  7 Jun 2020 13:01:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B01EE5BC1A;
        Sun,  7 Jun 2020 13:01:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Angel via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Angel <the.f8er@gmail.com>
Subject: Re: [PATCH] doc: fix a typo inside `--bare` section
References: <pull.649.git.1591445695220.gitgitgadget@gmail.com>
Date:   Sun, 07 Jun 2020 10:01:38 -0700
In-Reply-To: <pull.649.git.1591445695220.gitgitgadget@gmail.com> (Angel via
        GitGitGadget's message of "Sat, 06 Jun 2020 12:14:55 +0000")
Message-ID: <xmqqh7vmn72l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D7101EE-A8E0-11EA-9FCF-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Angel via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Mark Williams <the.f8er@gmail.com>
>
> Add a word `variable` and a `$` sign before variable's
> name in `--bare` argument section. Without this word someone
> might be confused.
>
> Signed-off-by: Mark Williams <the.f8er@gmail.com>
> ---
>     doc: fix a typo inside --bare section
>     
>     doc: fix a typo inside --bare section
>     
>     Add a word variable and a $ sign before variable's name in --bare 
>     argument section. Without this word someone might be confused.

A quick and dirty

  $ git grep 'GIT_[A-Z]*[^A-Za-z0-9] .*environment' Documentation/

tells us that adding "environment variable" is probably the right
thing to do, but we should not add the variable dereference '$' in
front (and fix some that do spell $GIT_PAGER etc. to lose '$').

In shell, $V is a notation to always name the value in the variable,
and it is clearer to refer to the variable itself without the '$'
sign.  '$V' means "the value that currently is in the variable V".

	V=newvalue
	W="old value of $V"

This is unlike C where using a variable as lvalue on the left hand
side of assignment does not need different spelling as the variable
is used as rvalue, e.g.

	variable = newvalue;
	another_variable = 2 * variable;

> -Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
> -current working directory.
> +Create a bare repository. If the `$GIT_DIR` environment variable is not set, it
> +is set to the current working directory.
>  
>  --object-format=<format>::
>  
>
> base-commit: 20514004ddf1a3528de8933bc32f284e175e1012
