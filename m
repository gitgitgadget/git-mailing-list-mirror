Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC9E1F463
	for <e@80x24.org>; Sat, 28 Sep 2019 07:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfI1H6r (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 03:58:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57936 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfI1H6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 03:58:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FFF935B01;
        Sat, 28 Sep 2019 03:58:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D6Tu7taIoJcIPWPUDOeTETGuvcA=; b=s4MaxE
        3tLdMTM2clmGhwN6Zw6/fZJ+svr6fpJOMoTL0qctuPo0o9mbSlRmZGmlyhoxGRVZ
        d24/FT7AzOmC+b0BLiWMVR23yvsA6g0N1wOLrtMVSVn6vU3ejvRqOkSArqXBJ5ZJ
        Vo8iueqsLyq2B6uvByIyLPJ1LyPPgatBCH/3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y0xVWCdBGJwoLUCvZXzDYjveEK4stox0
        PyLfhWLMCKwEEDMVU5QnGerhVIuO4C6KxcIlP+uAOCeYN7ZwmNUAY5VHwrGfjFHA
        bRYqcS/naYpNAx/2KiEOzPVJcoDIgX5ppQmPC0h8xWLzjfgcZXRM1tMHFkTRRvA2
        CrlWoxlnL6g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3694935B00;
        Sat, 28 Sep 2019 03:58:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9394335AFF;
        Sat, 28 Sep 2019 03:58:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Bi-Weekly Standup - Time/timezone in calendar?
References: <a56e5ebe-53ba-5f20-5606-b4b17dc660b5@iee.email>
        <20190925143247.GD11444@cat>
Date:   Sat, 28 Sep 2019 16:58:43 +0900
In-Reply-To: <20190925143247.GD11444@cat> (Thomas Gummerer's message of "Wed,
        25 Sep 2019 15:32:47 +0100")
Message-ID: <xmqqk19skg24.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB3F1C3C-E1C5-11E9-91F1-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> I thought it was to be 1700 UTC, which currently is 1800 BST her in UK, and
>> 1900 CST in Europe.
>
> That's my recollection as well, and what the calendar should say.
> Thanks for flagging this!
>
> I don't know.  I'd be happy to keep it at 17:00 UTC, but that might be
> a bit early for folks living on the west coast.  I don't have a strong
> opinion on this, but I'm happy to update the calendar (or not
> depending on what we decide) once the decision is made.

By the way, this is sort of off-topic, but should I add this to
tinyurl.com/gitCal (or even better, should I add you as another
editor of the said calendar), so that people have one fewer
calendars to follow?
