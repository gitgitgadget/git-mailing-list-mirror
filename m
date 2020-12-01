Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07389C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F8F2080A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgLALsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:48:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:47094 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgLALsi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:48:38 -0500
Received: (qmail 26101 invoked by uid 109); 1 Dec 2020 11:47:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 11:47:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25817 invoked by uid 111); 1 Dec 2020 11:47:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 06:47:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 06:47:57 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cook: add github.com/git-vcs/git as a URL
Message-ID: <X8Ytbbvp7SjrN2g5@coredump.intra.peff.net>
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
 <20201201094623.4290-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201094623.4290-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 10:46:23AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Subject: Re: [PATCH] cook: add github.com/git-vcs/git as a URL
>
> I maintain this mirror, but hopefully we can make it semi-official.

I scratched my head for a moment at why you would main another mirror on
github.com. But I think it is just a typo in the subject. You are
maintaining a mirror on gitlab.com, which seems perfectly reasonable.

> It
> has the same refs as the GitHub one except for the GitHub "pull" refs:
> 
>     $ diff -u \
>         <(git ls-remote https://gitlab.com/git-vcs/git.git/) \
>         <(git ls-remote https://github.com/git/git/|grep -v refs/pull)
>     $

I.e., here it is gitlab.com/git-vcs/git, although...

> As an aside there are also https://gitlab.com/gitlab-org/git and
> https://gitlab.com/git-vcs/git which mostly mirror but also carry some
> GitLab Employee topic branches.

The mention of git-vcs/git here again confused me. Is it an "also", or
is it the thing we are talking about?

> diff --git a/MaintNotes b/MaintNotes
> index 0dc03080de..bb3064e9ac 100644
> --- a/MaintNotes
> +++ b/MaintNotes
> @@ -136,6 +136,7 @@ My public git.git repositories are (mirrored) at:
>    https://kernel.googlesource.com/pub/scm/git/git
>    git://repo.or.cz/alt-git.git/
>    https://github.com/git/git/
> +  https://gitlab.com/git-vcs/git/

This part make sense to me at least. :)

Would you want to get the maintainer to also push to it as part of the
regular push-out, so there is never any mirror lag?

-Peff
