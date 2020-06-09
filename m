Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D34C433DF
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0058F20734
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 23:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QraJqVcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgFIXBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:01:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57584 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIXBe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 19:01:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 80C8A5F893;
        Tue,  9 Jun 2020 19:01:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+OGkQ8kO4NJdCdgSP0m19C1ClSk=; b=QraJqV
        cwQQKI7yoKJ/74q2V1IkVeek7HLqdCoaH5w35yIMq829cYlx4/mAR1QN7lIVJuLU
        4Q3u3q332hyqlm5oPFymo28Z7mp4Tn+P4Rmdb8D9TRZ50FYBr7nyw3oznRvNmKmW
        FWZvFlc/HShlNpfUGlxdVuq+bwVaHZJUQ83mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZlrKUauowa0/PHqGHPaB1e0GlilkszAi
        9EVzDaGe8Q3i+ZgSV+wD5a+KTu0KCnGhdlpbM08J/TjimXw+AlriqblFeBogZfii
        8nVgv4k3C+E313Xu8xlfs5YyZ6IjKniUjoHPlsp1sfvnKC+PiGO1fJiKtZijoPg+
        8fRqwCgVwJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 770235F892;
        Tue,  9 Jun 2020 19:01:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E97125F88E;
        Tue,  9 Jun 2020 19:01:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 3/3] Documentation: tweak git diff help slightly
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <pull.804.v2.git.git.1591729224.gitgitgadget@gmail.com>
        <b9b4c6f113dfb03268b391cc62abfd38bd7632e4.1591729224.git.gitgitgadget@gmail.com>
Date:   Tue, 09 Jun 2020 16:01:29 -0700
In-Reply-To: <b9b4c6f113dfb03268b391cc62abfd38bd7632e4.1591729224.git.gitgitgadget@gmail.com>
        (Chris Torek via GitGitGadget's message of "Tue, 09 Jun 2020 19:00:23
        +0000")
Message-ID: <xmqqbllrhmie.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27A5F678-AAA5-11EA-AEA9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chris Torek <chris.torek@gmail.com>
>
> Update the manual page synopsis to include the three-dot notation
> and the combined-diff option

Surely.  That is "tweak ... slightly".  Full-stop is missing here,
by the way.

> Make "git diff -h" print the same usage summary as the manual
> page synopsis, minus the "A..B" form, which is now discouraged.

Good.

> Document the usage for producing combined commits.

Yup, that is "while we are at it".  The new text reads well, but it
appears that it is the more significant part of the change in this
patch now ;-)

> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 37781cf1755..0bce278652a 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -11,15 +11,17 @@ SYNOPSIS
>  [verse]
>  'git diff' [<options>] [<commit>] [--] [<path>...]
>  'git diff' [<options>] --cached [<commit>] [--] [<path>...]
> -'git diff' [<options>] <commit> <commit> [--] [<path>...]
> +'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]
> +'git diff' [<options>] <commit>...<commit> [--] [<path>...]
>  'git diff' [<options>] <blob> <blob>
>  'git diff' [<options>] --no-index [--] <path> <path>
>  
>  DESCRIPTION
>  -----------
>  Show changes between the working tree and the index or a tree, changes
> -between the index and a tree, changes between two trees, changes between
> -two blob objects, or changes between two files on disk.
> +between the index and a tree, changes between two trees, changes resulting
> +from a merge, changes between two blob objects, or changes between two
> +files on disk.
>  
>  'git diff' [<options>] [--] [<path>...]::
>  
> @@ -67,6 +69,16 @@ two blob objects, or changes between two files on disk.
>  	one side is omitted, it will have the same effect as
>  	using HEAD instead.
>  
> +'git diff' [<options>] <commit> [<commit>...] <commit> [--] [<path>...]::
> +
> +	This form is to view the results of a merge commit.  The first
> +	listed <commit> must be the merge itself; the remaining two or
> +	more commits should be its parents.  A convenient way to produce
> +	the desired set of revisions is to use the {caret}@ suffix, i.e.,
> +	"git diff master master^@".  This is equivalent to running "git

Don't we usually use `git diff master master^@` to mark up literal
examples with tt, instead of "git diff..." with double-quotes?

> +	show --format=" on the merge commit, e.g., "git show --format=
> +	master".

Likewise.

But more importantly, I think giving the exact equivalent is much
less important than keeping the explanation concise, simple and
clear, and the "empty format to omit the log part" is distracting
(after all, teaching how to squelch the log message part in the
"show" command is not the topic of this manpage).

    For a merge commit `master`, this gives the same combined diff
    as `git show master` does.

perhaps?

Thanks.
