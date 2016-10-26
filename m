Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887642022A
	for <e@80x24.org>; Wed, 26 Oct 2016 22:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbcJZWsH (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 18:48:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57493 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754604AbcJZWrm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 18:47:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 158734A981;
        Wed, 26 Oct 2016 18:47:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4Rp5IHyJ+FpC7H3etJ1NV7SrPiM=; b=hhT/4F
        5xdtXkwkuQJoiXpRkItmr3dHo4TaxXpvypVaHJr6XKJerIc3T/ngcYcOqD7guA4k
        y3VkrKsIjrsD5XsixWCUBYSfajv56fQeYo2aHSFcHqI6zm+w+CkAzXeVYXgQ7N6J
        SuoPo/LxVKVWoHSRt70pjGLIOtkP7LyxQfrdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RZ25r10X/+ipdGsr8t1lksSA4NORdjwG
        11M/KSC+g8EeyWBzsVB/kJ4JAVoqyjDXMwbzxSgszAothWvPqZxTZs5i63InTz6H
        iV1PASMO3ZP3CXu4UO2K4LcgiQXQUmcjNJI7yc1sVXs+tnbVxxdIo/zNNyRwct39
        KE/FrIpae90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D0634A980;
        Wed, 26 Oct 2016 18:47:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 846474A97F;
        Wed, 26 Oct 2016 18:47:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Oct 2016, #07; Wed, 26)
References: <xmqq4m3ybv7h.fsf@gitster.mtv.corp.google.com>
        <50f4e0b0-c044-be57-4e08-08d9970fe4a4@google.com>
Date:   Wed, 26 Oct 2016 15:47:38 -0700
In-Reply-To: <50f4e0b0-c044-be57-4e08-08d9970fe4a4@google.com> (Jonathan Tan's
        message of "Wed, 26 Oct 2016 15:42:21 -0700")
Message-ID: <xmqqzilqafsl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 332DB8C6-9BCE-11E6-A011-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 10/26/2016 03:29 PM, Junio C Hamano wrote:
>> * jt/trailer-with-cruft (2016-10-21) 8 commits
>>  - trailer: support values folded to multiple lines
>>  - trailer: forbid leading whitespace in trailers
>>  - trailer: allow non-trailers in trailer block
>>  - trailer: clarify failure modes in parse_trailer
>>  - trailer: make args have their own struct
>>  - trailer: streamline trailer item create and add
>>  - trailer: use list.h for doubly-linked list
>>  - trailer: improve const correctness
>>
>>  Update "interpret-trailers" machinery and teaches it that people in
>>  real world write all sorts of crufts in the "trailer" that was
>>  originally designed to have the neat-o "Mail-Header: like thing"
>>  and nothing else.
>>
>>  Waiting for review.
>
> For this patch set, should I look for another reviewer? In the e-mail
> thread [1], you and Stefan seemed positive about this patch set.

Ah, I meant "waiting for the review to conclude".  If nobody has any
more comments, I am OK to start cooking it in 'next'.

Thanks.
