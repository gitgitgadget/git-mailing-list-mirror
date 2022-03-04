Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504F7C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiCDXtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiCDXtt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:49:49 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9BC2C125
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:49:00 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5185112F8E;
        Fri,  4 Mar 2022 18:48:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xrn2uF+/Rn5AZKue4KrA9i8BxRc1TWz8xPbGr5
        dDwzk=; b=cujAcgWXbZwc82TjKCIqJpQlxxUavvLTAXagDP0dUzGHRgXeSC6IvT
        JBhUSSt/edBvEbbNvYm4S6j2o/r3Rc4cHiongZZnF+WMC44luEmIZSGuwLSXikta
        YXYqsQpNC1oSJvzQIjyRUzDrUlnHxKIaWYxPhP55g71VjmEKOeSgo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC2BB112F8D;
        Fri,  4 Mar 2022 18:48:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18F00112F88;
        Fri,  4 Mar 2022 18:48:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 02/10] t5526: stop asserting on stderr literally
References: <20220304224156.637697-1-jonathantanmy@google.com>
Date:   Fri, 04 Mar 2022 15:48:57 -0800
In-Reply-To: <20220304224156.637697-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 4 Mar 2022 14:41:55 -0800")
Message-ID: <xmqqv8wtwa6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A95AFFC0-9C15-11EC-8FDC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The check_ names still aren't changed (as I suggested in [1]) but
> perhaps it's fine to leave it. It doesn't seem to bother the other
> reviewers, and changing it would slightly disrupt the review in that
> there will be extra changes in the range-diff.

At least, please do not count my not mentioning it as such a vote.
I didn't mention it because I saw you did.

Thanks.
