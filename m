Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73CD01F991
	for <e@80x24.org>; Mon, 31 Jul 2017 16:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdGaQ7m (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 12:59:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60205 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750944AbdGaQ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 12:59:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12B6AA8A72;
        Mon, 31 Jul 2017 12:59:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Mf8Rvbc1r732kRjQ9Q0222ufEJw=; b=OUSR2q
        oPq+8Kty9ShUSltcKQgOAe6BJH6MyT7BAjtHzoIcFMTYWbNMQYGQC6vVgk+Ep/zv
        +z0r3AT6MwQPpeXm4Eo8xG7gdmU4ssTXNNwRfO4npwpCoBvXCYsUfNqMrZaHI/gi
        igoQU5RnAaBrOd1U2WsrqEl0Q9PyzX4P0B41g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vjfSdn0NpY6CArnZcVpvIQ5T0CK3TOSa
        PcmQH62a9yVBvfdKqKXZcOZnRvpT91bKCte02qw0MU0sFf91AqesULOpoqpwXfaU
        xhnVzrdaNVnyWdql8crQNrAYEsWMAUrumHYrvC0jTbmg4IlKf7NF12ap0++eYPSX
        x9+dGuNbDSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BB18A8A71;
        Mon, 31 Jul 2017 12:59:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72C13A8A70;
        Mon, 31 Jul 2017 12:59:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix minor typo in git-diff docs.
References: <CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com>
Date:   Mon, 31 Jul 2017 09:59:32 -0700
In-Reply-To: <CA+dzEB=cDvp7ZS8x+p+U-5NbK3SNd0FPyj_wP=gvi8mJi6D2ag@mail.gmail.com>
        (Anthony Sottile's message of "Mon, 31 Jul 2017 07:00:31 -0700")
Message-ID: <xmqqtw1silu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A05A3E88-7611-11E7-9DCE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

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

Another thing that is more severe.  You seem to have replaced all
leading tabs with whitespaces, which makes the patch unusable.  For
this single character patch, I can pretend as if I applied your
patch while making the fix myself in my editor, so there is no need
to resend, but please make sure your e-mail client does not do that
the next time.

Thanks.  Queued.
