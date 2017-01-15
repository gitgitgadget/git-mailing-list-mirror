Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591D71F89C
	for <e@80x24.org>; Sun, 15 Jan 2017 23:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdAOXrU (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 18:47:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751087AbdAOXrT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 18:47:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55D496069D;
        Sun, 15 Jan 2017 18:47:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9EEBY84CsqKurjitw1lBkIEMA6E=; b=mZsewk
        QGfuMPSDvJizlVlStxy385B4LE/ri2jtGw3TN55rDFIRGRVwl6KaRc9GVQWHf/6i
        Ac9IqKXVK4Bz1Q83E87QkKoWdvT8LiV1DB++SNxq9FzHhTUpF+AzsAydP1OJjNQ7
        zqOjeD61+xQrotjRtRAMDixLPbYElF2J1hCKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UjHdFTwRGHWhGNbPYiNh16tNaC1lTtCA
        phdKSrOwBgbN4nqFkseFRcV/NykLT6p5+pnZQqsgXvQ4bHZop17VH9kUaO3xtKEl
        t6ANXehSKxguzheWdo57xvJtmVHrt2z5aeRh3SzG+HKPGf/b5Ib70uEEDuvCU4gR
        pqouDAaF6GI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4CF5E60680;
        Sun, 15 Jan 2017 18:47:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C52A60654;
        Sun, 15 Jan 2017 18:47:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, pclouds@gmail.com, sbeller@google.com
Subject: Re: [PATCH 00/27] Revamp the attribute system; another round
References: <20170112235354.153403-1-bmwill@google.com>
Date:   Sun, 15 Jan 2017 15:47:16 -0800
In-Reply-To: <20170112235354.153403-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 12 Jan 2017 15:53:27 -0800")
Message-ID: <xmqq37gjdgxn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2C1EE1C-DB7C-11E6-B3EC-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This one unfortunately clashes with jk/nofollow-attr-ignore where
Peff adds sanity to refuse following symbolic links when reading
.gitignore and .gitattributes; I'll eject jk/nofollow-attr-ignore
topic for now and see how well this topic fits together with the
remainder of the topics in flight.

Thanks.
