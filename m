Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6071F731
	for <e@80x24.org>; Fri,  9 Aug 2019 18:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437351AbfHISOw (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 14:14:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59420 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436767AbfHISOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 14:14:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 002B5798C4;
        Fri,  9 Aug 2019 14:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lLaB+c161pVK+ljIlQrgO+2ZQvQ=; b=ItXdEw
        3g+fXHzpeyLt9N+qPk/6YG2M4lR+lcxvyeBBP/Lpa741mANWkHH4W4qZGQJRCHPW
        lkxKUxFk82+4lMs7TqJb94+RYwwrGLYCTuC5snqLmecVVnEWPO3597XpAqzMrVoD
        BQI/KeeTVzEsM7wmruPtYhltzQmRxwquE5AVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mpMNdniAyeimNj5jlAX/O5Yu5QYYoIlM
        xbFG3JpxjfrZl1hmmkQLej+/OYJrIAMKN0NUnvgX/JIf5cCENbdAdEVKyizY7UKD
        FfJycIPAzSoeZUUqsoXXc1KJY9GZaKnvOlsdx3QqR1x0xtwG9C0Q0Bm3yYrBw4Qc
        r3k1v6grxU8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBD76798C3;
        Fri,  9 Aug 2019 14:14:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF91C798C1;
        Fri,  9 Aug 2019 14:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/7] trace2: clean up formatting in perf target format
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
Date:   Fri, 09 Aug 2019 11:14:43 -0700
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com> (Jeff Hostetler via
        GitGitGadget's message of "Fri, 09 Aug 2019 08:00:52 -0700 (PDT)")
Message-ID: <xmqqpnlecijw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91499ED2-BAD1-11E9-92CD-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  Will queue.

