Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C065C388F9
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC39420878
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 20:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aHaSuTL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1831041AbgJ0UOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:14:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60736 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1831037AbgJ0UO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 16:14:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59729806EA;
        Tue, 27 Oct 2020 16:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rh26ZWGCKUBOxigIYnMWgSgMnKo=; b=aHaSuT
        L6AeWwc5KbgwhBRlcYC5fhBBi4VKUeWrPhlEgqPer1PYULjzYjpUJ7QodSLcxjU9
        LOJXXHKNHLhMCJ1kUzwjdGR+WkjHFvI8oKWsKu1FkusMpE5vbRouBeL76zomM0w2
        nuazdjrDQAT1n0s8EvwmqyVG9Ce+bdsPMP+SY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TNpLHVPfhwrKU764JnuXPNomaNqGqNR3
        4gVNA5JVx7KcOfRd3ruaAV/4T6asywiiUBjwGBRNjypFTn8qqkcq5AtG6WOWb2tf
        0VjFDDI3PMM5MAyQvt7Hp6CK88dkOZbWHwFP+CJfUAij3CKmgRJme3E7qq0DKy7+
        f5k/9ftC2ec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FC34806E9;
        Tue, 27 Oct 2020 16:14:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4816806E8;
        Tue, 27 Oct 2020 16:14:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/29] completion: zsh: latest patches
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
Date:   Tue, 27 Oct 2020 13:14:26 -0700
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Sat, 24 Oct 2020 22:13:14 -0500")
Message-ID: <xmqqo8knbf4t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03412136-1891-11EB-9B54-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I've been carrying around these patches for quite some time, many have already
> been sent, others I refactored to make them more clear.
>
> But what is clear is that they are needed. I see a lot of people in different
> forums (e.g. Stack Overflow, Oh-My-Zsh, etc.) getting bit by many of these
> issues.

Is this "v2" an update to the 14-patch series you have a late reply to?

There is a tiny zsh completion patch in flight, but hopefully it can
be rebased on this series and graduate together, provided if zsh
users on the list find the topic as a whole agreeable.

Thanks.
