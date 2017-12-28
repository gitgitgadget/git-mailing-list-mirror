Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26261F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbdL1Tjn (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:39:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65283 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753430AbdL1Tjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:39:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 225F4CAB78;
        Thu, 28 Dec 2017 14:39:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ktpeKkIaSOWrZzDMOyP0SKjIy2Y=; b=Ks6WtE
        n8XpizH9MWmjswi9dD2FbAguMKE8N6lNj6s7AAPoqQLR3RBLfMSILkGXK0z/+u5v
        FQGnPXB9xMlTO63EqrwDpN94NRifSmnpnYn9OVv2U0VPZ/E2K3qlIW+l2zLdV+De
        wxjpzbM0/wnjuaeO2CC5VKaW9hjFAkMDNa15o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X83YWmwfO27S19Ol5eDsYSJkSea9eVVO
        t7GyMweMv58kyok/AN3cxACjte5UdBR6+bm9e8IS7unSDvpg6M4GQEDViSIksAxA
        KRpc1Ro5F+//2/EGkjyj0NDmBOaOWr0Z6iIFrA810/hAiOo6iQBgMnQOcZLV5tCy
        VARdZRojjNA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19CF3CAB77;
        Thu, 28 Dec 2017 14:39:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BDE2CAB76;
        Thu, 28 Dec 2017 14:39:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2 0/7] Codespeed perf results
References: <20171226215908.425-1-chriscool@tuxfamily.org>
Date:   Thu, 28 Dec 2017 11:39:40 -0800
In-Reply-To: <20171226215908.425-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 26 Dec 2017 22:59:01 +0100")
Message-ID: <xmqqtvwak5fn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9305CD6-EC06-11E7-9F8B-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This patch series is built on top of cc/perf-run-config which recently
> graduated to master.
>
> It makes it possible to send perf results to a Codespeed server. See
> https://github.com/tobami/codespeed/ and web sites like
> http://speed.pypy.org/ which are using Codespeed.

Thanks for an update.  Will queue.
