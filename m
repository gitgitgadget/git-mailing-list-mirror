Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AE6CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 22:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjIVWVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 18:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIVWVo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 18:21:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D84619A
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 15:21:37 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C87D81B1E2C;
        Fri, 22 Sep 2023 18:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=JjyQPIZ1vVcRrjq4Z3Uz4dvgp6BDzojPwkDo30
        HScog=; b=BTbZRgBOm8v053SAcjwBhp0n0SePDiwLSNLSJbVwAzSSm2b3/NPy/p
        i5DHwtj3dxgcCI1G8giYd4+TAcz7sc7hUw1ROsgn+e9B11c70iUlosFc0+B1ohcT
        /XjC4k3N4gE8b1/djO7q0+qHVMiSIX8vxSFfo1fB+uObieMOB/1c0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C0CB21B1E2B;
        Fri, 22 Sep 2023 18:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D7641B1E2A;
        Fri, 22 Sep 2023 18:21:36 -0400 (EDT)
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
Importance: high
Date:   Fri, 22 Sep 2023 15:21:35 -0700
Message-ID: <xmqqttrlyhlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 648DE6F6-5996-11EE-B33D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
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

This is an interesting one.  code.google.com is no longer tehre

> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 1d6102e0674..4a11d590b68 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -2390,7 +2390,7 @@ proc do_quit {{rc {1}}} {
>  	set ret_code $rc
>  
>  	# Briefly enable send again, working around Tk bug
> -	# http://sourceforge.net/tracker/?func=detail&atid=112997&aid=1821174&group_id=12997
> +	# https://sourceforge.net/p/tktoolkit/bugs/2343/
>  	tk appname [appname]
>  
>  	destroy .
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 1db46977df0..7a087f123d7 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -12472,7 +12472,7 @@ if {[tk windowingsystem] eq "aqua"} {
>  
>  catch {
>      # follow the XDG base directory specification by default. See
> -    # http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
> +    # https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
>      if {[info exists env(XDG_CONFIG_HOME)] && $env(XDG_CONFIG_HOME) ne ""} {
>          # XDG_CONFIG_HOME environment variable is set
>          set config_file [file join $env(XDG_CONFIG_HOME) git gitk]
> diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
> index 17b1796496d..99e3eb8c3d9 100644
> --- a/gitweb/static/js/lib/common-lib.js
> +++ b/gitweb/static/js/lib/common-lib.js
> @@ -137,7 +137,7 @@ function addCssRule(selector, style) {
>   *   http://www.dustindiaz.com/getelementsbyclass/
>   *   https://stackoverflow.com/questions/1818865/do-we-have-getelementsbyclassname-in-javascript
>   *
> - * See also http://ejohn.org/blog/getelementsbyclassname-speed-comparison/
> + * See also https://johnresig.com/blog/getelementsbyclassname-speed-comparison/
>   *
>   * @param {String} class: name of _single_ class to find
>   * @param {String} [taghint] limit search to given tags
> diff --git a/http.c b/http.c
> index e138b4b96fb..33c6011e8d8 100644
> --- a/http.c
> +++ b/http.c
> @@ -1877,7 +1877,7 @@ static void write_accept_language(struct strbuf *buf)
>  	 * MAX_DECIMAL_PLACES must not be larger than 3. If it is larger than
>  	 * that, q-value will be smaller than 0.001, the minimum q-value the
>  	 * HTTP specification allows. See
> -	 * http://tools.ietf.org/html/rfc7231#section-5.3.1 for q-value.
> +	 * https://datatracker.ietf.org/doc/html/rfc7231#section-5.3.1 for q-value.
>  	 */
>  	const int MAX_DECIMAL_PLACES = 3;
>  	const int MAX_LANGUAGE_TAGS = 1000;
> diff --git a/imap-send.c b/imap-send.c
> index 3b2077e39b2..448ca64c052 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -860,7 +860,7 @@ static void imap_close_store(struct imap_store *ctx)
>  
>  /*
>   * hexchar() and cram() functions are based on the code from the isync
> - * project (http://isync.sf.net/).
> + * project (https://isync.sourceforge.io/).
>   */
>  static char hexchar(unsigned int b)
>  {
> diff --git a/json-writer.h b/json-writer.h
> index de140e54c98..04413bd1afd 100644
> --- a/json-writer.h
> +++ b/json-writer.h
> @@ -4,7 +4,7 @@
>  /*
>   * JSON data structures are defined at:
>   * [1] https://www.ietf.org/rfc/rfc7159.txt
> - * [2] http://json.org/
> + * [2] https://www.json.org/
>   *
>   * The JSON-writer API allows one to build JSON data structures using a
>   * simple wrapper around a "struct strbuf" buffer.  It is intended as a
