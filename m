Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CBEC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B51224B8
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 20:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgLWU6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 15:58:47 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63097 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgLWU6q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 15:58:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F68910B60E;
        Wed, 23 Dec 2020 15:58:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ywQ3J1kw+B4oBG/6Wsj2TxIQP+k=; b=u0lwZL
        p6VaVwj7ACqQ1d25r8WAh12vCnHk7/QUP9yN5NEzxxKlQH8eVEXp6h6C30w5VJuT
        eSfAJktHh3Y92woZyDprb+SeuSvTT3APcRZl4UNlb6xdL7nGL575mNk4Df+2NQsE
        WZ2ViJgmqToDxqtcse5/FbSWmVVtXgMEPYfuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EgtVqCUt//9lL86ucDUKcasqRxifBkwg
        DREm7ASc9R183QgM9hK9G7YnF3ZLd1Um30tCzqV+89xyXc9RbAyYC26TYU39pj+a
        NqWB3BuIXfIfWpQAlGB9EIcNcBsNL0Ym2yENZRRkQEps+ORKPFk2GfA8YU1b2vyw
        SrU+Xi4qtto=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5736610B60C;
        Wed, 23 Dec 2020 15:58:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7FD3410B60B;
        Wed, 23 Dec 2020 15:58:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        git@sfconservancy.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
        <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com>
Date:   Wed, 23 Dec 2020 12:58:01 -0800
In-Reply-To: <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com> (Derrick
        Stolee's message of "Wed, 23 Dec 2020 09:46:56 -0500")
Message-ID: <xmqqlfdo6y06.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C72F39C-4561-11EB-8F0F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Specifically, "Being respectful" is different from "Have respect", which
> negates your argument for changing this word. We can only enforce what
> is evidenced by actual communication, not the internal lives of community
> members.
>
> I could just as easily argue that it is possible to be tolerant without
> being respectful.

;-)

If anybody wants to change the wording, the argument needs to be
made with the upstream, not with us.
