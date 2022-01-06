Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FC3C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 18:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbiAFSVt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 13:21:49 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50458 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiAFSVp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 13:21:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FA7C1639EC;
        Thu,  6 Jan 2022 13:21:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2jD+K5Zamn+94rNYtdB5ex9lK6s3VVMtEbaigj
        ueOD4=; b=bc30igIqrlDDAkjbhSUT0JqXotxZTefsVbDLibAGX0m6L9k9pQXhqF
        VQ4Hzjh1LS+yyMMXwYWkBFzMZEIWRhc7ShyonHr3evwvTLAc85XXZuV6eZoqFNai
        0VQJpxfXadAd564qOk3D8zN6wRZYbyhCDWq7ao+hQu55eVyQVrejU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 477471639EB;
        Thu,  6 Jan 2022 13:21:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8B391639E7;
        Thu,  6 Jan 2022 13:21:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: tb/cruft-packs
References: <xmqq1r1lfwyq.fsf@gitster.g> <Ydcev8HqCjycBJS+@nand.local>
Date:   Thu, 06 Jan 2022 10:21:41 -0800
In-Reply-To: <Ydcev8HqCjycBJS+@nand.local> (Taylor Blau's message of "Thu, 6
        Jan 2022 11:54:23 -0500")
Message-ID: <xmqqlezsend6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FA1E010-6F1D-11EC-A42C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Feel free to eject this for the time being, especially if it makes
> managing your tree any more convenient. I have a few small things that I
> want to adjust before sending a new version, which likely won't happen
> until after we have finished the 2.35 cycle.

Carrying a topic branch that is not even merged to 'seen' is a
no-cost thing for me.  I'll mark it discarded, but may keep the
actual topic to make it easier to see the range-diff when we see a
reroll.

Thanks.
