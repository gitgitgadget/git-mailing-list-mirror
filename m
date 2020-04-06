Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E46C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 19:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19272206C0
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 19:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CkBgsqdf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDFTGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:06:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60891 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFTGY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 15:06:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73D7765328;
        Mon,  6 Apr 2020 15:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Ng8C0U4gyllrlpvwtRqbIPBu+0=; b=CkBgsq
        dfoOrwg5ZZN1i0jhFKfamoA+aYnIIhnKqW3SX8zoQKKwTrl4G00gXlxldxQkqz7p
        Oij0XdDtd+nwvFTlGvnf/pXjC/+FVUf7FRZJv2D+vibibsLkF7y0tPT4jELAT5K0
        4kutVcf5Fzz+M58akuW/gmC7qzlod+wwX/AmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tttVgRCrTGAxYc9+QoLi26Wxs1QKJI2y
        Q7MjSGpjDEsIhMbtmoFCGXiSExHkDxRZ6b3I1Vxj5TkM9zCzfdNJHVn8Ktbe8lqD
        ++qUzQtFIRbv/II4I6V/x+d4HFqrJfmPlWqSF6cvMS+fnSU6CmrXNrces67K3qz5
        07EJiTzJi20=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6367565327;
        Mon,  6 Apr 2020 15:06:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6A5765326;
        Mon,  6 Apr 2020 15:06:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        emilyshaffer@google.com, martin.agren@gmail.com
Subject: Re: [PATCH 1/2] gitfaq: cleanup gitfaq.txt
References: <20200406181216.5340-1-shouryashukla.oo@gmail.com>
        <20200406181216.5340-2-shouryashukla.oo@gmail.com>
Date:   Mon, 06 Apr 2020 12:06:21 -0700
In-Reply-To: <20200406181216.5340-2-shouryashukla.oo@gmail.com> (Shourya
        Shukla's message of "Mon, 6 Apr 2020 23:42:15 +0530")
Message-ID: <xmqqzhbov3gy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B410A6F6-7839-11EA-B9C4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> The file contained a lot of whitespace errors as well as some
> grammatical mistakes. Amend them.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 110 +++++++++++++++++++--------------------
>  1 file changed, 55 insertions(+), 55 deletions(-)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 1cf83df118..3ca16b1092 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -23,7 +23,7 @@ Configuration
>  What should I put in `user.name`?::
>  	You should put your personal name, generally a form using a given name
>  	and family name.  For example, the current maintainer of Git uses "Junio
> -	C Hamano".  This will be the name portion that is stored in every commit
> +	C Hamano". This will be the name portion that is stored in every commit
>  	you make.
>  +
>  This configuration doesn't have any effect on authenticating to remote services;
> @@ -32,7 +32,7 @@ for that, see `credential.username` in linkgit:git-config[1].
>  [[http-postbuffer]]
>  What does `http.postBuffer` really do?::
>  	This option changes the size of the buffer that Git uses when pushing
> -	data to a remote over HTTP or HTTPS.  If the data is larger than this
> +	data to a remote over HTTP or HTTPS. If the data is larger than this
>  	size, libcurl, which handles the HTTP support for Git, will use chunked
>  	transfer encoding since it isn't known ahead of time what the size of
>  	the pushed data will be.
> @@ -40,15 +40,15 @@ What does `http.postBuffer` really do?::
>  Leaving this value at the default size is fine unless you know that either the
>  remote server or a proxy in the middle doesn't support HTTP/1.1 (which
>  introduced the chunked transfer encoding) or is known to be broken with chunked
> -data.  This is often (erroneously) suggested as a solution for generic push
> +data. This is often (erroneously) suggested as a solution for generic push
>  problems, but since almost every server and proxy supports at least HTTP/1.1,
> -raising this value usually doesn't solve most push problems.  A server or proxy
> +raising this value usually doesn't solve most push problems. A server or proxy

All of the above look useless noise.  It's not like it is turning
multiple SP after full-stop into a single SP (there is one that is
not touched in the pre-context in the first hunk, for example)---
not that such a change is worth a churn.

Please split them out and concentrate on true errors and typoes;
otherwise it is too distracting and unreviewable.

Thanks.

