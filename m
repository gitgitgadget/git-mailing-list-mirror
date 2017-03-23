Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA8020964
	for <e@80x24.org>; Thu, 23 Mar 2017 19:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935049AbdCWTC7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:02:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64805 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933610AbdCWTC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:02:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F14766A0B;
        Thu, 23 Mar 2017 15:02:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5U+xePGVk1e1Javoxlf6bHG9X5M=; b=UpgAyV
        h+OHGDGg0OQFF9TKvJ/W3zEc5dXAJkv45OFWJsvuVa5VICCrD/azwZQXzirivAKA
        vP5sD1UJ5fjuYg341JghXRWYJzbZahFtN36kbgQdWx8HPglmT3+uhs561Pwx7z3l
        2yMCYFOYmRDhhcTbrIXkWvM9taHLfIQwlMJyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fG0Hk81dOx4JvT/ZCKfO5PAQhR9ZvDV5
        5xc8/bSQyVBQA4LCj1B2XrL4RvzA/rrPX9DqiYfQJpfBp+lbME7MHI7bUw7ZFkVg
        8vtqHM65BB36oPWeXnU1gW4z9oMNUBP/oWFdlTQd+qLePkulz/rnh3umXZdMPgA6
        Ifozq7eyRnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3899466A0A;
        Thu, 23 Mar 2017 15:02:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A37866A09;
        Thu, 23 Mar 2017 15:02:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/config: grammar fixes for core.{editor,commentChar}
References: <20170323173216.26176-1-kyle@kyleam.com>
Date:   Thu, 23 Mar 2017 12:02:49 -0700
In-Reply-To: <20170323173216.26176-1-kyle@kyleam.com> (Kyle Meyer's message of
        "Thu, 23 Mar 2017 13:32:16 -0400")
Message-ID: <xmqqfui3ddeu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FB34F00-0FFB-11E7-91E1-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---

Thanks.

>  Documentation/config.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0d8df5a9f..1df196545 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -737,13 +737,13 @@ alternative to having an `init.templateDir` where you've changed
>  default hooks.
>  
>  core.editor::
> -	Commands such as `commit` and `tag` that lets you edit
> -	messages by launching an editor uses the value of this
> +	Commands such as `commit` and `tag` that let you edit
> +	messages by launching an editor use the value of this
>  	variable when it is set, and the environment variable
>  	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
>  
>  core.commentChar::
> -	Commands such as `commit` and `tag` that lets you edit
> +	Commands such as `commit` and `tag` that let you edit
>  	messages consider a line that begins with this character
>  	commented, and removes them after the editor returns
>  	(default '#').
