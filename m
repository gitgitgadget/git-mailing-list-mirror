Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE94C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 18:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A846112D
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 18:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhJFSWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:22:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61767 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhJFSWt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 14:22:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 746CC15AEE2;
        Wed,  6 Oct 2021 14:20:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vbsuJMHaWqNc
        NqoKNSbsPqwAQEoUH851RX3oT0hR6GY=; b=apzsiUEdAZF6ItZ+ajrRFBXLi6+p
        5AyURtUbG4yo/cWYnXyzXuG6J63F4eAIXo3JayPfIeenbC9VAdIDsnse/l4D8o5J
        UTV2t38NyFKiCJ0mw15d6VTAcU8RfrWm+kKR6bEcK0PfjLhb2KOq+9j7u/SXgwc+
        qdTwh3DYWptokAA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CE7D15AEE1;
        Wed,  6 Oct 2021 14:20:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF81A15AEE0;
        Wed,  6 Oct 2021 14:20:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 0/7] Gets rid of "if reflog exists, append to it
 regardless of config settings"
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
        <CAFQ2z_PAs3fG1h31KWVXJ=02t1i9UvWPuD4tCK-ZWfewkPQJEw@mail.gmail.com>
Date:   Wed, 06 Oct 2021 11:20:53 -0700
In-Reply-To: <CAFQ2z_PAs3fG1h31KWVXJ=02t1i9UvWPuD4tCK-ZWfewkPQJEw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 5 Oct 2021 17:54:14 +0200")
Message-ID: <xmqqk0iqrp4q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 25137912-26D2-11EC-A72D-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> I had the impression that I addressed all outstanding comments (but
> not sure). Are you waiting for me to do something before this can go
> into 'seen' ?
>
> There is a merge conflict against master, so I'll send a v4 shortly.

Sorry.  I seem to have looked at and commented on the precursor RFC
of this topic, but nobody other than =C3=86var seems to have commented on
the second iteration and the topic was completely under my radar,
and I do not remember what it was about.

It would be good to have an update for others to see.

Thanks.


