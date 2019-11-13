Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900571F5A1
	for <e@80x24.org>; Wed, 13 Nov 2019 02:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfKMCtW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 21:49:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65289 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfKMCtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 21:49:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50454A4499;
        Tue, 12 Nov 2019 21:49:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DPgluDQTYiRja3QZGuVF6/z5DbQ=; b=O6GERa
        kLRrAeIWgYNTjcphFDXUC5RlFq3/fNCUrMqi8/qrGD3Sb1fwwxqJwkX7Gwftnc74
        qpqqIUUrM+GLaPBgrolMSvebh84/VrSljfjiGELjcbG2r0NdpeDKFWQRTVDIkJgV
        Qn+Tcud2qwB9m5sa7uGntchG5GzAw/KxYUU4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fyadBqilnl60S5cn+odiTZiedz59SWdt
        IlEHLEhM7l4ZfgQgPVK8SEhYsGDVXGn9QhzeLgx8qqrhL6XRkWEj/zWM9QipfTaQ
        wldNHVybFMBHzqoLwm3FA3bBerkIQaWPUT03lT5kqTVPWU4mPacNXii+Te4TqAbh
        ctbaE4BZxsw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3623FA4498;
        Tue, 12 Nov 2019 21:49:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6961FA4495;
        Tue, 12 Nov 2019 21:49:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] More fetch_if_missing=0 removal
References: <cover.1573604516.git.jonathantanmy@google.com>
Date:   Wed, 13 Nov 2019 11:49:15 +0900
In-Reply-To: <cover.1573604516.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 12 Nov 2019 16:34:18 -0800")
Message-ID: <xmqqy2wkbidw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F595A02-05C0-11EA-88EC-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> (Whenever, at $DAY_JOB, we encounter an edge case with partial clone, we
> have been submitting patches with test cases for "git fetch" or "git
> clone" but sometimes not both, so between 6462d5eb9a and this patch set,
> these edge cases would be covered too.)

Thanks, wonderful.
