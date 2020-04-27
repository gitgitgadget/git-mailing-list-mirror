Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F36C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A494F2076A
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="loZf6n3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgD0VZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:25:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55293 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0VZG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 17:25:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC7B0C73EB;
        Mon, 27 Apr 2020 17:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X5MKc4BuiHMlU+Z2oyTJuhvwE/A=; b=loZf6n
        3L6AF+6uw5eQ9aJ9vzqW9sza05y+V2SKiUdUiQvxaPIouCutojGCcDBGhl9xS4qL
        FiDcmtn58Tb0ssJ6Fo8MXl/M4EwFDFNZffv/2rQPzqz65ijiwnhlahAU8Z1KUKcv
        +QfjKMLD3ip3W4FcaSxQWP58ZMUmS/Cn98rMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yl0OMXL9gJ37MP0xNSxxFnvPAqWGtLM2
        JL+63J0fTgveO7Z3V0od9+B1mb6OWG9wwXSKvYhoxR386aBPaPV8/OpSYb5x82d5
        X+NerFv7tFU+u2wtB2x/O8vJCJ3AIFTFYHirL26AQ85UKjqdF2T/9kBvZKRYk8cA
        wwMHtXLwtYw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3E24C73EA;
        Mon, 27 Apr 2020 17:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8C69C73E8;
        Mon, 27 Apr 2020 17:25:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: drop time.h include
References: <20200425003002.GC17217@google.com>
        <20200427204859.171084-1-emilyshaffer@google.com>
        <20200427210311.GB36078@google.com>
Date:   Mon, 27 Apr 2020 14:25:00 -0700
In-Reply-To: <20200427210311.GB36078@google.com> (Jonathan Nieder's message of
        "Mon, 27 Apr 2020 14:03:11 -0700")
Message-ID: <xmqqh7x47har.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DE3467E-88CD-11EA-A3D9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Emily Shaffer wrote:
>
>> As pointed out in
>> https://lore.kernel.org/git/20200425003002.GC17217@google.com,
>
> This breadcrumb shouldn't be needed, since the rest of the commit
> message already speaks for itself.  We can save the future "git log"
> reader some time by leaing it out.

True.

Thanks.
