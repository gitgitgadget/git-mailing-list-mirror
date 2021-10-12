Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D5CC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ADC960E53
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhJLX2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 19:28:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57241 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbhJLX2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 19:28:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A428514D124;
        Tue, 12 Oct 2021 19:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tcird+t2Bw6Xy0QreVI1SM/a6o59skjrAVMYcj
        OU4LU=; b=ogQFjqEFQYAuwkDdbt5e7mRPpijGYm+G24cfrtiTuxd2C3R4GMe2mf
        by29vpApGYepyezNioQTMBZ/Y1pXjCNQbaf5rncAt5K9gCgQVN6UeDZw6FawxBZJ
        LPqPiZ/nECagoXJTGFZul+Ffjat6w82UOrDLM/wXa6K9Cm8xLlxKs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9CCD314D123;
        Tue, 12 Oct 2021 19:26:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2C24614D121;
        Tue, 12 Oct 2021 19:26:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] config: make git_config_include() static
References: <cover.1634077795.git.jonathantanmy@google.com>
        <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
Date:   Tue, 12 Oct 2021 16:26:03 -0700
In-Reply-To: <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 12 Oct 2021 15:57:22 -0700")
Message-ID: <xmqq1r4p3jw4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4C3FAF0-2BB3-11EC-9A99-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> It is not used from outside the file in which it is declared.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  config.c | 12 +++++++++++-
>  config.h | 37 ++++---------------------------------
>  2 files changed, 15 insertions(+), 34 deletions(-)

Nice.
