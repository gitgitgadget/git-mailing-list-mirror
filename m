Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764C2C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618396100A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 16:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhHBQTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 12:19:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59962 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhHBQTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 12:19:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7B9913D14F;
        Mon,  2 Aug 2021 12:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Von5B/74YgbEo6iyOI8wM/sy21mrMTIgf2OSGn
        TdjuQ=; b=BIUFdVdYQh+G+hIWxOqSXFmShNmAhjmroxBGJMtBtngYmDYimQaX7S
        fK9rfd1pL6HHg0RKk3XlzyJIqh/6i25UNITaksl84zqjK/8V6qf6xKa4bBCCMprm
        iotpgL0eNb+9No8HmlZcD3Px0eiRPzFsC4zZhPMrZhntSAM5bd7iM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C027B13D14E;
        Mon,  2 Aug 2021 12:19:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1441A13D143;
        Mon,  2 Aug 2021 12:19:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2021, #01; Sun, 1)
References: <xmqqk0l4xuvo.fsf@gitster.g>
        <fbe2ba24-e1ed-543c-ec10-bfb90ed384a6@jeffhostetler.com>
Date:   Mon, 02 Aug 2021 09:19:21 -0700
In-Reply-To: <fbe2ba24-e1ed-543c-ec10-bfb90ed384a6@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 2 Aug 2021 11:29:51 -0400")
Message-ID: <xmqq1r7byg3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65FE47A2-F3AD-11EB-B5A3-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 8/2/21 1:45 AM, Junio C Hamano wrote:
> ...
>> * jh/builtin-fsmonitor (2021-07-12) 35 commits
> ...
>
> I'm working on a V4 that will incorporate the comments on V3 from
> the mailing list and feedback from our beta testers of the experimental
> version that we shipped in the GFW and GVFS versions of Git.
>
> I'll hold V4 until after the v2.33 release.

Polishing based on feedback from dogfooders is really valuable.

Thanks for a good news.
