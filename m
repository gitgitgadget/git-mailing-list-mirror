Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB8CC4332F
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0407261152
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346580AbhIGU1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:27:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54373 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346468AbhIGU1t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:27:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7737E1447B1;
        Tue,  7 Sep 2021 16:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E3br9K7AaekT
        jErdsvegVCFHyiIBWlPNCgS2y/9EIng=; b=YePoMnNqQgDQRbXP8xYyq9FHPjsb
        5CuP8TlU5qr09A1+HRctJ5P2E+OBeStrDwj6vntsQUs7Yzxo91PgSwC1XC+Ef4X4
        Y9VIgEr2ogVZNniP24VZ/zVhggXiAKSXmWv9EZjOqOjUYhlDDbYde2FMyunWBauR
        pPwWx9Kw7MC6QSE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6FD611447B0;
        Tue,  7 Sep 2021 16:26:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7AA01447A8;
        Tue,  7 Sep 2021 16:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-tool run-command: remove dead "testsuite" code
References: <patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com>
Date:   Tue, 07 Sep 2021 13:26:38 -0700
In-Reply-To: <patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 6 Sep
 2021 02:37:37 +0200")
Message-ID: <xmqqtuiw9loh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E8353E0A-1019-11EC-9B31-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Remove the "test-tool run-command testsuite" sub-sub-command, it has
> not been used since 4c2c38e800f (ci: modification of main.yml to use
> cmake for vs-build job, 2020-06-26), see also the earlier
> 6081d3898fe (ci: retire the Azure Pipelines definition, 2020-04-11)
> for another phasing out of the command.

I'll leave this patch hanging in the list archive until I hear from
somebody from Azure camp say that they do not need it anymore and
they do not plan to use it in the future.  Of course, if somebody
else from outside the Windows circle is using it or plans to use it
in a near future, they can raise their voice heard while we are
waiting for such an Ack.

Thanks.
