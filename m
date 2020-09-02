Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0370DC433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4407208C7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wa6nRXs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIBV1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 17:27:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63558 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBV1N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 17:27:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7EB2BDAF69;
        Wed,  2 Sep 2020 17:27:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V3WE0s6voJeh9aPjg7aqr8cQEFo=; b=Wa6nRX
        s0p1tGWC46njGMWOrG/rrXL1Jb0fbWWDErA3PO5SwjSf3x/LBUCfCTysyXMFyKwS
        QZZNVKXWxb7Fim4eDemqR2UYRHzNBVhXs5S/VuyISttTV2f8AYwPW8WNuuEJKz9I
        hGKBSnDZUe0fMcT5zIKipEoj4KWyWPvjMjg70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vzCSe7pLQNC2edbdsL++rRFetKfocYqH
        PqLUz08KkdpIj7diqXlUQcShabCzI5fkoQ1czrU5O3NZ9wki/JP1Pz+dNeTNYSpW
        nTZMzMdBKI+66aokRrh2ykl61f+3okandXNKgyvL9m6qdgoUOKzTKTynjGao6o2E
        N9kDaTIsIxM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76F79DAF68;
        Wed,  2 Sep 2020 17:27:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5359DAF65;
        Wed,  2 Sep 2020 17:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: no FETCH_HEAD display if --no-write-fetch-head
References: <xmqq7dtcaqob.fsf@gitster.c.googlers.com>
        <20200902210539.1981453-1-jonathantanmy@google.com>
Date:   Wed, 02 Sep 2020 14:27:07 -0700
In-Reply-To: <20200902210539.1981453-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 2 Sep 2020 14:05:39 -0700")
Message-ID: <xmqqsgbzamz8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E5FBD6A-ED63-11EA-A0B3-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks; this round looks good.
