Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7B5CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 22:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjIVWXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 18:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjIVWXk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 18:23:40 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162201AC
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 15:23:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 748A21B1E44;
        Fri, 22 Sep 2023 18:23:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=3KOaE1aUMo4H8SUJy4rMBcoIdNe2mKTeNEfEso
        Bk2k8=; b=pbeJLyxwOTEL8pHsdD+8cmPaT7cBG9M8xcBnhZZZyPdfjgR/s1T9vk
        oSIuwoJdEKMk+8kpuy7pNXOpPolody5SVei/ByZIjNhGWMHe5GCrKHRDWdYm5IEe
        gieXcbz/2NEdUmtVBZ49d7I3LPxxvFqgaBYuvrCCEdipH1QpkAXvc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DA6A1B1E43;
        Fri, 22 Sep 2023 18:23:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7D3A1B1E42;
        Fri, 22 Sep 2023 18:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH 2/4] doc: update links to current pages
In-Reply-To: <f9f3f4af1c8889eb69f777a322348afc53feeca2.1695392028.git.gitgitgadget@gmail.com>
        (Josh Soref via GitGitGadget's message of "Fri, 22 Sep 2023 14:13:45
        +0000")
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
        <f9f3f4af1c8889eb69f777a322348afc53feeca2.1695392028.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Importance: high
Date:   Fri, 22 Sep 2023 15:23:29 -0700
Message-ID: <xmqqr0mpyhi6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8E0B0A4-5996-11EE-85FD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  Documentation/CodingGuidelines     | 2 +-
>  Documentation/RelNotes/1.6.2.txt   | 2 +-
>  Documentation/RelNotes/1.6.3.txt   | 2 +-
>  Documentation/RelNotes/1.6.4.txt   | 2 +-
>  Documentation/RelNotes/1.6.5.txt   | 2 +-
>  Documentation/RelNotes/1.6.6.txt   | 2 +-
>  Documentation/git-cvsimport.txt    | 2 +-
>  Documentation/git-format-patch.txt | 2 +-
>  Documentation/git-ls-remote.txt    | 4 ++--
>  Documentation/git.txt              | 2 +-
>  Documentation/gitcore-tutorial.txt | 4 ++--
>  compat/nedmalloc/malloc.c.h        | 2 +-
>  contrib/persistent-https/README    | 2 +-
>  git-gui/git-gui.sh                 | 2 +-
>  gitk-git/gitk                      | 2 +-
>  gitweb/static/js/lib/common-lib.js | 2 +-
>  http.c                             | 2 +-
>  imap-send.c                        | 2 +-
>  json-writer.h                      | 2 +-
>  19 files changed, 21 insertions(+), 21 deletions(-)

Broken links are annoying while reading documentation.  Thank you
for doing the necessary research.

I am not sure if direct replacement to Release Notes (historical
document) is the best way to present these updates, but let's assume
it is OK for now.

> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
> index 1c4f696ab57..b9c8478a62a 100644
> --- a/Documentation/git-ls-remote.txt
> +++ b/Documentation/git-ls-remote.txt
> @@ -128,7 +128,7 @@ d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
>  * List all references matching given patterns:
>  +
>  ----
> -$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master seen rc
> +$ git ls-remote https://git.kernel.org/pub/scm/git/git.git master seen rc
>  5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
>  c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/seen
>  ----

I am not sure if this change is warranted.  The old URL still works
just fine, even though there are no refs that match "rc" and the
"master" branch is no longer at 5fe978a5, but these are not problem
caused by using the http:// address.  The point of the example is
not about preferred use of HTTP:// over HTTPS://, so this again
falls into "if we were writing this anew, we may have used the other
address, but the original still works, so it is not worth the patch
noise" category, I would think.

> diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
> index 2122aeb9769..924a9a97807 100644
> --- a/Documentation/gitcore-tutorial.txt
> +++ b/Documentation/gitcore-tutorial.txt
> @@ -1101,8 +1101,8 @@ Examples.
>  
>  the above are equivalent to:
>  
> -. `git pull http://www.kernel.org/pub/scm/git/git.git/ HEAD`
> -. `git pull http://www.kernel.org/pub/scm/git/git.git/ tag v0.99.1`
> +. `git pull https://git.kernel.org/pub/scm/git/git.git/ HEAD`
> +. `git pull https://git.kernel.org/pub/scm/git/git.git/ tag v0.99.1`

Likewise.

> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 11228956cd5..c7292eb25d0 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1061,7 +1061,7 @@ Authors
>  -------
>  Git was started by Linus Torvalds, and is currently maintained by Junio
>  C Hamano. Numerous contributions have come from the Git mailing list
> -<git@vger.kernel.org>.  http://www.openhub.net/p/git/contributors/summary
> +<git@vger.kernel.org>.  https://openhub.net/p/git/contributors/summary
>  gives you a more complete list of contributors.

OK, even though the former seems to redirect to the latter, so in
that sense it is still "current".

> diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
> index 5c5357a379f..4b711c6b9ca 100644
> --- a/compat/nedmalloc/malloc.c.h
> +++ b/compat/nedmalloc/malloc.c.h
> @@ -1359,7 +1359,7 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
>    /* --[ start GCC compatibility ]----------------------------------------------
>     * Compatibility <intrin_x86.h> header for GCC -- GCC equivalents of intrinsic
>     * Microsoft Visual C++ functions. Originally developed for the ReactOS
> -   * (<http://www.reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)
> +   * (<https://reactos.org/>) and TinyKrnl (<http://www.tinykrnl.org/>)

Likewise for reactos; the tinykrnl one does not seem to be current.

In any case, this is borrowed code, so I'd rather not touch it and
risk giving a wrong page that is not a replacement.

> diff --git a/contrib/persistent-https/README b/contrib/persistent-https/README
> index 2ad95893c27..2c9bec91066 100644
> --- a/contrib/persistent-https/README
> +++ b/contrib/persistent-https/README
> @@ -60,7 +60,7 @@ https://kernel.googlesource.com/pub/scm/git/git
>  
>  PREREQUISITES
>  
> -The code is written in Go (http://golang.org/) and the Go compiler is
> +The code is written in Go (https://go.dev/) and the Go compiler is

Likewise.

>  required. Currently, the compiler must be built and installed from tip
>  of source, in order to include a fix in the reverse http proxy:
>  https://code.google.com/p/go/source/detail?r=a615b796570a2cd8591884767a7d67ede74f6648

This is an interesting one.  code.google.com is no longer there and
the updated URL seems to be at https://github.com/golang/go somewhere.

