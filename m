Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2175E1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 05:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfKOF4X (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 00:56:23 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59674 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfKOF4W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 00:56:22 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8AC7E8FB1D;
        Fri, 15 Nov 2019 00:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rzg/lXHHK7Ua08su75vYI9I8Hfo=; b=E4r74Q
        SM/fSK31eYDKi0EfjJ/sVcVq+fIp1QkTtTi5oxNZbaqqnjQycT+BuamI84Ju8FzI
        bIzWBSI6r4eHEfxp+0cggZc0F87DHyXGdMcQGgYe3Yyb18DPmw8sfulvgRswFB+6
        iCTHP51kJzgiuYBLjEEg5yfsEy5wkyk4yisaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bTuHEX5mYg7kLq145s8yUodlkRl5EkWc
        EvVwIN/nA+41dglK0OZVbA9yRXrJN9n8X2rnwsRstCaO9iKaz1fdEI3o98KJGYFk
        GafiZ3wr9FpMA87E89Pp1Rukcu398SowWzrDjJnbfqeGmccUBWJSUHk/y1hyD4Ww
        0b3mWHSW+LE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 837828FB1C;
        Fri, 15 Nov 2019 00:56:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B29708FB1B;
        Fri, 15 Nov 2019 00:56:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] INSTALL: use existing shell scripts as example
References: <20191114173316.9190-1-rybak.a.v@gmail.com>
Date:   Fri, 15 Nov 2019 14:56:15 +0900
In-Reply-To: <20191114173316.9190-1-rybak.a.v@gmail.com> (Andrei Rybak's
        message of "Thu, 14 Nov 2019 18:33:16 +0100")
Message-ID: <xmqqftip7ke8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3FEB520-076C-11EA-94DC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak <rybak.a.v@gmail.com> writes:

> Script git-pull.sh has been removed in commit [1].  Use command
> "request-pull" as an example of a shell script instead.  Recently, many
> of shell script commands have been re-written in C, so tweak the wording
> of the sentence, while we're here.
>
> [1]: b1456605c2 (pull: remove redirection to git-pull.sh, 2015-06-18)
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> ---
>  INSTALL | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/INSTALL b/INSTALL
> index c39006e8e7..e3170b3cee 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -116,8 +116,8 @@ Issues of note:
>  
>  	- "ssh" is used to push and pull over the net.
>  
> -	- A POSIX-compliant shell is required to run many scripts needed
> -	  for everyday use (e.g. "bisect", "pull").
> +	- A POSIX-compliant shell is required to run some scripts needed
> +	  for everyday use (e.g. "bisect", "request-pull").

This is not wrong per-se and does improve the section locally (i.e. "pull"
was a bad example of scripts needed for everyday use).

But in the longer term, I am not sure if we want to keep giving
examples in the first place---this sentence will require constant
rewriting.

Admittedly, this "Git is reasonably self-sufficient, but does
depend" section itself is an oddball to list the requirements by the
final product.  We may want to eject the section (not just this
sentence) from INSTALL file altogether, as otherwise, the document
itself is meant for those who build and install git from the source,
and when you are building from the source, you do need a shell
anyway.

Thanks, will queue.



