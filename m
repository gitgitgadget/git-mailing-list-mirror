Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD39E1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 21:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756179AbcK2V4t (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 16:56:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63337 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753834AbcK2VzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 16:55:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C20653F39;
        Tue, 29 Nov 2016 16:55:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fi/vkkSDekMDEY5euLOsq03epLA=; b=gR//n5
        tlKQdC7W7O/3tq6vCPdDqYvRn+IUKT++9Q1b611gwFElZH/lLoVr4QjpKCbGXFIP
        8SUBuUnK+JxgWXVmXZddWBgbZBgiF7JDpFy60O8yGNFX3Di8IsqgXpcZTZbwPQeK
        DfvLlypkVOGhK5jKQrZ4KoVi0VuAIYNLXjL0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O6EwmYjukikI/VhGjwXmd8hkJ7s8Xotl
        b3KXy5RDnayqPxutBGjx0HQwcIv4frnqvtHFUczu6OZxYP/DU7+HeVPWKJFRD/as
        G/z5nSF8DW9XozRyjgvu1n7T+3oeObgZ8505mmVFylstpkgKk8el1Uc42IexJgZC
        0m7t8DqMEPU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ED5253F38;
        Tue, 29 Nov 2016 16:55:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2F8753F37;
        Tue, 29 Nov 2016 16:55:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.11.0
References: <xmqqmvgidlsg.fsf@gitster.mtv.corp.google.com>
        <20161129214243.uunmdc5omlogipso@sigill.intra.peff.net>
Date:   Tue, 29 Nov 2016 13:55:02 -0800
In-Reply-To: <20161129214243.uunmdc5omlogipso@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 29 Nov 2016 16:42:43 -0500")
Message-ID: <xmqqa8cidk95.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B94564A-B67E-11E6-B898-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Nov 29, 2016 at 01:21:51PM -0800, Junio C Hamano wrote:
>
>> The latest feature release Git v2.11.0 is now available at the
>> usual places.  It is comprised of 673 non-merge commits since
>> v2.10.0, contributed by 74 people, 15 of which are new faces.
>> [...]
>> Jeff King (117):
>> [...]
>>       common-main: stop munging argv[0] path
>
> Oh, I didn't expect this to go in at the last minute. The regression was
> actually in 2.10.0, so I figured it would just end up as part of 2.11.1.

To be honest, inclusion of this was a screw-up ;-)  I couldn't count
between 2.10 and 2.11-rc.
