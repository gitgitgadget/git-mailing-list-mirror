Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D1C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD24F2077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FE7R5Wpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390101AbgDBRkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:40:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61354 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389245AbgDBRkk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:40:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F0D0C8E0C;
        Thu,  2 Apr 2020 13:40:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WZOwc+F+2pkFWFvD4RoWZWHjU1s=; b=FE7R5W
        pe0jT6tATXuDIqFO+pusZnoSwtLQ0cJXYeHA4nxjT+B/Fo7hQ5coGZhrAOBPKgxL
        WSVPJFIYnGns/h5kx352W86ZiOkBJO96Q5vxUx+TLg36yV5xQxzNtnBrXffRE4GR
        wBQXuaaQCZZVq2rmpR5UdtJf0sKxOI7+YHh5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J/h5mBPFh5+WBJJkuNjCzX8SkxlQfpm1
        x6aLMH5exZuoqKcqRcAkhM7CbJFfAGCCSXy+EAbxZP4Kx5UfCTYVe3B/IVXZ+eDr
        DMh/7AmjPYP8/VmBmb8EFCdKwJwVvNn79YAmnuzwDXC0fWVQ6OPqsRocGmTAB2pI
        6VU89jamgV4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 87473C8E0B;
        Thu,  2 Apr 2020 13:40:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5445C8E09;
        Thu,  2 Apr 2020 13:40:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2020, #10; Tue, 31)
References: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
        <eb588d3b-eec4-b904-82ed-80b228387726@gmail.com>
Date:   Thu, 02 Apr 2020 10:40:34 -0700
In-Reply-To: <eb588d3b-eec4-b904-82ed-80b228387726@gmail.com> (Garima Singh's
        message of "Thu, 2 Apr 2020 08:42:05 -0400")
Message-ID: <xmqq5zeh4wh9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F3A8918-7509-11EA-BF79-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:

> On 3/31/2020 7:04 PM, Junio C Hamano wrote:
>>
>> --------------------------------------------------
>> [Stalled]
>> ...
> I sent out v3 of this series on the 29th of March. 

I think what was listed has already been updated with the v3; it was
my mistake to leave it in the stalled section (in the draft I have
for the next issue of "What's cooking" report, it already has been
moved to the cooking section).

Thanks.
