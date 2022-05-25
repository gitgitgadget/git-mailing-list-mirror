Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A46C433FE
	for <git@archiver.kernel.org>; Wed, 25 May 2022 16:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245405AbiEYQFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245391AbiEYQFm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 12:05:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C87B41F8
        for <git@vger.kernel.org>; Wed, 25 May 2022 09:05:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BA901943EA;
        Wed, 25 May 2022 12:05:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jMZYmrPczCpdsquhybspI3g0l5nyji4Ep5ON2u
        PYTh4=; b=VM2d5HGmi8v3Nd2A4Y+V3ItcjCwUL0TR1B+L3hACyd3ls6atdn8OP8
        IfH5qk/KPUQ2MZQ18PVcYBcbdc0am5y+gjHwcGSN74EUH9sb7qEMKY8XZ/Q22Xh6
        nyEzB6/oticxE/PXLZ9MzLi1c2VEcgBJqcIGYxqLIIm66GXe1yIgI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 631481943E9;
        Wed, 25 May 2022 12:05:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1633519439F;
        Wed, 25 May 2022 12:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Shao-Ce SUN via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Shao-Ce SUN <sunshaoce@iscas.ac.cn>
Subject: Re: [PATCH] Fix wrong info in `INSTALL`
References: <pull.1241.git.1653424998869.gitgitgadget@gmail.com>
        <CAP8UFD2BS3OuJD7xhb6M+bX3ojLqM8ZuXK_h4w0CvdYRfmzVqg@mail.gmail.com>
Date:   Wed, 25 May 2022 09:05:30 -0700
In-Reply-To: <CAP8UFD2BS3OuJD7xhb6M+bX3ojLqM8ZuXK_h4w0CvdYRfmzVqg@mail.gmail.com>
        (Christian Couder's message of "Wed, 25 May 2022 07:29:50 +0200")
Message-ID: <xmqqo7zla985.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80F4EF72-DC44-11EC-995D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> So we could perhaps get rid of the ';', but on the other hand ";#"
> should make it extra clear that the command before it ended and that
> the rest of the line is a comment.

True.  In modern shells, ";" in the ";#" sequence may not be
necessary, but consistently writing ";#" as if it were a single
token would probably be a good idea in the documentation.

Of course, if we can declare that the usefulness of the monospace
plain text document does not matter, we could do without ";#" and
typeset the comment (and the prompt) in different font and/or color.
It would make it easier to see which part of the line is what is to
be typed verbatim.

Thanks.

