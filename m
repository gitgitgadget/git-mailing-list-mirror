Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63476C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A9361C1C
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 16:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGFQVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:21:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53919 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 12:21:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54F241475F7;
        Tue,  6 Jul 2021 12:18:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VFZ7XqvP6eV5lBsgQ4ww1ecXfLQ5iW56usT071
        IkDGk=; b=hYb9R0ARtBjc3TifmCGrWxMe4eBeaFYQeTBqH5l4kRAKXCASPnBgQ+
        ZaNNb7VyfaU8JH9qXJ3v6DpE9CbFKYa7BZ1iLMvpwpwqs/tdMFeMn2/zDg8QWu+q
        vLhwTmfGnP7A0T9eR/kG3kC1Rv8Ml9XZmz5FOpvFzrQTp/vCr1KHQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E81B1475F5;
        Tue,  6 Jul 2021 12:18:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C1B11475F4;
        Tue,  6 Jul 2021 12:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Andrew Berry" <andrew@furrypaws.ca>
Cc:     git@vger.kernel.org, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH] docs: .gitignore in parents is current repo only
References: <20210702222044.72767-1-andrew@furrypaws.ca>
        <b9da43a8-897b-7cce-ecbc-ea56078f0f09@gmail.com>
        <889D9AD1-1114-49B4-ADB0-BF78160743E4@furrypaws.ca>
        <xmqq4kd8mt05.fsf@gitster.g>
        <54FBABC9-2BDF-4879-AB5A-BAE4E8179D80@furrypaws.ca>
Date:   Tue, 06 Jul 2021 09:18:34 -0700
In-Reply-To: <54FBABC9-2BDF-4879-AB5A-BAE4E8179D80@furrypaws.ca> (Andrew
        Berry's message of "Mon, 05 Jul 2021 19:50:19 -0400")
Message-ID: <xmqqczrvl8kl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0D820F4-DE75-11EB-8634-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Andrew Berry" <andrew@furrypaws.ca> writes:

> split toplevel to "top-level" or "top level".

Ah, that's even better.
