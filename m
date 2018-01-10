Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B04B1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeAJT5M (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:57:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56753 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751276AbeAJT5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:57:11 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8560B6788;
        Wed, 10 Jan 2018 14:57:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PG9pTKe2gG4OT0dm1dvEjb3ivCA=; b=ernSSp
        FIb8Gxf0Exm4RVtEVI67zTwhZm3FJ84Z2m9LEOFj5FYDz4mcKpdGfczdPIjsAdXq
        +QCf8P2jsMpfmg7IizbQh1MvIIcTeA0ucIXUkzjS5Fw/7d2mVX0awUwaZCZuUijV
        JETJVdMYFd6Xk6SV+DzswOFaP5nJr78MAkOEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kL95J2D3v/tLzozPjpzKVhSftUEYAwVb
        ZajTBZTOzVYR+te4SZeumf6aDuFTgUHjUP1N75c7ePynEMH0KQAgEu/7tOL9f6VG
        90mDXK5DrjSn1n8PTjYxQfTulC9/mtzW+HLnY79+OXrRB4Ly6tq79c8nUs+K7P5e
        CqwHU2EjfGs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D054CB6787;
        Wed, 10 Jan 2018 14:57:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51AFBB6785;
        Wed, 10 Jan 2018 14:57:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #02; Tue, 9)
References: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com>
        <718e2723-9547-8cd6-ac46-07e8631da09a@jeffhostetler.com>
Date:   Wed, 10 Jan 2018 11:57:09 -0800
In-Reply-To: <718e2723-9547-8cd6-ac46-07e8631da09a@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 10 Jan 2018 11:25:42 -0500")
Message-ID: <xmqqshbd1o8a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71ABFEE6-F640-11E7-9F4A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 1/9/2018 6:33 PM, Junio C Hamano wrote:
>> --------------------------------------------------
>> [Cooking]
>>
>>
>> * jh/fsck-promisors (2017-12-08) 10 commits
> [...]
>
>> * jh/partial-clone (2017-12-08) 13 commits
> [...]
>
> Parts 2 and 3 of partial clone have been simmering
> for a while now.  I was wondering if there were any
> more comments or questions on them.  I don't recall
> any existing issues.

Me neither.

I do not mind merging them to 'next' during the feature freeze, but
we won't be merging them to 'master' soon anyway, and I'd like to
see us concentrate more on finding and fixing regressions on the
'master' front for now.
