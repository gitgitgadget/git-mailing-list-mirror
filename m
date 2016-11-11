Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7D42035F
	for <e@80x24.org>; Fri, 11 Nov 2016 17:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756785AbcKKRlU (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 12:41:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58119 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753047AbcKKRlT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 12:41:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F1794D554;
        Fri, 11 Nov 2016 12:41:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pWGcKxFDylow0lVCQhyZjjiUwJE=; b=Rw0zT8
        ojD4j/6L9f1IyQQ36ZYWjZteYIP/h3zJQ4w0joNkgpW7RkKbv6b4TPlmVRCWGisj
        XqRqAE/d7pwA/Q1WfhdywTgp6U2aEQdXXJBrYYGd8IhENo3vQK36vCIeDNwSHVet
        x6jUzRkPyZIztEm1CxC9MaCliQVuXjn3qFcDI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AhgNmftJm00oVfxfuJrpjouZNxiVy1TP
        A6yWcygweaIJxQlgKnwJxAUBKDvDGXu6P4fuvI4fCwhkbLLXM7/DI+kNSew3N9wd
        ffEkH9b1uwuosZM3okP9FMVWJCGWR5lKMUyTNRbsN7R8IMl0Bf5HjVUHU7pjz1wT
        GDeSSnr8e58=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 341584D553;
        Fri, 11 Nov 2016 12:41:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A71134D552;
        Fri, 11 Nov 2016 12:41:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
        <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611111711210.3746@virtualbox>
        <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
Date:   Fri, 11 Nov 2016 09:41:16 -0800
In-Reply-To: <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com> (Lars
        Schneider's message of "Fri, 11 Nov 2016 18:05:00 +0100")
Message-ID: <xmqqeg2h3oeb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CC00CE2-A836-11E6-A30E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Part of the reason is that Hannes' squash got lost:
> http://public-inbox.org/git/d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org/
>
> @Junio: Can you apply this (see discussion with Peff linked to email above).

Thanks for a quick and usable report followed by a quick fix.
