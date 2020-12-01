Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677C0C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB447206E9
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 04:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CS2CFzNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgLAEqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 23:46:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61377 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgLAEqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 23:46:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1EE110F502;
        Mon, 30 Nov 2020 23:46:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=bhvdg+q5aNGFcIAsVbTC3M/2DQA=; b=CS2CFzNuXUjru8wDP0H+
        tx4Xi2t0MlYJMN7y97U4Um+PbyU40cg1uvH9abfnbRbKfqVkRW+NA3nyLfCwEVtT
        MnhziNgAWxQkzoPko8nit3qepqAaGWx32aoQeg3qyxdnIReu7I1O8VILgCmUK++t
        totk7lEL+Ws6mTz/cISbL2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=WpGUbl5byYnskJwXvrrG79zUI166hFt69v1QkFuJqkq/aT
        PWRHsb5s//RQekMauU7HCbpjizhzQS8mm4OXSKIsjgEbKqoyN8anIXObPifjLuGg
        yr9InCdk8imXtoBksQtYZqES/Kq7lJfSzVuFN71D1rXeqky5V/e9laFGxJmEA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB35710F501;
        Mon, 30 Nov 2020 23:46:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2D10710F500;
        Mon, 30 Nov 2020 23:46:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Subject: Re: [PATCH] myFirstContribition: answering questions is not the end
 of the story
References: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
        <33e4b940-2560-83b7-1015-100c16c71345@iee.email>
        <20201124201419.GA3783238@google.com>
Date:   Mon, 30 Nov 2020 20:46:01 -0800
Message-ID: <xmqqr1oarv5i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DBA5B30-3390-11EB-96D3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > +to write is because your patchset needed clarification to be understood.
>> 
>> Perhaps a paragraph break here?
> Agreed.
> ...
> Overall a point I really appreciate having written out here. I think
> it's a good addition to this doc.
>
> Reviewed-by: Emily Shaffer <emilyshaffer@google.com>

Thanks.
