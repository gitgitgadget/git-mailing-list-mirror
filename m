Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE2C2D0E4
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 22:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABF92240C
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 22:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cgQyWWD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgKTWem (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 17:34:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52372 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbgKTWem (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 17:34:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2B4BA20B9;
        Fri, 20 Nov 2020 17:34:41 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jDN+K/OiAtCg7vT7ePsJ+kQfIr0=; b=cgQyWW
        D1jHHl4kgHg5aizCmbqUBSoBaUC5yJza15ssUCEbyZF33f52NhPs606vIPKqz4m8
        t8US5EiZgEa92I9pO1YzAjmx159uTA5X5ZSVLB8WbxRi1GmD7PZRzstFc2jyAdus
        9mzB9d2A+Lfv9YVFLyEj8KE4usuE89KGU6hpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RMkwpaRDC4VHIOW7GkXOZD++1XqOHj4y
        nda2S7syx/lUxxFuUtess5vyQsOHu905IW9lLtRpBAJ5UE7ouotjSn4ORAyU1SPI
        cosBNyfTK8uikBczw0tsv7SDEf7gLGKMepKCT38oCi65PXmCYehXWbviwVRY6nNc
        g0HXtc+zBwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98ADCA20B8;
        Fri, 20 Nov 2020 17:34:41 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1227A20B7;
        Fri, 20 Nov 2020 17:34:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] myFirstContribition: answering questions is not the end
 of the story
References: <xmqq3613vrtx.fsf@gitster.c.googlers.com>
        <33e4b940-2560-83b7-1015-100c16c71345@iee.email>
Date:   Fri, 20 Nov 2020 14:34:40 -0800
In-Reply-To: <33e4b940-2560-83b7-1015-100c16c71345@iee.email> (Philip Oakley's
        message of "Fri, 20 Nov 2020 21:42:16 +0000")
Message-ID: <xmqqblfru073.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94563330-2B80-11EB-ADFB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Is this also worth mentioning in SubmittingPatches?

Yes, see what I wrote immediately under three-dash lines.

My wish is that, once we know the complete message we want to send
with this longer document, we may see some volunteer to update
SubmittingPatches with a more condensed version. ;-)

Thanks.

