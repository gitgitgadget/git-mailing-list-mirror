Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F596207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 02:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164178AbdDXC2N (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 22:28:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52937 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164167AbdDXC2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 22:28:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6FED80C15;
        Sun, 23 Apr 2017 22:28:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Je8GsIvWnbNm
        wzUTp2Y8txpi6Ew=; b=DL4OyVM7CaXB+Fya8DWDEUetDqdvMbtMP+hHb+PSY9EA
        2yoIMw+4VT4DupGW++o9MaD6FQwMnheUE03jsiDD4pKwqdLYXnnLj9f2SPc53qiF
        4DsroGjY4dkwr+RV6JG/BFDnvC0f6LS7ef5gPGAFCE1Aoez9q5SkcHdGJyVpQHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=r2ggoz
        S74Y0zT/QrjDT5BJyYSSHdpeh6SU3LnlO666apsOJ9u+IN5/0hQfiYxfbJjgwKhA
        iMKkvLsAY1k60cYWSBnnKK6e7f2ygDrEVjfhE0mYz50PWb2KaUbwisPlAZBcZUWS
        xg/NabXqz/ehbD/O+bK8AXrPTYZut4/5cGdo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD6E980C14;
        Sun, 23 Apr 2017 22:28:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D8D380C13;
        Sun, 23 Apr 2017 22:28:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Genz <liebundartig@freenet.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fix minor typing mistakes
References: <1492955809-29018-1-git-send-email-liebundartig@freenet.de>
Date:   Sun, 23 Apr 2017 19:28:08 -0700
In-Reply-To: <1492955809-29018-1-git-send-email-liebundartig@freenet.de>
        (=?utf-8?Q?=22Ren=C3=A9?= Genz"'s message of "Sun, 23 Apr 2017 15:56:49
 +0200")
Message-ID: <xmqqa87635fr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A7F7F726-2895-11E7-8DC0-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Genz <liebundartig@freenet.de> writes:

> Thanks-to: Stefan Beller <sbeller@google.com>
> ---

It is nice to give credit to where credit is due (it is more common
to say Helped-by: around here, though), but don't forget to sign off
your patch yourself ;-)  IOW

    Helped-by: Stefan Beller <sbeller@google.com>
    Signed-off-by: Ren=C3=A9 Genz <liebundartig@freenet.de>

>  Documentation/git-commit.txt        | 4 ++--
>  Documentation/gitremote-helpers.txt | 2 +-
>  ci/run-windows-build.sh             | 2 +-
>  diff.c                              | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

This "a the" and "the a" seem to be quite a popular typo.  Thanks
for catching them.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
> index ed0f5b9..afb06ad 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -95,7 +95,7 @@ OPTIONS
> =20
>  --reset-author::
>  	When used with -C/-c/--amend options, or when committing after a
> -	a conflicting cherry-pick, declare that the authorship of the
> +	conflicting cherry-pick, declare that the authorship of the
>  	resulting commit now belongs to the committer. This also renews
>  	the author timestamp.
> =20
> @@ -112,7 +112,7 @@ OPTIONS
>  	`--dry-run`.
> =20
>  --long::
> -	When doing a dry-run, give the output in a the long-format.
> +	When doing a dry-run, give the output in the long-format.
>  	Implies `--dry-run`.
> =20
>  -z::
> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
> index e4b785e..4a584f3 100644
> --- a/Documentation/gitremote-helpers.txt
> +++ b/Documentation/gitremote-helpers.txt
> @@ -463,7 +463,7 @@ set by Git if the remote helper has the 'option' ca=
pability.
>  	GPG sign pushes.
> =20
>  'option push-option <string>::
> -	Transmit <string> as a push option. As the a push option
> +	Transmit <string> as a push option. As the push option
>  	must not contain LF or NUL characters, the string is not encoded.
> =20
>  SEE ALSO
> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
> index 4e3a50b..9f89d54 100755
> --- a/ci/run-windows-build.sh
> +++ b/ci/run-windows-build.sh
> @@ -1,6 +1,6 @@
>  #!/usr/bin/env bash
>  #
> -# Script to trigger the a Git for Windows build and test run.
> +# Script to trigger the Git for Windows build and test run.
>  # Set the $GFW_CI_TOKEN as environment variable.
>  # Pass the branch (only branches on https://github.com/git/git are
>  # supported) and a commit hash.
> diff --git a/diff.c b/diff.c
> index 11eef1c..74283d9 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -911,7 +911,7 @@ static int fn_out_diff_words_write_helper(FILE *fp,
>  /*
>   * '--color-words' algorithm can be described as:
>   *
> - *   1. collect a the minus/plus lines of a diff hunk, divided into
> + *   1. collect the minus/plus lines of a diff hunk, divided into
>   *      minus-lines and plus-lines;
>   *
>   *   2. break both minus-lines and plus-lines into words and
