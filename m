Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587851FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756129AbcH2Uvc (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:51:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52695 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754874AbcH2Uvb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:51:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B23D379EF;
        Mon, 29 Aug 2016 16:51:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y+2cMv2S76YmnpldeafFK87rsH0=; b=BZ1oa/
        odn5l+3YaB1iHS8/D8eH8ki1OECTLcYxJ592iTg9qcVUdSmyO0Hnh11jV1weh3/Q
        XJyvVqihC6KsurSmBNUGUBYUnvoJmBQYqfHlnIcqKNL6gENFbtpHTzzVAVg/k38M
        jH2Um2D+HE6m60bDjn4uj9FbpxtNkTbXrXIsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ir3LVaVwmWMkGaZB130ooCryqyuZqPJd
        GSLSKlVb3fKe5cRCpcoyNvPepqhhIJRSPKrdknQVxvQSyHD6JvhbhEnGIZrZqu6k
        IKkBB/siPwYjf2S9ykx3LQxzlWc/K1mI7nniMtCCjZxXUJw0GiSLsQlnXe8sglq8
        OJEhBLTwIlE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 64B61379EE;
        Mon, 29 Aug 2016 16:51:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5B82379ED;
        Mon, 29 Aug 2016 16:51:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/14] Lib'ify quite a few functions in sequencer.c
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
Date:   Mon, 29 Aug 2016 13:51:28 -0700
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 26 Aug 2016 15:47:03 +0200 (CEST)")
Message-ID: <xmqqtwe38fjj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C6A23D6-6E2A-11E6-9490-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This patch series is one of the half dozen patch series left to move the
> bulk of rebase -i into a builtin.

This was a lot easier to understand compared to the previous round,
and overall looked alright.

Thanks.
