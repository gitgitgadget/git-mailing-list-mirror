Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECA4C433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 20:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7F8613D2
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 20:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhJDUEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 16:04:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55143 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhJDUEd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 16:04:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28CACD8392;
        Mon,  4 Oct 2021 16:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MRKcReq1/yDlzAWdq01q2B/ERdnLh8nR0D5daV
        aTiek=; b=cCBalYOVyb95L2lHGycnHTzHW4615i0DyrVy6KCrjLQnMQ26q2lFkW
        677hauPXl4/lykdNiNugBhu4FVTE2F3gi8z+pJ8LCXyPihvdbBDeB+YGyQtFlgcE
        90rZU8/jt0rRAboKay4xbffm0yO5H+LMn4hsO8BDKUtGKRGj29MrE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DBBCD8390;
        Mon,  4 Oct 2021 16:02:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7662FD838F;
        Mon,  4 Oct 2021 16:02:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     newren@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Documentation/git-status: remove impossible
 porcelain status DR and DC
References: <CABPp-BFqJi0q0844NKfU8K5HRpAJ7yP2OkyBUiFQSAw-ZjNoyw@mail.gmail.com>
        <20211004190050.921109-1-aclopte@gmail.com>
Date:   Mon, 04 Oct 2021 13:02:41 -0700
In-Reply-To: <20211004190050.921109-1-aclopte@gmail.com> (Johannes
        Altmanninger's message of "Mon, 4 Oct 2021 21:00:47 +0200")
Message-ID: <xmqq8rz8wobi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08AEF06A-254E-11EC-A411-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Altmanninger <aclopte@gmail.com> writes:

> diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
> index 83f38e3198..20f496094a 100644
> --- a/Documentation/git-status.txt
> +++ b/Documentation/git-status.txt
> @@ -225,8 +225,8 @@ C        [ MD]   copied in index
>  [MARC]           index and work tree matches
>  [ MARC]     M    work tree changed since index
>  [ MARC]     D    deleted in work tree
> -[ D]        R    renamed in work tree
> -[ D]        C    copied in work tree
> +	    R    renamed in work tree
> +	    C    copied in work tree

I do not see lines with horizontal tabs used in exiting entries to
skip to columns.  Perhaps these two lines should follow suit.

>  -------------------------------------------------
>  D           D    unmerged, both deleted
>  A           U    unmerged, added by us
