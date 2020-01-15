Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA6C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED63C214AF
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 18:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVyNV6mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAOSei (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:34:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51544 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgAOSei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 13:34:38 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF63A93C46;
        Wed, 15 Jan 2020 13:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=id66k2kkwKcCLXKszHpG3DQSqhs=; b=cVyNV6
        mRyKpWBlcU9gtYc00iajvgYL4YF67xLm9HY4gaoWq2DLqmFzrUSwzTU4VptM54Eo
        8oP3NkuxEFW9V3FODXBpK6t4VF5v+vzbIEGuuOKW12gP3EEZxRwamVLfY4njJkvY
        Whcgn0o6vxyinwYQEbB0ZEOZZ1pIVY7t8Q61w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OJjC/gn95P5NoUYR/uWsl779wT0nwdgf
        uNyyoO1KfCLfpMYFZ2E7OTPJm4YpOinD483nYNOcLP3X/Z5cBfx8kH1o2AaYKdoe
        aeE2lk6IEQv3aT40LrorSbT0rIomSpJwpfnXcOyztPOsEsbHYNWQJ0uSxYTsCMdW
        EwN4FP2fFPI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D857093C45;
        Wed, 15 Jan 2020 13:34:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E3DB93C44;
        Wed, 15 Jan 2020 13:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.25.0
References: <xmqqtv4zjgv5.fsf@gitster-ct.c.googlers.com>
        <20200114024938.GA17003@generichostname>
        <nycvar.QRO.7.76.6.2001142258130.46@tvgsbejvaqbjf.bet>
        <20200115154239.GA40131@generichostname>
Date:   Wed, 15 Jan 2020 10:34:30 -0800
In-Reply-To: <20200115154239.GA40131@generichostname> (Denton Liu's message of
        "Wed, 15 Jan 2020 10:42:39 -0500")
Message-ID: <xmqq4kwwk1qh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC85981A-37C5-11EA-8379-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Since 'next' is getting rewound in a little bit, can we requeue Stolee's
> patch with the authorship corrected? Or would it make more sense to
> submit a .mailmap patch on top?

The former.

Thanks.
