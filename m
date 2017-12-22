Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8514F1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 21:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756257AbdLVV3V (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 16:29:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61161 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755458AbdLVV3V (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 16:29:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75057BF380;
        Fri, 22 Dec 2017 16:29:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lh0tZNZxwH9qCq2OPJMk0pBKSec=; b=IcugQb
        g2MoF5nxWr7Nd5OtxEfsVpxbsnJvkZsG8icY2H7RZcV81fzCRkg9oCnF5msi+CVe
        7RRQfRxTUi9Yjt5vtlZCoW88Y9aiUGL+J9/SfpSHc/tZhMTr/GybJCZLSeRd5ONg
        LsgRvAE3tKWR+6CFKeBVojBwgRq3xBdHLqylg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uk3sfZIRKRuW13BR1oE0bhdyKU5BM2YO
        X6oqd6MT7AFaRiFxCqPD3Ys73NrprLPE3YvDVf8VYpWjNuyFtV3O94KRjfZBFrqT
        9Lpwos32HPMNwS2yeTek7948G7LXdUTXhcT4L5RwXv4NiRSrSXn6m1umAGQf5pgY
        9P1QwhQOANQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CE97BF37F;
        Fri, 22 Dec 2017 16:29:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED93BBF37E;
        Fri, 22 Dec 2017 16:29:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Pat Notz <patnotz@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] commit: add support for --fixup <commit> -m"<extra message>"
References: <CAPig+cRDi14Rez+6ZJAEdxHpo0Mw7JQFkcuG2oVqv2pP_ZbvhQ@mail.gmail.com>
        <20171222204152.4822-1-avarab@gmail.com>
        <xmqqzi6api5a.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 22 Dec 2017 13:29:18 -0800
In-Reply-To: <xmqqzi6api5a.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 22 Dec 2017 13:28:01 -0800")
Message-ID: <xmqqvagypi35.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BBE0E00-E75F-11E7-B777-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...  So "nobody immediately thought of it when it was added" is
> certainly not a reason to later make the combination possible.

Oops, not a reason to later "_not_ to" make an update, of course.

