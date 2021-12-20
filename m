Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2B7C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 23:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhLTXGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:06:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63730 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbhLTXGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 18:06:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 87E6D17B178;
        Mon, 20 Dec 2021 18:06:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e2aEjsi1lX6ee3UxP4yKyXYTzMcLRZDbesRhqf
        lDR3M=; b=P8va96YvMOeeJyE8qLDhW2NBz2NKxzGKUB3Ei+xZlDM/WWV/Z4rfVQ
        XM04gz5P+lujTCi5Do7r+H9pPFqAAatgXdHJkXmMMPmQnohVBXx59ogNjERUKPYS
        7frXxuM5he8pqhvTOD27CFJLCioZgrJj9Gu5VF3yG+LTMRIVVOLPk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8055317B177;
        Mon, 20 Dec 2021 18:06:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D819417B175;
        Mon, 20 Dec 2021 18:06:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Erik Cervin Edin <erik@cervined.in>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Sean Allred <allred.sean@gmail.com>,
        git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
        <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
        <CA+JQ7M8oxzUAkw-Nv4X+3bJt7cBhsUaqFKd67Y=LNLnv2kgM+Q@mail.gmail.com>
        <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net>
Date:   Mon, 20 Dec 2021 15:06:28 -0800
In-Reply-To: <YcEJtOknDjSgxK5j@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Mon, 20 Dec 2021 22:54:44 +0000")
Message-ID: <xmqqa6guub9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77EE3C56-61E9-11EC-A2C7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I should point out that in most cases on Unix, it _is_ expected that you
> install your manual pages into the same place as everyone else, so in
> this case, installing the HTML documentation alongside Git's may be the
> best solution.

Yup, that sounds like the most sensible way to do things.
