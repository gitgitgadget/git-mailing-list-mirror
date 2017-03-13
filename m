Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EAB71FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753289AbdCMSEV (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 14:04:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64531 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752561AbdCMSET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 14:04:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05FBB82B59;
        Mon, 13 Mar 2017 14:04:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vNz5xZIIM9jvvEi0qMq4YkM7vUk=; b=eeuKD1
        BLYbZUlRRWUxqBVXyqmRAEEVYRm2oFSi0Zni24jwJ75ps6Bm7EOWW+xW/Fqmzpd5
        78QaWDCziGWM3gaYaiS5/R1AMHz+EnS9pqsGFOrYQ5epiTsPdCdTwdzo8CKB67Ga
        8D8HmrXvAs3MG1EAPyRPgITTRs8HFvNX6l4Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xZw5Kk0TQiZW5xKxomYRYO+Ths2N7AuQ
        ZFwYr7bW+5j4hH4thE0yYAENd7yJISTsVNWv08zgCEXwCMhDohNFTXYdvfWoUHnj
        Bkdw1kArSek2mvHaTLAg57wsLWkCkzk+XxwQi+X8i8zUpqYIBluVU5o0AdFJ5IxN
        ApmEucvnznk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F28C382B58;
        Mon, 13 Mar 2017 14:04:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5E70A82B57;
        Mon, 13 Mar 2017 14:04:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH 3/3] Update documentation to reflect new socket location
References: <20170313172232.96678-1-lehmacdj@gmail.com>
        <20170313172232.96678-4-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 11:04:16 -0700
In-Reply-To: <20170313172232.96678-4-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Mon, 13 Mar 2017 13:22:32 -0400")
Message-ID: <xmqqy3w9rr33.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 79830E56-0817-11E7-82F5-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> Subject: Re: [GSoC][PATCH 3/3] Update documentation to reflect new socket location

Read the above single line and nothing else, while pretending you do
not know what this patch is about at all.  That is what readers of
"git shortlog" will see.

It may be obvious for you, but can you tell whose socket the series
has updated in 6 months after forgetting what you worked on?  The
title does not give any hint that this is about the credential cache
daemon.

> Signed-off-by: Devin Lehmacher <lehmacdj@gmail.com>
> ---
>  Documentation/git-credential-cache.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
> index 96208f822..4b9db3856 100644
> --- a/Documentation/git-credential-cache.txt
> +++ b/Documentation/git-credential-cache.txt
> @@ -34,7 +34,8 @@ OPTIONS
>  
>  	Use `<path>` to contact a running cache daemon (or start a new
>  	cache daemon if one is not started). Defaults to
> -	`~/.git-credential-cache/socket`. If your home directory is on a
> +	`~/.git-credential-cache/socket` if it exists and otherwise
> +    `$XDG_CACHE_HOME/git/credential/socket`. If your home directory is on a
>  	network-mounted filesystem, you may need to change this to a
>  	local filesystem. You must specify an absolute path.
