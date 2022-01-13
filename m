Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F8C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 18:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiAMSyf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 13:54:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57629 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiAMSyf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 13:54:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C07CEFF84A;
        Thu, 13 Jan 2022 13:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JL1xDzMlNhT3
        G/q99YrK7qZKvjO9kiaRYgFslurq+8A=; b=udjp0+8nY3ss8fDWWl89llS2AnJE
        hHvOtS4ax7Va84Mmj4ueCwPDabj7MleMnFh7sy9Gk3pwSZZ7zqE/ntcTwHEva40E
        tmC9qUEygreaEWixXT7wQKpzwDZJDOCq3ShasTBxT1rzMK51KUeGs217W3M4/CXa
        yEA7fqP3VsCX3Wo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B72B9FF849;
        Thu, 13 Jan 2022 13:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2ADCEFF845;
        Thu, 13 Jan 2022 13:54:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 0/3] For v2.35.0: refs: ab/refs-errno-cleanup fixup +
 remove "failure_errno"
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
        <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
        <xmqqo84gu4sb.fsf@gitster.g>
        <220113.86lezjvn2d.gmgdl@evledraar.gmail.com>
Date:   Thu, 13 Jan 2022 10:54:33 -0800
In-Reply-To: <220113.86lezjvn2d.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 13 Jan 2022 13:22:55 +0100")
Message-ID: <xmqq8rvjihzq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F954C5C-74A2-11EC-85B6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So just let me know how you'd like to proceed. I.e. I can re-roll a v2
> with just 1/3, but I think this v1 is also good-to-go as-is. Thanks!

I can just pick up [v1 1/3] and ignore the rest, which would mean
you do not have to send v2, right?
