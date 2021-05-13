Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D51EC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394EB6102A
	for <git@archiver.kernel.org>; Thu, 13 May 2021 21:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbhEMVMu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 17:12:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55612 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhEMVMt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 17:12:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F03BD11D999;
        Thu, 13 May 2021 17:11:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0jLs23lzAKnM
        tZAAyLu0WQLVnuHCMNQhQwa05uLg6tU=; b=bPRG+9/T4M3BRbXlsgkIb1oLuuK6
        oo2w8diLgh9N12cJBqmrPlcNSMCUVZZckbpNZ1HN+asWHNll6mw8jtmyKefET8xU
        TWNdQnp5/QMd9v37AMcUQoZXm4GOBul4xUy7QrEtnUSTDJvi++I6xJri8eVJ1hFe
        EDosnyDzI5X66X4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA60A11D998;
        Thu, 13 May 2021 17:11:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4242C11D995;
        Thu, 13 May 2021 17:11:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dave Huseby <dwh@linuxprogrammer.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, christian.couder@gmail.com,
        felipe.contreras@gmail.com, stefanmoch@mail.de,
        philipoak@iee.email, bagasdotme@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3] doc: writing down Git mailing list etiquette
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
        <20210512233412.10737-1-dwh@linuxprogrammer.org>
        <xmqqy2cjcwn4.fsf@gitster.g> <20210513171706.GD11882@localhost>
Date:   Fri, 14 May 2021 06:11:34 +0900
In-Reply-To: <20210513171706.GD11882@localhost> (Dave Huseby's message of
        "Thu, 13 May 2021 10:17:06 -0700")
Message-ID: <xmqqk0o29w55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CD2026AC-B42F-11EB-B066-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dave Huseby <dwh@linuxprogrammer.org> writes:

> I realized last night that there is an important distinction between
> using email to work *with* Git and using email to work *on* Git. The Gi=
t
> ML has its own etiquette and rules and MUA tweaks that may not apply to
> other projects that use Git and a mailing list. The files
> MyFirstContribution.txt and SubmittingPatches are clearly focused on
> using email to work *on* Git. The file MyFirstObjectWalk.txt is also
> about working *on* Git, although unrelated to email and the mailing
> list. Maybe it's time we make the *on*/*with* distinction more obvious
> by creating a Documentation/WorkingOnGit subdir? Just throwing that out
> there.

I agree with that "realization", and think we shouldn't talk
anything about what other people who happens to use Git for their
projects should do, at least for now, when we do not even have a
completed written guideline for ourselves to follow when using Git
for our projects.

> I saw =C3=86var's patches last night and had the same thought. Since it=
 looks
> like this is probably all going into SubmittingPatches, I'll connect
> with =C3=86var and see if we can come up with a patch series for (1) =C3=
=86var's
> re-org and pruning (2) my Mutt MUA settings and (3) etiquette related
> information for discussions around patches and reviews with a (4) side
> note for any general etiquette for non-patch communication.

Sounds good.  Thanks.
