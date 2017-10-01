Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D84B202A5
	for <e@80x24.org>; Sun,  1 Oct 2017 02:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750941AbdJACpY (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 22:45:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53886 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750844AbdJACpX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 22:45:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A47A8905;
        Sat, 30 Sep 2017 22:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bObGKO/pQD9ZxMh8TZdE1mOUn70=; b=XCydlv
        gyd1/05b5uW9f6HVRWXHUtdEtWKswLZ8ht++5j+yP9gAniTajX4gczh4EwiWnMV+
        dOzr9VbYYiZexfPAWRfyEdQR+Q5AC8nn9K+gYt3Z52ZNAo0HAziWdiqo/3g/hk99
        cuM6A6bCvbctK4iOsfF6nlNKh9PdAOVpwiGqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZAMdGdSwStQdjy/qDaCyufeYwHaIb8XP
        p6ufLDZUlaO7oQ/z/bQrWjw4aGR55g+dUhYYQtM7bLk8pFSNKI+i6bvI8EhDgOuf
        jrO3bprlpjM6W6k5CuS+USmYTb9PZSmeApmSToja8R+ETYhJOm5Zux7Q1bTgpbq7
        JznwrlJCpzY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BB66A8904;
        Sat, 30 Sep 2017 22:45:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7E4EA8903;
        Sat, 30 Sep 2017 22:45:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] Add a comment to .clang-format about the meaning of the file
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
        <20170930213731.27133-1-s-beyer@gmx.net>
Date:   Sun, 01 Oct 2017 11:45:21 +0900
In-Reply-To: <20170930213731.27133-1-s-beyer@gmx.net> (Stephan Beyer's message
        of "Sat, 30 Sep 2017 23:37:31 +0200")
Message-ID: <xmqqy3ovvb5q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 922738D6-A652-11E7-B090-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> Having a .clang-format file in a project can be understood in a way that code
> has to be in the style defined by the .clang-format file, i.e., you just have
> to run clang-format over all code and you are set. This is not the case in the
> Git project, which is now reflected by an comment in the beginning of the file.
>
> Additionally, the working clang-format version is mentioned because the config
> directives change from time to time (in a compatibility-breaking way).
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>
> Notes:
>     On 09/30/2017 12:45 AM, Jonathan Nieder wrote:
>     > Sounds good to me.  Care to send it as a patch? :)
>     
>     Like this? :)
>
>  .clang-format | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/.clang-format b/.clang-format
> index 3ede2628d..558fc7fd8 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -1,4 +1,8 @@
> -# Defaults
> +# This file is an example configuration for clang-format 5.0.
> +#
> +# Note that this style definition should only be understood as a hint
> +# for writing new code. Most of Git's codebase does not conform to
> +# this definition.

I think this makes 50%-80% sense.  As we have just seen in the patch
that started this thread, the rules currently in this file is known
not to be perfect (and I do not think the patch was meant to make,
or claimed that it has made, the rules perfect---it was to fix the
most problematic part that was observed and is a good incremental
improvement), so we should treat it as such.  "does not conform to"
does not convey that--it makes as if a random patch to "make it
conform" without thinking if the rules make sense were a welcome
addition, which is absolutely the last signal we would want to send
to the readers.
