Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E04B420286
	for <e@80x24.org>; Tue, 12 Sep 2017 07:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdILHC3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 03:02:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55539 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750987AbdILHC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 03:02:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D6D290ED8;
        Tue, 12 Sep 2017 03:02:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=30ACyxrCPwSTjHsBqtBG3aabGf4=; b=KmVYgP
        plKaPx4V+EpYCvB1+vS2GtDmfQ2VjXQ4OuTiDSIWXchC425UJ2/mn45JqGbmfVay
        CzUFkwyqeSulJhBYaIXgZ43/4ksjgtSdX6h3ZuqpPCquFg9tfT2Gn0eiDRA+nnR+
        kqL7av2vcA1FmV8NS9MFcomUlBHOQhgafEjB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wmGArmybQV6bnkao/RiHxhp0ZjNKqXZk
        12tursbvWJoWdM3+Ex7zMal9rPvSRNKzqE7c2d51T0rD9xCYJ9gVlpTzJjPKG5By
        jJIHVsOMt+3Oyp6LH/SAj5ElYUldWS5h6aG8l3yiGTj2i4LDyUvDU8JEbKHAKtSF
        EnMawiJ+c5A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73CBF90ED7;
        Tue, 12 Sep 2017 03:02:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C7ACC90ED5;
        Tue, 12 Sep 2017 03:02:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] imap-send: use curl by default
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
        <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
        <20170807200126.fnbz57qd44vj43c6@sigill.intra.peff.net>
        <xmqqy3pk1kjn.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 12 Sep 2017 16:02:26 +0900
In-Reply-To: <xmqqy3pk1kjn.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 12 Sep 2017 15:46:20 +0900")
Message-ID: <xmqqk2141jst.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 565C724A-9788-11E7-BFBC-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I was sweeping my mailbox to collect loose ends that haven't been
> tied down, and noticed that this topic does not seem to have reached
> a conclusion.  Do we want to reboot the effort?  Or should we just
> throw it in the #leftoverbits bin for now?

Ahh, I failed to find newer incarnations of this topic (there was v3 that
starts at <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>)
when I wrote it.  Sorry about pinging a wrong/old article.

I just gave a cursory re-read of the review thread over the v3
series; it appears that we were very close to the finishing line
already?

Or am I yet missing/forgetting some later developments that made
this topic obsolete?

Thanks.


