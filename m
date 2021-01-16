Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A08EC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 05:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC23923AC0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 05:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbhAPFdV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 00:33:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64622 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbhAPFdU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 00:33:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6426B8B244;
        Sat, 16 Jan 2021 00:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zmTvXirM2rFQIDaHVsaT0HuCYV4=; b=pCPpsA
        yj/9GxhyoIcLt/L7vEfhDCn2klYeNx2gRhmf/mTeThP7ew/NT+/EzJSFeeWfOlMu
        1YhyNe44mgQQOg66fl7D0Qtujnpq9x2ii0zQoXsK6hhy3pfyHoNeCBumRzjZmFwn
        jBOEZstBTOVAOb+YP6UtK2aETElRQSDajSQVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V0/JmJwDspH+F4pbbHoPdHP/wmrnnpSc
        MX1TwAyG4VdFcr9fw85dGve8Sx//OlCGjAW9+gREPRlnNn5Jf3+3C2d3UbzqQSHF
        I7AX0HSatPf5nO7PsOV5n5PfasCoQ5Gc8nbei2qq5Ia9+Ko0cVxfWCkegv8tDQxH
        upnan9VanfI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D2628B241;
        Sat, 16 Jan 2021 00:32:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDC6F8B23F;
        Sat, 16 Jan 2021 00:32:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2021, #03; Fri, 15)
References: <xmqqbldpr90k.fsf@gitster.c.googlers.com>
        <YAJcwzd7HjkwAOv1@nand.local>
Date:   Fri, 15 Jan 2021 21:32:37 -0800
In-Reply-To: <YAJcwzd7HjkwAOv1@nand.local> (Taylor Blau's message of "Fri, 15
        Jan 2021 22:25:55 -0500")
Message-ID: <xmqq4kjhqwei.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E850A36-57BC-11EB-8C72-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Jan 15, 2021 at 05:00:11PM -0800, Junio C Hamano wrote:
>> * tb/pack-revindex-on-disk (2021-01-14) 8 commits
>>  (this branch uses tb/pack-revindex-api.)
>>
>>  Introduce an on-disk file to record revindex for packdata, which
>>  traditionally was always created on the fly and only in-core.

I think the base "API" topic at its v2 has seen enough reviews and
is ready for 'next', so together with the CoC 2.0 and various fixup
patches on top of ab/mailmap topic, it will appear in 'next' soonish.

Thanks.
