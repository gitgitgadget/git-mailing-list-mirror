Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBC8CE7A81
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 22:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjIVWFr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjIVWFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 18:05:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC5FB
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 15:05:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72C8B2ACE8;
        Fri, 22 Sep 2023 18:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=XLo45g5WF/EsWWHdgwlHADhZcOHVsPCuBj3qef
        K/0KI=; b=bSliegqBkvynB3S017F2H/NkLkrleIiAY/C62Z18IqBIntbROMCMR+
        v6+/xpBH9+yUGHzBpAiIe2RI4oZuBYqR5Lm7owjLP1OFFKtRw63sF5TMhAqQBzE7
        yfMZcx7RmWlyhXeNWRomIRD7NqlNynsUvZoUGDYFS4vM0IDLrFeiQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B2ED2ACE7;
        Fri, 22 Sep 2023 18:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F14362ACE6;
        Fri, 22 Sep 2023 18:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Josh Soref via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Josh Soref <jsoref@gmail.com>
Subject: Re: [PATCH 1/4] doc: switch links to https
In-Reply-To: <b80c6089653bffc59faaa585e29d8c46a0611e83.1695392028.git.gitgitgadget@gmail.com>
        (Josh Soref via GitGitGadget's message of "Fri, 22 Sep 2023 14:13:44
        +0000")
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
        <b80c6089653bffc59faaa585e29d8c46a0611e83.1695392028.git.gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 15:05:31 -0700
Message-ID: <xmqqedipzwwk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 26712858-5994-11EE-BA04-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Josh Soref via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Josh Soref <jsoref@gmail.com>
>
> Signed-off-by: Josh Soref <jsoref@gmail.com>
> ---
>  Documentation/CodingGuidelines                         |  2 +-
>  Documentation/MyFirstContribution.txt                  |  2 +-
>  Documentation/git-cvsimport.txt                        |  2 +-
>  Documentation/git-format-patch.txt                     |  2 +-
>  Documentation/git-imap-send.txt                        |  2 +-
>  Documentation/git-send-email.txt                       |  2 +-
>  Documentation/gitcore-tutorial.txt                     |  2 +-
>  Documentation/gitprotocol-http.txt                     |  4 ++--
>  Documentation/gitweb.conf.txt                          |  2 +-
>  Documentation/gitweb.txt                               |  2 +-
>  Documentation/howto/keep-canonical-history-correct.txt |  2 +-
>  Documentation/signoff-option.txt                       |  2 +-
>  INSTALL                                                |  2 +-
>  Makefile                                               |  4 ++--
>  README.md                                              |  2 +-

These are end-user facing and most of the changes looked sensible,
except for URLs that had comments like "at the time of this writing
the URL is at ...", which we should not bother touching.  There may
be other reasons not to touch some of them, but I didn't look very
closely.

>  compat/nedmalloc/malloc.c.h                            | 10 +++++-----
>  compat/obstack.c                                       |  2 +-
>  compat/obstack.h                                       |  2 +-
>  compat/poll/poll.c                                     |  2 +-
>  compat/poll/poll.h                                     |  2 +-
>  compat/precompose_utf8.h                               |  2 +-
>  compat/regex/regcomp.c                                 |  2 +-
>  compat/regex/regex.c                                   |  2 +-
>  compat/regex/regex.h                                   |  2 +-
>  compat/regex/regex_internal.c                          |  2 +-
>  compat/regex/regex_internal.h                          |  2 +-
>  compat/regex/regexec.c                                 |  2 +-
>  compat/vcbuild/README                                  | 10 +++++-----
>  contrib/completion/git-completion.bash                 |  2 +-
>  .../credential/libsecret/git-credential-libsecret.c    |  2 +-
>  contrib/fast-import/import-directories.perl            |  2 +-
>  contrib/hg-to-git/hg-to-git.py                         |  2 +-
>  contrib/mw-to-git/t/test-gitmw-lib.sh                  |  4 ++--
>  contrib/persistent-https/LICENSE                       |  2 +-
>  contrib/persistent-https/README                        |  2 +-
>  contrib/thunderbird-patch-inline/appp.sh               |  2 +-
>  contrib/update-unicode/update_unicode.sh               |  6 +++---
>  convert.c                                              |  2 +-
>  ewah/bitmap.c                                          |  2 +-
>  ewah/ewah_bitmap.c                                     |  2 +-
>  ewah/ewah_io.c                                         |  2 +-
>  ewah/ewah_rlw.c                                        |  2 +-
>  ewah/ewok.h                                            |  4 ++--
>  ewah/ewok_rlw.h                                        |  2 +-
>  xdiff/xdiff.h                                          |  2 +-
>  xdiff/xdiffi.c                                         |  2 +-
>  xdiff/xdiffi.h                                         |  2 +-
>  xdiff/xemit.c                                          |  2 +-
>  xdiff/xemit.h                                          |  2 +-
>  xdiff/xinclude.h                                       |  2 +-
>  xdiff/xmacros.h                                        |  2 +-
>  xdiff/xmerge.c                                         |  2 +-
>  xdiff/xpatience.c                                      |  2 +-
>  xdiff/xprepare.c                                       |  2 +-
>  xdiff/xprepare.h                                       |  2 +-
>  xdiff/xtypes.h                                         |  2 +-
>  xdiff/xutils.c                                         |  2 +-
>  xdiff/xutils.h                                         |  2 +-

There are mostly borrowed code.  I would not touch them, if I were
doing this patch (unless the HTTP:// variant stopped to work and
only HTTPS:// variant works now, that is).

Thanks.
