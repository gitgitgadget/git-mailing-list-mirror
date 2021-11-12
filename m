Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74ACC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB3960F42
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 17:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhKLRS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 12:18:58 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58134 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhKLRS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 12:18:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD31316B73F;
        Fri, 12 Nov 2021 12:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OX3PnyDiXNNU
        qbCwUy1QY82dA9boA55aQc+MIJUgcj4=; b=AJd52/fYWP2RniK26ihdcFe25+i1
        uD4XE9qj4ik3vTG6Q1bhKdYAA89K3BVml1+Cs7kDSf2aCirB6OOLFsjEONg3fP+A
        VbY8p/KNuZxkOBbTS8XimrPZ7NwIL//yiQfHwTED9cYLp62MsVKFYpAmhOMDirm2
        6c9kt2sjZmjsZ3E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5CF416B73E;
        Fri, 12 Nov 2021 12:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 23F1116B73C;
        Fri, 12 Nov 2021 12:16:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 4/8] grep docs: de-duplicate configuration sections
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
        <patch-v2-4.8-efe95397d72-20211110T013632Z-avarab@gmail.com>
Date:   Fri, 12 Nov 2021 09:15:59 -0800
In-Reply-To: <patch-v2-4.8-efe95397d72-20211110T013632Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 10 Nov
 2021 02:43:46
        +0100")
Message-ID: <xmqqo86ps3ao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3587D064-43DC-11EC-9F1E-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Include the "config/grep.txt" file in "git-grep.txt", instead of
> repeating an almost identical description of the "grep" configuration
> variables in two places. In a subsequent commit we'll amend this
> documentation, and can now do so in one place instead of two.

Good find.  They are indeed almost identical.  I am not sure about
the value of ...

> +The below documentation is the same as what's found in
> +linkgit:git-config[1]:

... when everybody becomes consistent, but in the meantime, while
some documentation pages are consistent while others are not, I can
see how it might help.

The patch looks good.

Thanks.
