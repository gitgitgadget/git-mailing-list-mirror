Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C488AC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD6560F21
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhGWOoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 10:44:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63185 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbhGWOod (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 10:44:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63B27BECAA;
        Fri, 23 Jul 2021 11:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iLKAuDOC/jyi59mTgOW+6TOiSCXlL0dUWqnqnE
        gR0rg=; b=Hmb+wTcfXfkwfx0unG3o/TJOen6ti4LyPIsKyfPTg9Uvc2FMQMQzza
        H8xkiFEKmbIQidFP4MWq59KG/gLWn+7PJE9bAQiHRTKG/iJxoFDK7C1WWk9PSHMJ
        TReBsbFdRol+S2tfwjtHKvFfIBnDv9kS234e32J0EmY2vJxus01Fg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 324A5BECA8;
        Fri, 23 Jul 2021 11:25:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C062BECA7;
        Fri, 23 Jul 2021 11:25:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/5] Makefile: "make tags" fixes & cleanup
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
        <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
        <YPqeX/edrMfYbURa@coredump.intra.peff.net>
Date:   Fri, 23 Jul 2021 08:25:04 -0700
In-Reply-To: <YPqeX/edrMfYbURa@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 23 Jul 2021 06:47:59 -0400")
Message-ID: <xmqq4kclqchb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28293DB4-EBCA-11EB-9447-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thanks. Aside from some cscope appending arcana I found, these look good
> to me. I have no opinion on "cscope*" versus "cscope.out", except that
> it is not worth anybody's time to argue about. :)

Thanks, sorry and I agree with both counts.
