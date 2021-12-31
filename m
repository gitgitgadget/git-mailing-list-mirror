Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4748C433EF
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 08:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhLaIqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 03:46:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52747 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLaIqr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 03:46:47 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 735F4183D7C;
        Fri, 31 Dec 2021 03:46:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=TqDIi3OSDNn2IIr7uSaIVerI3
        2AnyDdaD0MdpnOySgU=; b=hu/loRCGXew/BE5mEoyAPdf1iuca0JutsFRjcza5c
        /HOzrJ/I9n14JITDP+uULNboRXWuQ/KDmOdUNTLtGxzEAcmHhDtDowS1YrkRzQF0
        6jXV6aaWPZxWml+Yovmi27hxiUhmRsUSnseRdg8dnnm45LiYqqnhuAJ34dOenYA/
        OI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AF92183D7B;
        Fri, 31 Dec 2021 03:46:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9C02183D7A;
        Fri, 31 Dec 2021 03:46:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Subject: Re: [PATCH v3 0/9] Add a new --remerge-diff capability to show & log
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
        <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
Date:   Fri, 31 Dec 2021 00:46:42 -0800
Message-ID: <xmqq35m9maa5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E315DF2-6A16-11EC-947F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v2 (of the restarted submission):
>
>  * Numerous small improvements suggested by Johannes Altmanninger
>  * Avoid including conflict messages from inner merges (due to example
>    pointed out by =C3=86var).
>  * Added a "remerge" prefix to all the new diff headers (suggested by J=
unio
>    in a previous round, but I couldn't come up with a good name before.=
 It
>    suddenly hit me that "remerge" is an obvious prefix to use, and even
>    helps explain what the rest of the line is for.)

That sounds sensible.

