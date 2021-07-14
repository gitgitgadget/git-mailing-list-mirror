Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BD0C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F269E613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 16:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhGNQKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 12:10:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54015 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhGNQKh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 12:10:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62542CF86A;
        Wed, 14 Jul 2021 12:07:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Zuv9BV8RRwT0
        a6Sv/HhP5JqH6ZUnw7cghjBkgR/0f8k=; b=ObfhPudJ332CnJcOkDHI6XfUQ/K/
        liD2tVDHl+TFArx3Ndx7Ji7xLQSzVXGTSlXS6wa42ao4Qyr1cE02uKffHI1d6xVy
        uXnzX+q7/kTg3WGeBt6gVQPE03mVRxjGuPo8n0IXVQ0NQHdblqeyOrLRhr0zmfot
        4YPpVac6YC6/NlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A3A7CF869;
        Wed, 14 Jul 2021 12:07:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DA80BCF868;
        Wed, 14 Jul 2021 12:07:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/5] add missing __attribute__((format))
References: <cover-0.6-0000000000-20210713T080411Z-avarab@gmail.com>
        <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
Date:   Wed, 14 Jul 2021 09:07:44 -0700
In-Reply-To: <cover-0.5-0000000000-20210714T001433Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 14 Jul
 2021 02:15:39 +0200")
Message-ID: <xmqqy2a8yj3j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9FFE4690-E4BD-11EB-9029-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Adds missing add missing __attribute__((format)) in various places,
> which improves compile-time checking.
>
> v3: Dropped the 6th patch per feedback from Jeff King. Yes, we can do
> without that strftime() comment in strbuf.c.

OK.  I am OK with or without it, but let's take this version and
merge it down.

Thanks.
