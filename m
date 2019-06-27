Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5138D1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 20:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0UK7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 16:10:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50513 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfF0UK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 16:10:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9D7F7C264;
        Thu, 27 Jun 2019 16:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0vXyU0d3qplhfp2NgPy7medsMTU=; b=oqE2N7
        vI0L+FHus4JS3rCwIoifGB9jOug/KBUwmcHxSqbHde6aGkGaSR+v6BwElNniWAff
        mMcjZBhqkZQjBTqX3gZyCgAg4hupibtD4DJD+LxmvIt1WPEXKtgyPFGyKEHXJ3oP
        BOyGfSZIAxPppNDqaERU/QJJ2A6fzMr7X3e8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g5Hd7zTXAquDC2sz0FbXn8FT3Ki/0Dy7
        PAdQgLX9/8S2+WldS8ar/V3RnRTOIQViBKatA49rSDB5GmLMkjTxjuF0gafvchNp
        PRV/RJQBBqDnNaCjyp+1ElfKgGULPthS9Kv6EIMtdL1yiZ8KLgk+kZPOmKGPbGez
        8HlyRfxPVQc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D21E67C263;
        Thu, 27 Jun 2019 16:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 01CCE7C262;
        Thu, 27 Jun 2019 16:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Quentin Nerden <quentin.nerden@gmail.com>
Subject: Re: [PATCH 1/1] docs: update git-clone doc: refer to long options
References: <pull.277.git.gitgitgadget@gmail.com>
        <0dd1b017698dd9d15f291f1133eb40dac8d85a68.1561663019.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Jun 2019 13:10:51 -0700
In-Reply-To: <0dd1b017698dd9d15f291f1133eb40dac8d85a68.1561663019.git.gitgitgadget@gmail.com>
        (Quentin Nerden via GitGitGadget's message of "Thu, 27 Jun 2019
        12:17:00 -0700 (PDT)")
Message-ID: <xmqqmui2aiwk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AACB18A8-9917-11E9-99D8-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Quentin Nerden via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Quentin Nerden <quentin.nerden@gmail.com>
>
> To make the doc of git-clone easier to read,
> refer to the long version of the options
> (it is easier to guess what --verbose is doing than -v).
>
> Also:
> put the short options first, to match the doc of git-add, git-commit, git-clean, git-branch...

This "also" makes the patch unnecessarily harder to review.
Splitting it into two patches would make it reviewable.

Thanks.

>
> Signed-off-by: Quentin Nerden <quentin.nerden@gmail.com>
> ---
>  Documentation/git-clone.txt | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 5fc97f14de..4edc713a4b 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -41,8 +41,8 @@ configuration variables.
>  
>  OPTIONS
>  -------
> ---local::
>  -l::
> +--local::
>  	When the repository to clone from is on a local machine,
>  	this flag bypasses the normal "Git aware" transport
>  	mechanism and clones the repository by making a copy of
> @@ -63,8 +63,8 @@ Git transport instead.
>  	directory instead of using hardlinks. This may be desirable
>  	if you are trying to make a back-up of your repository.
>  
> ---shared::
>  -s::
> +--shared::
>  	When the repository to clone is on the local machine,
>  	instead of using hard links, automatically setup
>  	`.git/objects/info/alternates` to share the objects
> @@ -81,10 +81,10 @@ which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
>  If these objects are removed and were referenced by the cloned repository,
>  then the cloned repository will become corrupt.
>  +
> -Note that running `git repack` without the `-l` option in a repository
> +Note that running `git repack` without the `--local` option in a repository
>  cloned with `-s` will copy objects from the source repository into a pack
>  in the cloned repository, removing the disk space savings of `clone -s`.
> -It is safe, however, to run `git gc`, which uses the `-l` option by
> +It is safe, however, to run `git gc`, which uses the `--local` option by
>  default.
>  +
>  If you want to break the dependency of a repository cloned with `-s` on
> @@ -116,19 +116,19 @@ objects from the source repository into a pack in the cloned repository.
>  	same repository, and this option can be used to stop the
>  	borrowing.
>  
> ---quiet::
>  -q::
> +--quiet::
>  	Operate quietly.  Progress is not reported to the standard
>  	error stream.
>  
> ---verbose::
>  -v::
> +--verbose::
>  	Run verbosely. Does not affect the reporting of progress status
>  	to the standard error stream.
>  
>  --progress::
>  	Progress status is reported on the standard error stream
> -	by default when it is attached to a terminal, unless -q
> +	by default when it is attached to a terminal, unless `--quiet`
>  	is specified. This flag forces progress status even if the
>  	standard error stream is not directed to a terminal.
>  
> @@ -140,15 +140,15 @@ objects from the source repository into a pack in the cloned repository.
>  	When multiple `--server-option=<option>` are given, they are all
>  	sent to the other side in the order listed on the command line.
>  
> ---no-checkout::
>  -n::
> +--no-checkout::
>  	No checkout of HEAD is performed after the clone is complete.
>  
>  --bare::
>  	Make a 'bare' Git repository.  That is, instead of
>  	creating `<directory>` and placing the administrative
>  	files in `<directory>/.git`, make the `<directory>`
> -	itself the `$GIT_DIR`. This obviously implies the `-n`
> +	itself the `$GIT_DIR`. This obviously implies `--no-checkout`
>  	because there is nowhere to check out the working tree.
>  	Also the branch heads at the remote are copied directly
>  	to corresponding local branch heads, without mapping
> @@ -164,13 +164,13 @@ objects from the source repository into a pack in the cloned repository.
>  	that all these refs are overwritten by a `git remote update` in the
>  	target repository.
>  
> ---origin <name>::
>  -o <name>::
> +--origin <name>::
>  	Instead of using the remote name `origin` to keep track
>  	of the upstream repository, use `<name>`.
>  
> ---branch <name>::
>  -b <name>::
> +--branch <name>::
>  	Instead of pointing the newly created HEAD to the branch pointed
>  	to by the cloned repository's HEAD, point to `<name>` branch
>  	instead. In a non-bare repository, this is the branch that will
> @@ -178,8 +178,8 @@ objects from the source repository into a pack in the cloned repository.
>  	`--branch` can also take tags and detaches the HEAD at that commit
>  	in the resulting repository.
>  
> ---upload-pack <upload-pack>::
>  -u <upload-pack>::
> +--upload-pack <upload-pack>::
>  	When given, and the repository to clone from is accessed
>  	via ssh, this specifies a non-default path for the command
>  	run on the other end.
> @@ -188,8 +188,8 @@ objects from the source repository into a pack in the cloned repository.
>  	Specify the directory from which templates will be used;
>  	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
>  
> ---config <key>=<value>::
>  -c <key>=<value>::
> +--config <key>=<value>::
>  	Set a configuration variable in the newly-created repository;
>  	this takes effect immediately after the repository is
>  	initialized, but before the remote history is fetched or any
> @@ -274,8 +274,8 @@ or `--mirror` is given)
>  	The result is Git repository can be separated from working
>  	tree.
>  
> --j <n>::
>  --jobs <n>::
> +-j <n>::
>  	The number of submodules fetched at the same time.
>  	Defaults to the `submodule.fetchJobs` option.
