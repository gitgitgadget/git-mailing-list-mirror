Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C64C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35FFC61351
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 14:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhFHODI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:03:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59040 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhFHODH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 10:03:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E04FEC9EA7;
        Tue,  8 Jun 2021 10:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HgMLxy0Q9+KjoapcNO4J9InKCrNTyHakerrQbV
        Novkk=; b=xVNST2VzmqrjBR78KaJvFr3eN6d/boQAUO1TlPz/Fc7VaLjjm4TTur
        74gpdCnRe9o4DtjL9QSa6cICoXA1h9ZULdghhmsWofam1/kKDI6as9jwGFQf/xk6
        c9E9XA4QJ3Sln649csHZmPEbmQm/4x0dnLo8DaiRvnmn7nw1AcSto=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8DC6C9EA5;
        Tue,  8 Jun 2021 10:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A14BC9EA4;
        Tue,  8 Jun 2021 10:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] MyFirstContribution: link #git-devel to Libera Chat
References: <20210608135114.71104-1-raykar.ath@gmail.com>
Date:   Tue, 08 Jun 2021 23:01:12 +0900
In-Reply-To: <20210608135114.71104-1-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Tue, 8 Jun 2021 19:21:14 +0530")
Message-ID: <xmqqzgw0o3pz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC2EAFCC-C861-11EB-8F82-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> It's pretty safe to say that most of the regulars on #git-devel are now
> on Libera Chat. This will help new contributors find the right place, if
> they choose to ask questions on `#git-devel`.
>
> Since there seems to be no way to directly link Libera's web chat to
> `#git-devel` directly, I have put a generic link over the text 'Libera
> Chat'. Users will have to manually type `#git-devel` in the webchat
> interface, but that should be obvious enough to not be worth mentioning.
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>
> My heuristic for determining "most of the regulars are on Libera Chat" is the
> fact that the last biweekly standup happened there.

You CC'ed Emily as the area expert for this document, which is
excellent.  As she was present at the last standup there, I'd expect
her to give her Reviewed-by if the patch looks acceptable to her,
and I'll queue the patch if/when it happens.

Thanks.
