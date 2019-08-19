Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C4031F461
	for <e@80x24.org>; Mon, 19 Aug 2019 22:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHSW6n (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 18:58:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55824 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfHSW6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 18:58:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C0F5727E0;
        Mon, 19 Aug 2019 18:58:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=knLVj6Bt9OCnFeEufeSd/h6mv3w=; b=oaJoPH
        E2Xns10QSNKNVv+7QsCdKns5Qjni5KTrUFJpuMKgSYFeNDx6UfdjSi51KrCf7Tpx
        vQ0pE4B0Fn+Pxc9F2gRixxaJyu/+q8F8Z5MExy1ES3Bb8xl6yLyWRvE5uLcXo6/p
        JMomRTRMxsVBj+VYL5CgeZEUBAyLMf9+B/aq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AKCQtaIn2zYHfu+bxe/uCxcvTiBpWpVf
        18EqvfWK7OJKvWT/N/as3xTVYcWFcVgdvM4fxHWf2F4qiLfD4/rv/FaC0VQRWnPD
        AeK/hFKTUTZZhqsCh4qimi8PGBsvsdYZ5GdxoyBOiCvrk3AzNQJ2SULGDJOqy4h4
        RYaaDA2bDM4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 74C08727DE;
        Mon, 19 Aug 2019 18:58:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B824727DD;
        Mon, 19 Aug 2019 18:58:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Milman <bpmilman@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repository-layout.txt: correct pluralization of 'object'
References: <20190819213618.69179-1-bpmilman@gmail.com>
Date:   Mon, 19 Aug 2019 15:58:37 -0700
In-Reply-To: <20190819213618.69179-1-bpmilman@gmail.com> (Ben Milman's message
        of "Mon, 19 Aug 2019 14:36:18 -0700")
Message-ID: <xmqqd0h0wyn6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E230AFC4-C2D4-11E9-AB79-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Milman <bpmilman@gmail.com> writes:

> In the description of 'objects/pack', 'object' should be
> pluralized to match the subject and agree with the
> rest of the sentence.

Thanks.
