Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07AFA1F43C
	for <e@80x24.org>; Thu,  9 Nov 2017 04:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbdKIEUj (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 23:20:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53688 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751495AbdKIEUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 23:20:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 788319FED2;
        Wed,  8 Nov 2017 23:20:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cfg9xa8lKQjA2ZHiOonMCgH1U50=; b=lTYqII
        8ccs7+q8JWPTTJuan5uwP3C7ljQ1VlAiufMMpu/cKXPYNROyOiIxgBQvK1Cg5QZM
        pTgFQdfnsIqmJv9IoKKakdXQJb3hbvvL/4Cn9xpmwboJ2vm2i0o8KnKZXouHWlXO
        TvHl51b40XdicM2i8Ch/lpAHD9y/CdJE+CiAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I4CopfFEQK4mS5Kgn31QCVCuOLmL/yWz
        5W5p7m4AS+gSu6vrC/AFKfkvG8KR1p82jL9O5rFoGMD9bRMS4Jn2yYlL1u1enNIl
        qsY6SVUyVyEjCD7ub19Pjyk7a36FT83CogsSFzQZ+QQMxyLgzqjCLdp7LVCBhlDe
        HYke76X3Aeg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7116E9FED0;
        Wed,  8 Nov 2017 23:20:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB52F9FECD;
        Wed,  8 Nov 2017 23:20:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org, Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH/RFC] Replace Free Software Foundation address in license notices
References: <20171107053933.23370-1-tmz@pobox.com>
Date:   Thu, 09 Nov 2017 13:20:33 +0900
In-Reply-To: <20171107053933.23370-1-tmz@pobox.com> (Todd Zullinger's message
        of "Tue, 7 Nov 2017 00:39:33 -0500")
Message-ID: <xmqqmv3wjd66.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5501B52C-C505-11E7-B37F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> The mailing address for the FSF has changed over the years.  Rather than
> updating the address across all files, refer readers to gnu.org, as the
> GNU GPL documentation now suggests for license notices.  The mailing
> address is retained in the full license files (COPYING and LGPL-2.1).
>
> The old address is still present in t/diff-lib/COPYING.  This is
> intentional, as the file is used in tests and the contents are not
> expected to change.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---

This change probably makes sense.  From here on after applying the
patch, we won't have to worry about updating these every time they
move---not that they have moved often, though ;-)

>  compat/obstack.c                                                | 5 ++---
>  ...
>  ewah/ewok_rlw.h                                                 | 3 +--
>  git-gui/git-gui.sh                                              | 3 +--
>  imap-send.c                                                     | 3 +--
>  ...
>  44 files changed, 69 insertions(+), 103 deletions(-)

I've tried hard to keep the git-gui/ part as a separate project (it
indeed is managed separately).  I have been, and am still only
pulling from its "upstream" repository (Pat, who is its project
lead, Cc'ed), refaining from making changes that do not exist there
at git://repo.or.cz/git-gui.git/ to the tree I publish.

I'll separate the part from this patch that touches git-gui/* and
try to arrange the next pull from git-gui repository would have the
omitted part somehow.  Given that the "upstream" seems to be inactive
these days, we might want to change the way we manage that part of
the tree, though.

Thanks.
