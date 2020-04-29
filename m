Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B379C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A67D208E0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IXiuhEdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD2T71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:59:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51938 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2T71 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 15:59:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 46C63D7DF0;
        Wed, 29 Apr 2020 15:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4m4aP+YjXrNc+HyQuhtWlDfR/m4=; b=IXiuhE
        djFiHZOVEionPlHqzd0ym5HCCZqcXinZYdrugYMBgOl5J7Dmk04y04NT5ARDPoZr
        hxhc79kr5zfzXomQgyWeUf2tvYVxthv716raDaKZaLgPW9YxnWejn/Q7XfV0xEYC
        CMl74GfEOejXCzYGWsL5KEkIwrwAnvwnprtGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Af9JowenB/657R6bzSr9b3stTcZJjhXp
        DFlDuFp8n//A0QTSKuoNVpmsuGYPXSDxz2/80afosglaPeUbaO3FywblvisgDAAi
        GaEax324VZ44mNXmd8rFCzhOu5MeBTuJLLbpAbI+rJvQq4/jE04AkdVbw11+psoS
        KoTIAmA3Zsc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A9B8D7DEF;
        Wed, 29 Apr 2020 15:59:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3DF88D7DEB;
        Wed, 29 Apr 2020 15:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/5] cleanup ra/rebase-i-more-options
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
        <20200429102521.47995-1-phillip.wood123@gmail.com>
Date:   Wed, 29 Apr 2020 12:59:19 -0700
In-Reply-To: <20200429102521.47995-1-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Wed, 29 Apr 2020 11:25:16 +0100")
Message-ID: <xmqqees6vzag.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAB28978-8A53-11EA-A001-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> I've rebased Rohit's patches on master and reworked them with my

OK, it took a bit of time for me to figure it out, but this does
cleanly apply on top of 048abe17 (Sync with 2.26.2, 2020-04-19).

Queued, but haven't taken any deep look at it.

Thanks.
