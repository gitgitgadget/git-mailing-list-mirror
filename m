Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E45BC2BB1D
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441FB206A1
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GpX2dJYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDHBRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:17:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56766 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgDHBRp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 21:17:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2A8948C29;
        Tue,  7 Apr 2020 21:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=e
        iYo1z2P+E7Te+2tpZWP9+q/PKY=; b=GpX2dJYkL8BWMqyyw8FQLVLX45yu5E3N1
        ZhZg6SkynnAuomRJfDiGK0XCfIq0bmIRMGnA+1QVEz0kdvOQUB/4Z8xCyl9vJHFs
        dIgWGU7TM4mpP/KsXqxpQVUAqk8EpXTyVSLvsrUkMgTJZK2gjS07FJT+IclxdG4p
        IbOcpzhyp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=hux
        UZj3dpRD9zzZCrsfbelPrRydJfbWy5d8o/cZ8+bPIAh//juUHcTrfFz7YLaeJV83
        /4lYqMI8rZ3y2lKSm1mR4wMqCYFtFQJhXqqybZdQ7g1H6gRVsm8UfpFCJG8mkJmn
        3XeCZ2fmb3s/dLs6ePhnYs1SGHGF4dwUEU2fKnwU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9F0C48C28;
        Tue,  7 Apr 2020 21:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10D8E48C27;
        Tue,  7 Apr 2020 21:17:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Happy birthday to all of us ;-)
Date:   Tue, 07 Apr 2020 18:17:41 -0700
Message-ID: <xmqqzhbmpyh6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE94FEEE-7936-11EA-818B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, it was today 15 years ago that Linus announced the availability
of the first tarball of Git.  

Let me thank all the contributors, both long timers and relatively
newer ones, for working on the system to help our users better.

But I should not forget to thank others who help us by doing things
other than writing code.  Writing code is not the only work on the
software.

Some contributors are good at polishing documentation, which we the
developer types are not particulary good at.  Others help new
developers to get up to speed, mentoring them in programs like the
summer of code and Outreachy.  There are folks who help us with
legal work to manage and defend our trademark, which is taken care
of by Software Freedom Conservancy, which the project is part of.
Employers of "professional" Git contributors support the project by
letting/making us work on Git, admittedly with their own agenda, but
without necessarily being 'evil'---a particular area of interest
they support, be it the lazy-clone scalability work, or more
aggressive recursing into submodules, would eventually benefit all
users.

Thanks all, and let's look forward to see the next 15 years be as
wondreful years for Git as the past 15 years ;-)

