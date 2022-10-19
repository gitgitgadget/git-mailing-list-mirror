Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94079C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 16:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJSQUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 12:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiJSQUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 12:20:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08D5114DF5
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 09:19:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80EDC1C0CE7;
        Wed, 19 Oct 2022 12:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+5M1RcGWhYQaDGWGGY/GnM6mL+UxsJwLiA/a7u
        Ivo0U=; b=JvTzL8DOoTazLBca7bZSdElF3DtiEaygR4h+td9IC/3tHdcQMZYxs/
        s9v81ZfxlJepI0zlEB4C6bkfkiI0G4ZgaSad9JiY32UqC21Wyz+SNgATRcczMtFY
        lKsspnkJmNcbgs4vUjfKLbjgPz8TY4sxZtDe4DcMEtUkihMZcomDU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 796D01C0CE4;
        Wed, 19 Oct 2022 12:19:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B28FE1C0CE3;
        Wed, 19 Oct 2022 12:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     Jerry Zhang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 7/7] documentation: format-patch: clarify
 requirements for patch-ids to match
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
        <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com>
        <69440797f302729d59f19c0994916e193c9dbf58.1665737804.git.gitgitgadget@gmail.com>
        <xmqqo7ua1nrz.fsf@gitster.g>
        <CAMKO5CuqLSowSo3fhOux-fY8ek-CL4zudgA0fBjXAt+9CBhs9g@mail.gmail.com>
Date:   Wed, 19 Oct 2022 09:19:52 -0700
In-Reply-To: <CAMKO5CuqLSowSo3fhOux-fY8ek-CL4zudgA0fBjXAt+9CBhs9g@mail.gmail.com>
        (Jerry Zhang's message of "Tue, 18 Oct 2022 14:57:27 -0700")
Message-ID: <xmqqtu3zss47.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD42206C-4FC9-11ED-927C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> I can add a note about diff algorithm as well.

That's totally different from what I had in mind.  We _could_ be
more specific, but I do not think that helps users, as we cannot
promise we will keep using the same diff algorithm and parameters,
and the implementation would change to give "better" output for
human consumption that is not byte-for-byte identical to older one.

>> So, I dunno.

So, I do not know if more description is a good idea to begin with.
