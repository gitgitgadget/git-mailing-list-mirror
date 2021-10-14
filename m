Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA03C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8B861053
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 17:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJNRLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 13:11:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59962 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNRLp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 13:11:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D055415C99B;
        Thu, 14 Oct 2021 13:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iWaw76i4tZfy
        yf4Ei5oTLsJmbmqFbb+q88k0lpQGBZg=; b=cd8NjzAbM+U7762R2SP3lpAg8p2d
        DpQ8Py7W+mgo3EtybVQBbn+sERnj38HSdELd+mHsFCQVXi91WV9n8wxehfOHm5kF
        GMvbjj939zlz8ybMT5reW3T/yjcCxkHXc/IhhTjkInQDk+M4dYvVooMV+QUFJIz/
        ZKsjvLiFBFcehRA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BAE9F15C999;
        Thu, 14 Oct 2021 13:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 189B215C998;
        Thu, 14 Oct 2021 13:09:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Oct 2021, #03; Mon, 11)
References: <xmqqv9239k15.fsf@gitster.g> <xmqqwnmgeenz.fsf@gitster.g>
        <878ryvhacw.fsf@evledraar.gmail.com>
Date:   Thu, 14 Oct 2021 10:09:35 -0700
In-Reply-To: <878ryvhacw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 14 Oct 2021 17:50:51 +0200")
Message-ID: <xmqqczo7cz3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82A49AA8-2D11-11EC-9911-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Any actual breakage with it is likely due to some unexpected 3rd party
> workflow needing this deprecated mode still, which surely we're better
> of finding out sooner than later pre-release (if such users even test
> pre-releases...).

Yes, exactly.  Unless we are postponing to later development cycles,
it is better to expose more early adopters sooner.

Thanks.
