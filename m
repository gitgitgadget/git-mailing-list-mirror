Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB99A1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 15:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030429AbcJTPes (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 11:34:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52786 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965456AbcJTPej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 11:34:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 156A3461AE;
        Thu, 20 Oct 2016 11:34:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iZBBfZSrjhlC467imETepf0Nzlc=; b=WvcTX8
        QeYVoPHslUWOaSR+Rs9BXwXlk/6fbCLsLIuKTZTL8tXUIN+cCJORRxf54lwvRmsT
        6lGc+88yCz2WH2n3rBYghX+G9CrbzWQh1MwZJFCSZaau3zd6z3yzA1PMV3p7crp0
        e8IPe/ocwkXlPXsBUlBFGr2YTOuVsN/Te7Yyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=affSOO8ZagtZBNw74MIB+S9zRpBcb6Lu
        vRwDCNp9fEL7aH4orS9kODmqh7GugSfwuSDYDqjKAWQKl/frchBeEOcKAivkijci
        j2p0nVQyF3p3BcGKiCoaiXj4OGrykm4R+DJtTVJ7rwkBYZWM4u6wBWrOtEN1jITM
        d03VBlzv4Nk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BE2D461AC;
        Thu, 20 Oct 2016 11:34:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C2B5461AA;
        Thu, 20 Oct 2016 11:34:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Younes Khoudli <younes.khoudli@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: remove reference to the traditional layout in git-tag.txt
References: <20161020132144.6018-1-younes.khoudli@gmail.com>
Date:   Thu, 20 Oct 2016 08:34:33 -0700
In-Reply-To: <20161020132144.6018-1-younes.khoudli@gmail.com> (Younes
        Khoudli's message of "Thu, 20 Oct 2016 15:21:44 +0200")
Message-ID: <xmqqvawnhw52.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B469B15E-96DA-11E6-92B0-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Younes Khoudli <younes.khoudli@gmail.com> writes:

> This is the only place in the documentation that the traditional layout
> is mentioned, and it is confusing. Remove it.

Yeah, the information is not incorrect per-se, but certainly is out
of place and immaterial to what this part of the documentation tries
to teach.

Will queue; thanks.

>
> * Documentation/git-tag.txt: Here.
>
> Signed-off-by: Younes Khoudli <younes.khoudli@gmail.com>
> ---
>  Documentation/git-tag.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 7ecca8e..80019c5 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -253,9 +253,8 @@ On Automatic following
>  ~~~~~~~~~~~~~~~~~~~~~~
>  
>  If you are following somebody else's tree, you are most likely
> -using remote-tracking branches (`refs/heads/origin` in traditional
> -layout, or `refs/remotes/origin/master` in the separate-remote
> -layout).  You usually want the tags from the other end.
> +using remote-tracking branches (eg. `refs/remotes/origin/master`).
> +You usually want the tags from the other end.
>  
>  On the other hand, if you are fetching because you would want a
>  one-shot merge from somebody else, you typically do not want to
