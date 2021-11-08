Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC2CC433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 21:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75597611C0
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 21:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbhKHV1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:27:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58020 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbhKHV1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 16:27:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB9451696CD;
        Mon,  8 Nov 2021 16:24:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=06A+3GPxbeZw5etFo0R3sQl8cCE7kv64IY0Bsw
        3+hx0=; b=BL7uUYVLHapgUStw8famrygpF+hQ5d6COCfjwSPAKMLcZScS8kCl8l
        7nMQtxEYCaXlmITHA5G5RTvqUyzLds/tLrUUPUVJqDvXJglIism/Y7GyoJDBUovL
        FU1h6/GersPsI6S35Z94DAh/NY+/BDZ4GJGpcZj0kpSzMDXyCZUUo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BC3601696CC;
        Mon,  8 Nov 2021 16:24:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29D581696CB;
        Mon,  8 Nov 2021 16:24:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/3] gitfaq: add documentation on proxies
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
        <20211107225525.431138-2-sandals@crustytoothpaste.net>
        <CAPig+cT5bU3K9aUk=Y6YAOJjAmDvOWitYD_jtgHap_BYs2mPgA@mail.gmail.com>
        <YYiDGhkaaQq7gpLK@camp.crustytoothpaste.net>
Date:   Mon, 08 Nov 2021 13:24:45 -0800
In-Reply-To: <YYiDGhkaaQq7gpLK@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 8 Nov 2021 01:53:30 +0000")
Message-ID: <xmqqbl2utk6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4C7B94FE-40DA-11EC-B651-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I realize this sounds redundant, but I'm trying to avoid the situation
> where people say, "I'm not _tampering_ with it, since I'm authorized to
> do this by the company.  I'm just modifying it to remove this
> inappropriate content/malware/data leak."

It might be a good strategy to educate users by leaving a deliberate
hole to let them quibble with such an excuse.  When it comes to
on-the-wire protocol, their management do not have authority to
grant them right to tamper with the data and that is not limited to
Git.


