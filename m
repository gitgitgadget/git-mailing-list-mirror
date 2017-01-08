Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 779A720756
	for <e@80x24.org>; Sun,  8 Jan 2017 03:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941936AbdAHDjk (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 22:39:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64122 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932382AbdAHDji (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 22:39:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D35A5C17B;
        Sat,  7 Jan 2017 22:39:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zLUovNbySOXGujQbMBJuIewGZOo=; b=jRvbjo
        uM3V1/l7rA4i+lEFQTpeyQ+s1bSNGdfWvi1mAeu+KBnfH3R6NRQ/uBZXdFGo9Hq4
        S/UsTxTl6ViN+MeAp/eLZEaVW5Yb3bzwhVgwRHhh4YUKhhc494DOPBUQq+HJXCMu
        fR9bH4DEwbC46Uso21NA/AoKuE12fcTiZl3PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WDs5uqugCXt+9ZJYNtp2x8ba1j3xeUKa
        04IKZCaqmhREp9iKOk8fHLQGJjysKCwrji2JnH9b84D3luVLvnENPZSI9h0PbjSx
        8SOqkRS0GK3dZHKkRRxC/NUXZOPCRlMpYX9pbOnV6ISr0vE6Sq8E+zGdvLIFs6em
        DsUiR1Lu3Fw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0603D5C17A;
        Sat,  7 Jan 2017 22:39:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 746725C177;
        Sat,  7 Jan 2017 22:39:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixing some random blame corner cases
References: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net>
Date:   Sat, 07 Jan 2017 19:39:35 -0800
In-Reply-To: <20170106041541.rjzzofal5hscv6yi@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Jan 2017 23:15:41 -0500")
Message-ID: <xmqqh95a1aq0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13A49ECE-D554-11E6-B9EA-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>   [1/3]: blame: fix alignment with --abbrev=40
>   [2/3]: blame: handle --no-abbrev
>   [3/3]: blame: output porcelain "previous" header for each file

Thanks. 1 & 2 obviously look correct.  I'd need to look at 3 when I
am not exhausted, even though I expect it to be also fine from a
cursory read.



