Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B053DC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EBC60F5D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhGZSW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:22:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50095 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhGZSWz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 14:22:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A4F8F136B3D;
        Mon, 26 Jul 2021 15:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+poD726ntTW3eI1ZtKNwDQ+A9U4oTP3zQvgnWI
        2hsgQ=; b=J1zinTnmFowErx9to2Y3XOEmoaMzf5oLBzpCo/OlQQSPprsShUa9v5
        N5JpuJIjPlw8E93uBURRcfUQSmIbvVCRiK6ZIp6oe/05pFFKvqxhmBAugrZExUvs
        n6DXv8jBJs6f1aaL1QR5x1IEvYrjDHot0eTeVahiI9nmXdV4Lbay4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79557136B3C;
        Mon, 26 Jul 2021 15:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BE1F3136B3A;
        Mon, 26 Jul 2021 15:03:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH] submodule: drop unused sm_name parameter from
 show_fetch_remotes()
References: <20210708095533.26226-1-raykar.ath@gmail.com>
        <20210710074801.19917-1-raykar.ath@gmail.com>
        <20210710074801.19917-5-raykar.ath@gmail.com>
        <YPqkHs47VDFBNZ0Z@coredump.intra.peff.net>
        <E30F287A-0E19-45CD-8CA7-1FDA4DF20C61@gmail.com>
Date:   Mon, 26 Jul 2021 12:03:16 -0700
In-Reply-To: <E30F287A-0E19-45CD-8CA7-1FDA4DF20C61@gmail.com> (Atharva
        Raykar's message of "Fri, 23 Jul 2021 22:42:19 +0530")
Message-ID: <xmqqzgu8j3t7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23A23A62-EE44-11EB-98C4-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Yes, this is definitely an oversight on my part, and it looks like this
> topic has already made it to 'next'.
>
> Thanks for the fix.

Thanks, both.


