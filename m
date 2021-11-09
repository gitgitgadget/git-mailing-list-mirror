Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC9C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A56D60232
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 18:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242350AbhKISWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 13:22:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52383 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242366AbhKISWi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 13:22:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 810DBF71EB;
        Tue,  9 Nov 2021 13:19:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+H06+4XtML/LAa0FrWFFBD1DKEOacSraTuQ6TE
        I9aVE=; b=C4o822hXHlHNaiQn3QUmYD/hCm1yRy8iOHMDlA6QXMBcyvruuQ/RcI
        gwjgKKlNd9tL9mTU70ySdRzF9c9FnRT3reuiKdTUCujxY0mTQ3stacCumUbL6Ar7
        9brt3Uh6+r9Vr772CQXEL7h8/zBxQnwm5BVIe4AK4wJix8ZvlsClo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76DBAF71EA;
        Tue,  9 Nov 2021 13:19:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC98FF71E9;
        Tue,  9 Nov 2021 13:19:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kerry, Richard" <richard.kerry@atos.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: Re: [PATCH v2] t/lib-git.sh: fix ACL-related permissions failure
References: <20211104192533.2520-1-adam@dinwoodie.org>
        <20211105193106.3195-1-adam@dinwoodie.org>
        <xmqqk0hmwc0c.fsf@gitster.g>
        <AS8PR02MB730266C2B87493F2AF712D989C919@AS8PR02MB7302.eurprd02.prod.outlook.com>
        <xmqqbl2uv4ri.fsf@gitster.g>
        <AS8PR02MB73028E498D0AB831FE8028E89C929@AS8PR02MB7302.eurprd02.prod.outlook.com>
Date:   Tue, 09 Nov 2021 10:19:49 -0800
In-Reply-To: <AS8PR02MB73028E498D0AB831FE8028E89C929@AS8PR02MB7302.eurprd02.prod.outlook.com>
        (Richard Kerry's message of "Tue, 9 Nov 2021 17:23:12 +0000")
Message-ID: <xmqqk0hh2nui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A1016CC4-4189-11EC-8F74-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kerry, Richard" <richard.kerry@atos.net> writes:

> "to avoid this from happening" is wrong.
> "to avoid this happening" is right.

Ah, of course.  I somehow mixed it up with "to prevent".

