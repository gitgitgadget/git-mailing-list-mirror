Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44B1C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BB06109F
	for <git@archiver.kernel.org>; Thu, 20 May 2021 03:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhETDaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 23:30:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53373 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhETDaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 23:30:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3B0FD1467BB;
        Wed, 19 May 2021 23:28:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rZUNk3vYTkK3jTzb89tZw21w/KU7aKevhZwEEB
        rqfhs=; b=YZM+PaQDbyAh6EGvkacx8XAeuYZ5pMqhp4VXVxqRXYzlZxYZmMJfXs
        8vzhaQmIXh3jgUUr50WNolTk63XdrNQSzmBRfoMdk2IGEAb48pa5HRfB2aThGnsu
        /MKGVSkLaaNOGx2yWnKDJ/TPPEUeyb8ooLKuFSyk+ENq1MMC2V/48=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 339EE1467BA;
        Wed, 19 May 2021 23:28:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7A1A01467B5;
        Wed, 19 May 2021 23:28:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] help: colorize man pages
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
        <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
        <60a332fd22dad_14c8d4208ed@natae.notmuch>
        <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
        <87im3fqci9.fsf@evledraar.gmail.com>
        <YKXBdQ36MYz2YG8s@camp.crustytoothpaste.net>
        <xmqq35uiw3bm.fsf@gitster.g> <60a5d20a4e134_1f37320860@natae.notmuch>
Date:   Thu, 20 May 2021 12:28:42 +0900
In-Reply-To: <60a5d20a4e134_1f37320860@natae.notmuch> (Felipe Contreras's
        message of "Wed, 19 May 2021 22:05:46 -0500")
Message-ID: <xmqqpmxmulqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B152FCE-B91B-11EB-A487-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> How is enabling a configuration already present in `man` out of scope,
> but running an *ENTIRELY* different program--such as konqueror or
> woman--to view man pages is not?
>
>   git help --man git
>
> Doesn't even necessarily run man *already*.

As an end-user, I do not expect Git to run konqueror or woman with
its own tweaks when it does so.  And I do not see a reason why "man"
should be any different.

