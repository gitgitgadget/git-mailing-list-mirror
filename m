Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D7C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbhLGUpb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:45:31 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59736 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbhLGUpb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:45:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1957CE1F8B;
        Tue,  7 Dec 2021 15:42:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DE56iLBiaGnm
        eXdbVkgmxR6pqMerU7TwL/TfqRJfcA8=; b=L8GPsARyDnYUPJ6wD/eMQRQYDazQ
        EXdcal1Eeg2oblgyhAAxH9OZWiXmwNh7s7l+T1pgPkl72RG1Oosycc3/KJ5NsXcy
        dfNEjpXr+9nnKFDnuE8CCxgkrdPwdDeL811jFXEM9Ffyqn0eDtIbpBeFnVv67Hjo
        qyID8TC92GZPRRE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F379E1F8A;
        Tue,  7 Dec 2021 15:42:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 66FBFE1F89;
        Tue,  7 Dec 2021 15:41:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Clemens Fruhwirth <clemens@endorphin.org>
Subject: Re: cf/fetch-set-upstream-while-detached
References: <xmqqh7bpqhf0.fsf@gitster.g>
        <211207.86pmq8mbtu.gmgdl@evledraar.gmail.com>
Date:   Tue, 07 Dec 2021 12:41:58 -0800
In-Reply-To: <211207.86pmq8mbtu.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 07 Dec 2021 20:37:47 +0100")
Message-ID: <xmqqy24w5eqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1FF76298-579E-11EC-AF55-C48D900A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So i'd think that any proposed behavior change there should come
> independent of a narrow segfault fix, let's fix that, and then change
> how "fetch --set-upstream-to" works in general.

Sound good.  I won't have time to go hunting for old patch from the
archive today, though.

THanks.
