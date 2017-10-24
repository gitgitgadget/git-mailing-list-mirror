Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891C0202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 05:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbdJXFCP (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 01:02:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62083 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750882AbdJXFCP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 01:02:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 74FB4986C1;
        Tue, 24 Oct 2017 01:02:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=GkW2BNM8nxqh0Ogh0BiPEr1h9kI=; b=DcfcRcw/5X8pmdcAQaf3
        zkcXvLS1BFP8jftXpL/E/ZBEQYpl/VrJ+0gtbBZo5kvq0LBGy3oF12uqhWxZ3p8X
        2x1C0OglzKVKw6m8kPPCT6M8VJuFzf9h9FyjjQ9tL/NpXW6HUGQU8rZFVYyi8Btu
        9yNAKL/TOQLcX9+T9yjuE3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=NbYuNjlSFWJigPeiPzEdlleNoqinKyugOTy0KdpdCj5vCn
        IxIZwcM07WXbpFuYG6F1yNf9YHc8d7H4tU8W5Cf7DvkHGIvu6KWG66mIh1NexIZD
        OWrTKuUnX/kj7pZFPCXQBo1Vm77miHiepYKgrUYMYa8RGn1qcAJVYiXUS9ulQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D0C3986C0;
        Tue, 24 Oct 2017 01:02:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DF71C986BF;
        Tue, 24 Oct 2017 01:02:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Guillaume Castagnino <casta@xwing.info>, git@vger.kernel.org
Subject: Re: [PATCH] use filetest pragma to work with ACL
References: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
        <20171018212451.goqxu4qq6aqe4tpl@sigill.intra.peff.net>
        <1508399608.4529.10.camel@xwing.info>
        <20171019161344.zmwgb2a2rziorffm@sigill.intra.peff.net>
Date:   Tue, 24 Oct 2017 14:02:12 +0900
Message-ID: <xmqqtvypkujv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7FE41530-B878-11E7-8D73-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Attached a cleanup proposal and moving the use at the top.
>
> Thanks, it looks good to me.

I somehow missed this exchange; sorry for being late to pick it up.
