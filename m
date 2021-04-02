Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66699C433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7DF610E8
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbhDBVWZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:22:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57764 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:22:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B817CC8C54;
        Fri,  2 Apr 2021 17:22:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kmCk9d0qCMxemPuYIXsYV7TgZws=; b=vbUnHH
        cYtLwXARurPIU1Pp6MOdB3vMCOvU7YHTucqiT84Ix63kIPyTXfAlXbpO2RdmAG96
        yA/CweF3WoXkGJuu6+39WKAOfy+9CTlU+cxQNeLZcevwTPGaRZ/0g1c99Jkixiha
        QeMFW12a3p/e8OU6DIrDJGN1u0KGbHbKvFF4g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bR7Uw/9iuALMpb5HYdgfD8urK4XZLGuj
        RCw1Rczf1bPindonG+78FKr7ZgCwn8i4l4PlCTyee2/sE1G7AulkyOEmkuOl1RLq
        JvtnIEOMckGb02m19Z8bcSw2xsoXfrj2P5PyIGOdCTyrB1F3RZzdEYgZ+/NSEw3U
        TyCMq8nE6Lw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE7B7C8C53;
        Fri,  2 Apr 2021 17:22:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E3A2C8C52;
        Fri,  2 Apr 2021 17:22:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH][GSoC] user-manual.txt: fix empty heading of introduction
References: <20210402121303.344914-1-firminmartin24@gmail.com>
Date:   Fri, 02 Apr 2021 14:22:21 -0700
In-Reply-To: <20210402121303.344914-1-firminmartin24@gmail.com> (Firmin
        Martin's message of "Fri, 2 Apr 2021 14:13:03 +0200")
Message-ID: <xmqqwntk2xgy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 833A46F4-93F9-11EB-8DA6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

> For future reference, here are the content of the relevant & auto-generated files
> before this commit.

I would have expected to see "before and after".  Is it too obvious
what the postimage would be?  Otherwise, a better presentation would
be to show (an excerpt from) diff between preimage and postimage
output.

Thanks.
