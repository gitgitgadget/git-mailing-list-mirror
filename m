Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5E9C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E0D20678
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 17:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w+HShQ/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgHaRlp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:41:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51964 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728775AbgHaRlp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 13:41:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D582BE792E;
        Mon, 31 Aug 2020 13:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PB2XvrOrQ3N/hIXKMMUNsEqN3e8=; b=w+HShQ
        /N3llDZSYCxnqkoUZnBwASwa9HuuVsvIZaaFeLWr0zAf+4yHi7j++JM+T2sFWfuE
        N6FAJzMpPHVfT2ADGIUzMi7BXVgrtAcLNpvu3RJ/TP2m4Z5OHwkfi6QXLBw8Brsv
        XdEzE1GqBNRW1xBv2dwdfjrlY1mxX+oGe2lp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g0or96o9z25fZVZLzGw2y9JDekVbL9xj
        QdhJfp7sqxeutdPw8e/XROBeqJ/+u9zqh5sR/kd+f9re+Uc2eBp4hfVkpn0B9muZ
        JOemK2eDCngbyYcRMuvufG95kHO7Xx20hhyQG1C4WCJI0OnA5DPk0/KIFABc8SjT
        Td5PBhfWPz4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE050E792D;
        Mon, 31 Aug 2020 13:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 223CCE792C;
        Mon, 31 Aug 2020 13:41:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
References: <20200828065609.GA2105118@coredump.intra.peff.net>
Date:   Mon, 31 Aug 2020 10:41:40 -0700
In-Reply-To: <20200828065609.GA2105118@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 28 Aug 2020 02:56:09 -0400")
Message-ID: <xmqqr1rmg1bf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B1A8DCA-EBB1-11EA-AF2B-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Are we interested in participating in the December 2020 round of
> Outreachy? The community application period is now open.
>
> I can look into lining up funding, but we'd also need:
>
>   - volunteers to act as mentors
>
>   - updates to our applicant materials (proposed projects, but also
>     microproject / patch suggestions)
>
> -Peff

FWIW, I am interested in seeing this project participating.  As
usual, I won't be able to mentor to avoid biases, though.

As to microprojects, I think we saw #leftoverbits and #micrproject
sprinkled in a handful of messages in recent discussions, so with
the help of list archive, we may come up with new ones.

Thanks.
