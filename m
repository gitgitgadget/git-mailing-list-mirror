Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BBAE202F2
	for <e@80x24.org>; Wed, 22 Nov 2017 10:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbdKVKeU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 05:34:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59562 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752581AbdKVKeS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 05:34:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BAA2B5DA3;
        Wed, 22 Nov 2017 05:34:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LPegb+NSpns8BabxVcRBSP4BSGM=; b=HhKWSJ
        Q1XJ5sog/t0sIg0TjBKH9fFW4JktgrEvVsInEMDRSErQSFlD9l9mlwq3AR51eczN
        QaOPPnU6CBSbg7/O/ihBEIUaRUTodV1KpufN5cwNOtl8CO4z1FvY/hNQmUfNeIky
        dSDfE2ujl2ZT1Ilffb9Hoqw3C3bSZFvQp62GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cSH3K2Pv23oLq9NZcwXNPUYOfleGNxjN
        /+uyGZ+x3VltJrmmqZ+MXGFKfOw9yJBzw6epqqIOf8geMZi85ZsgNpRp2f+7JNSV
        OGB50xFoDDK7Wg6EFWf4fzqGMQtPQo9KQ+r5inotduOEL4MatyMWzkgBgfbWhoeQ
        ioSa6d8gn+A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33B82B5DA2;
        Wed, 22 Nov 2017 05:34:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0DBBB5DA1;
        Wed, 22 Nov 2017 05:34:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
        <20171121214552.GB16418@alpha.vpn.ikke.info>
        <alpine.LFD.2.21.1711220453290.3814@DESKTOP-1GPMCEJ>
Date:   Wed, 22 Nov 2017 19:34:15 +0900
In-Reply-To: <alpine.LFD.2.21.1711220453290.3814@DESKTOP-1GPMCEJ> (Robert
        P. J. Day's message of "Wed, 22 Nov 2017 04:55:12 -0500 (EST)")
Message-ID: <xmqq3756txeg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0BFF610-CF70-11E7-9DED-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> git repo with a file called "Gemfile", so i created a branch called
> "Gemfile", and when i ran:
>
>   $ git checkout Gemfile
>
> git switched to the branch. so even with the ambiguity, git obviously
> has some sort of precedence order it checks. so what are the rules
> here?

31b83f36 ("Merge branch 'nd/checkout-disambiguation'", 2016-09-26)
should have made it clear that the "checkout" command has a
convenience special case.


