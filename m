Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D4520C11
	for <e@80x24.org>; Tue, 28 Nov 2017 04:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbdK1Ef0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 23:35:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54033 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752088AbdK1EfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 23:35:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE796C2325;
        Mon, 27 Nov 2017 23:35:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NvYTdpjHuHZpec5xFxZSVTtVvpE=; b=YAxF7C
        KY3WzXrEuTNYPQYtYX0yRCCQM9pdRkGAKM1oSetf8zYOMbcWxoXzLYLmaTsCzvkH
        rVhWxFYSK9l8WE3Fn0ofqqhzAYlzLeyAPZmGqslHIive1/SJcGCQTAVCAvmb/C9+
        xyQdML4gj+PCiOD9b4Q9bE9hOOam8PA29MDoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XNdATcddvhX8/i9sFswFAPZgdVXuNTgU
        KsrPwR1bUpTiGyu+uQZntx2cnS1gMwuWJpP4B+9wSlWXpAIPy/g/17bQbG7PnQOH
        JswH7yGRX08eOaOtPKVod7gKmQxfGCYdrXlK9+KUQD6EGK26qNv1oRjZ4TYie4S/
        l4Q1F7+LWHU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B789FC2324;
        Mon, 27 Nov 2017 23:35:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D23BC2323;
        Mon, 27 Nov 2017 23:35:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
        <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
        <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
        <20171126191510.GA1501@sigill>
        <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com>
        <xmqqshd0e41a.fsf@gitster.mtv.corp.google.com>
        <20171127043502.GA5946@sigill>
        <CAP8UFD2tB_CpopP5OuqPSBfeeGzXfoC_Hz-UeT=eNW1fU6zyzA@mail.gmail.com>
        <20171127152748.GA23218@sigill.intra.peff.net>
        <xmqqo9nn9tmd.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 28 Nov 2017 13:35:23 +0900
In-Reply-To: <xmqqo9nn9tmd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 28 Nov 2017 08:42:02 +0900")
Message-ID: <xmqqlgir6mwk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CE9345C-D3F5-11E7-BBFC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> without having "wish" on the build machine. If everybody is happy with
>> the BYPASS mechanism you added to address that, then I'm perfectly fine
>> with it.
>
> OK.  The topic was queued on 'pu' yesterday; lets move it forward
> after waiting for a few more days to see if there are further
> improvements and/or objections.

It seems that TravisCI objects ;-)

    https://travis-ci.org/git/git/jobs/307745929


