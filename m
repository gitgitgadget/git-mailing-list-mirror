Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B7B1F991
	for <e@80x24.org>; Mon, 31 Jul 2017 16:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbdGaQwg (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 12:52:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57660 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750881AbdGaQwf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 12:52:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3651A0DF3;
        Mon, 31 Jul 2017 12:52:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s8l2HPmq+Es0s53l1/8iqggQJqs=; b=EJyOlf
        kiXf17FXynhrVG+YCeJy4/eIiVWESr2eBEf2FE5KczLV8cNiCT5pf+RGd1dl+RB2
        YP/dGekb5ziaGuSrwWZBXf8YdPVxUMtobsd7vPWvVw8y9yynAawRjFvAOzZ9sgFo
        mHEFVUH2NrkjUYg9OJxAgS4LLshW1BQqfAAOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ILQX6GARoxhi7EvKxmBi5LxLyHGOfnYA
        mDWQ6U4BpPCsXIyY417I6SGsnYd8u7n8EJXY7VNF1iZpJGWwZMG9OTDFtkVC/7Yr
        Te2RYVfzIoyBGQEaT06qP59L/gkXKVjIyq2Ng7s4/TyRc0gazpMI0nzaspOHoX6p
        GfAn6RxTP2s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB6CEA0DF2;
        Mon, 31 Jul 2017 12:52:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E309BA0DF0;
        Mon, 31 Jul 2017 12:52:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix minor typo in git-diff docs.
References: <CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com>
Date:   Mon, 31 Jul 2017 09:52:25 -0700
In-Reply-To: <CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com>
        (Anthony Sottile's message of "Mon, 31 Jul 2017 07:00:31 -0700")
Message-ID: <xmqqy3r4im5y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A21CF702-7610-11E7-845C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> To be honest, I'm a bit overwhelmed by the documentation for submitting a patch!
>
> I tried to follow as best I could, here's my attempt (please advise).

OK ;-)  Thanks for a patch.  Let's nitpick.

Our titles (your "Subject:" line in the e-mail header) state the
area, colon and then a one line summary and ends without the final
full stop, e.g.

    Subject: [PATCH] diff-options: grammar fix

>
> From e88ad689a7587c11f270a10f191a3b6bc52a90d4 Mon Sep 17 00:00:00 2001
> From: Anthony Sottile <asottile@umich.edu>
> Date: Mon, 31 Jul 2017 06:54:14 -0700
> Subject: [PATCH] Fix minor typo in git-diff docs.

Generally these do not belong to the body of the message.  

What object name the commit has locally in your repository is
immaterial.  Whose change it is, when it was shown to the general
public for the first time, and what the title of the change is, are
all in the e-mail header of your message.

One exception is when you cannot convince your e-mail client to put
the name under which you sign-off the patch on the "From: " line in
your e-mail header, or you are relaying somebody else's patch.  You
can then have "From: " line to record the right name, a blank line
and then write body of the message.

>
> Signed-off-by: Anthony Sottile <asottile@umich.edu>

The space above "Signed-off-by: " is to describe what the change is
about, when the title is not clear enough, but I think there is no
need for such extra explanation for this particular patch.

Thanks for correcting my grammar.  Will queue with a tweaked title.

> ---
>  Documentation/diff-options.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 89cc0f4..43d18a4 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -392,7 +392,7 @@ endif::git-log[]
>         the diff between the preimage and `/dev/null`. The resulting patch
>         is not meant to be applied with `patch` or `git apply`; this is
>         solely for people who want to just concentrate on reviewing the
> -       text after the change. In addition, the output obviously lack
> +       text after the change. In addition, the output obviously lacks
>         enough information to apply such a patch in reverse, even manually,
>         hence the name of the option.
>  +
