Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C07C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47DD60F9D
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243418AbhJHVLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:11:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63877 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbhJHVLE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:11:04 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4427514CB47;
        Fri,  8 Oct 2021 17:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=++Mf35IVbRBdRZduC4l2QgIN/84UPFM1b3nMOw
        41hFY=; b=QmSbmLUc+YeaPBqQ21aqU3NKdMHwgBFrtjbu2GhtBUYiT/Fr3IfqKS
        NYIfUsFsTHvQqivlgLoXBbpp/PrPiGU0X5yUIy4iyveoyzxd4OqQxmjcJew17vHO
        pNbTeWUJ1zmZ1440i7ihIvu6yS2Qtkuu5ksgPP8ryHC2INyM9C4ns=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3C87714CB45;
        Fri,  8 Oct 2021 17:09:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F9D514CB43;
        Fri,  8 Oct 2021 17:09:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>
Subject: Re: [PATCH v5 0/2] blame: documentation update
References: <20211008091614.732584-1-bagasdotme@gmail.com>
Date:   Fri, 08 Oct 2021 14:09:04 -0700
In-Reply-To: <20211008091614.732584-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 8 Oct 2021 16:16:12 +0700")
Message-ID: <xmqq7denjkb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F87D8612-287B-11EC-8AAB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Document the default output format for git-blame(1), as well as the
> --color-* options which are currently undocumented but mentioned in
> usage help.

Will queue.  I think we can move this down to 'next'.

Thanks.
