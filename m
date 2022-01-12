Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF42CC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 19:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbiALTfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 14:35:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63853 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiALTec (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 14:34:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C649159DA2;
        Wed, 12 Jan 2022 14:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XQWfGv/lMhBW
        xA14o85Pyp+zghWPcvzPmxuC/rrsnqQ=; b=yZxBq5w3eMlVi0RISVyqFbcmzwrq
        UTsmHWCwa7uTS4sawVYNnRpWnVPCaUIuKXlanP+W1wPo/xz7BWfkoNwnVm8tvHs+
        IYnCH2uXUrG/fzh7HjK3TYqURf6RkVLhOWvN08Kbjxg3fIHmnKlBynyHVb0dHa4E
        QJO6b7d/+jzNc7U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64EDF159DA1;
        Wed, 12 Jan 2022 14:34:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CCE8D159D9E;
        Wed, 12 Jan 2022 14:34:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 0/3] For v2.35.0: refs: ab/refs-errno-cleanup fixup +
 remove "failure_errno"
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
        <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
Date:   Wed, 12 Jan 2022 11:34:28 -0800
In-Reply-To: <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 12 Jan
 2022 13:36:45
        +0100")
Message-ID: <xmqqo84gu4sb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A918A6D4-73DE-11EC-9E20-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a follow-up to the recently landed ab/refs-errno-cleanup
> topic, I missed a spot and left some meaningless use of "errno" in the
> refs (file) backend.

Is it a fix "oops the ones we merged to 'master' were buggy and
needs these on top to be correct"?

If it is merely a follow-up "I am doing more of the same thing as we
aimed to do in that topic", I'd rather leave it to the next cycle.

I'll come back to the topic to find it out from the patches
themselves, but after I dealt with other patches that are more
clearly fix-ups first.

Thanks.
