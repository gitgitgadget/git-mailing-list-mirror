Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37863C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115E560EFF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 17:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhJ0Rov (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 13:44:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58253 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhJ0Rov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 13:44:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 004A0E987D;
        Wed, 27 Oct 2021 13:42:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xkhUY7A17miaGBsd5zilbdmN+T9T2VYVSTQ8Fp
        HBF+s=; b=ViNgPOpkhOqiROBjsJxt+fCINEuGrut6tNtkPsy8sK2IlNj1/dh5KG
        g4yLeB27CSIf/0Lrl7XgHFQBNkAnRzQqyxhNsBEm/MBJGU7MDBcqmlfFS45+xCI+
        2NGobcmF3KojGutSkVgXOMqLAMadgCWkd2U0DU6fXBTBEmYPZFzl4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ECABBE987C;
        Wed, 27 Oct 2021 13:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63A2EE987B;
        Wed, 27 Oct 2021 13:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
References: <xmqq5ytkzbt7.fsf@gitster.g>
        <YXeRNkO8B4TP/cau@coredump.intra.peff.net>
Date:   Wed, 27 Oct 2021 10:42:23 -0700
In-Reply-To: <YXeRNkO8B4TP/cau@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Oct 2021 01:25:10 -0400")
Message-ID: <xmqqtuh2weio.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E9EEF8E-374D-11EC-B904-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 25, 2021 at 08:48:04PM -0700, Junio C Hamano wrote:
>
>> * ks/submodule-add-message-fix (2021-10-23) 1 commit
>>   (merged to 'next' on 2021-10-25 at 377e759528)
>>  + submodule--helper: fix incorrect newlines in an error message
>> 
>>  Message regression fix.
>> 
>>  Will merge to 'master'.
>
> This commit has an extra unused parameter in the helper function. I
> think we'd want the patch below on top.

Thanks.
