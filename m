Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F802C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEF26108E
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 05:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbhFIFN3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 01:13:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62405 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhFIFN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 01:13:28 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 377F61335A8;
        Wed,  9 Jun 2021 01:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9WMQJYu0nVHzO/IcYIBJW3vAKSAZiRQrsJhMxM
        Wz2vs=; b=nZp6EDww9GV/DH6FOhqSrzS5FVYgTm4/B4bhADcAqKCMlJtNjbZtPN
        6jkl7X/YTT5KJcDy/OusLEJGljeKPg8Dqoz0xnlF+tssTfKQw6hbNsIHj7fCaWaQ
        NbMoMUU81WHL3358VArSUuV9gKSJ8A4XD6gogoBqc3tP22NLb934o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FD8C1335A7;
        Wed,  9 Jun 2021 01:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 78A031335A4;
        Wed,  9 Jun 2021 01:11:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: use starts_with() when checking scissors
References: <20190401215334.18678-1-rybak.a.v@gmail.com>
        <20210608204841.2793591-1-rybak.a.v@gmail.com>
        <YL/n1b641m+wuVHG@coredump.intra.peff.net>
        <xmqq35trn5f1.fsf@gitster.g>
        <YMA8sDr/uuJ9Tst6@coredump.intra.peff.net>
Date:   Wed, 09 Jun 2021 14:11:27 +0900
In-Reply-To: <YMA8sDr/uuJ9Tst6@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 8 Jun 2021 23:59:44 -0400")
Message-ID: <xmqq1r9blj0g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25F76DD8-C8E1-11EB-A9FC-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I dunno. I offer it as an alternative (and am happy to add a commit
> message). But I'm fine with leaving it as-is, too.

I am fine with Andrei's version as posted, which I've queued.

Thanks, both.
