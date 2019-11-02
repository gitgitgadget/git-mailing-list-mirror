Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333511F454
	for <e@80x24.org>; Sat,  2 Nov 2019 05:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfKBFng (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 01:43:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBFng (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 01:43:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A22229CCFE;
        Sat,  2 Nov 2019 01:43:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e8A0L09dNC0o8hkg89g6n+MYuDw=; b=bcJlk2
        uKZjRYtDRYZdNqE6A/VYVIpRFWRBPGev5Ydyap2tuLQSlxSgTTNcpl5wjx37KK+c
        G3wzOwj6IijfGIPbGZUTdzLMM/9SBulu5Hsj4iMZumCDd1/GrnxgIqXe9v/0rZPA
        GBHMvq5p2X7vnywEnxS5rw/PWGUE6wBamVQ00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P4JthMag0uZUpdVnf1IE3kZRClys+dSD
        LzR74GhcQhsaa3hsaET8T7Gkp5Nypso9+VJKDDR59vBSUa8k0aYPbZoec5TW9uB3
        wCELXnFO+DVkNEDAqcBShuVm83T2PlmROyAOXxMDMFF/3I+JrrJpfJti32OfShwr
        7LhBMaJAtD8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F29B9CCFD;
        Sat,  2 Nov 2019 01:43:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEB789CCF2;
        Sat,  2 Nov 2019 01:43:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] git-shortlog.txt: mention commit filtering options
References: <20191030203603.27497-1-me@yadavpratyush.com>
Date:   Sat, 02 Nov 2019 14:43:29 +0900
In-Reply-To: <20191030203603.27497-1-me@yadavpratyush.com> (Pratyush Yadav's
        message of "Thu, 31 Oct 2019 02:06:03 +0530")
Message-ID: <xmqqftj64yv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4A3E3B6-FD33-11E9-AB9B-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> git-shortlog, like git-log, supports options to filter what commits are
> used to generate the log. These options come from git-rev-list. Add a
> pointer to these options in the documentation page so readers can know
> these filtering options can be used with git-shortlog too.
>
> Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> ---
> Since [0] didn't get any responses, I figured a patch might get some
> more attention since it is something concrete to comment on.
>
> [0] https://public-inbox.org/git/20191024191709.gqkjljuibyashtma@yadavpratyush.com/
>
>  Documentation/git-shortlog.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index bc80905a8a..acae695388 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -76,6 +76,11 @@ them.
>  Paths may need to be prefixed with `--` to separate them from
>  options or the revision range, when confusion arises.
>
> +In addition to the options above, 'git shortlog' also supports a range of
> +options to select which subset of commits will be used to generate the
> +shortlog. A list of these options can be found in the "Commit Limiting"
> +section of linkgit:git-rev-list[1].

How does "git log --help" handle the corresponding part of its
documentation?  

	... goes and looks ...

I wonder if it is better to just include rev-list-options.txt like
"git-log.txt" does, instead of adding these four lines?

Thanks.

>  MAPPING AUTHORS
>  ---------------
>
> --
> 2.21.0
