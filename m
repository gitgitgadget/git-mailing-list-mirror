Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDF4C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97695613D1
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 04:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhI2EKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:10:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62841 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhI2EKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 00:10:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36FC6F5688;
        Wed, 29 Sep 2021 00:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D+zNxjkU6P8hFvGe0Runc+FwjxwpFyp0Ojo8Y5
        pzpQ0=; b=IqOykvX2ftsA7N3lnDMXuorrpmpzxGTcMXoq/dUcQvmy7lgJG34ZNw
        tmiokq+sCbC9KuKq67dE9LPGXwOxy39OcGRu5yifa4++VS7G5owsfUjfg4pMMjuJ
        ZxllGxQYN94gUndjNzCSMZAG6blN2McUG8cUmZGKGfPnhL5Pdtmp4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2EB54F5687;
        Wed, 29 Sep 2021 00:08:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CF3EF5686;
        Wed, 29 Sep 2021 00:08:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, t.gummerer@gmail.com, avarab@gmail.com,
        pclouds@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH 2/3] Makefile: avoid multiple -Wall in CFLAGS
References: <20210928091054.78895-1-carenas@gmail.com>
        <20210928091054.78895-3-carenas@gmail.com>
        <xmqqbl4cjt3e.fsf@gitster.g>
        <CAPUEspjvZHEb0X71tFRuFJoxK9eChajfC40OVw7iaup1R+1jZg@mail.gmail.com>
Date:   Tue, 28 Sep 2021 21:08:39 -0700
In-Reply-To: <CAPUEspjvZHEb0X71tFRuFJoxK9eChajfC40OVw7iaup1R+1jZg@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 28 Sep 2021 16:22:54 -0700")
Message-ID: <xmqqo88cf2go.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDC9936C-20DA-11EC-800A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Either way I'll be dropping this series for now, to make sure that the
> minimal change is put forward as part of js/win-lazyload-buildfix
> instead.

Thanks.
