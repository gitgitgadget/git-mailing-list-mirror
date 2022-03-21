Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5161C433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352455AbiCUTLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351807AbiCUTLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:11:43 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E5C5BD37
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:10:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08DA0178DCF;
        Mon, 21 Mar 2022 15:10:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JzT5y6oU+FyD
        w0eHJ276HT6YRIEQtLM9XEiU9417D9Y=; b=Qn84Nodb1JgYS/Z4+mMdzcPjk26G
        srlRUWmXHhJVecTsPvmmBQMQj0nuQaxF5wW4EZET67suZpZ5L7qKw8Cg/5qZO4tH
        sexiphEIMYrVuYHM5P0K1eGuRcZ9W32EKocMYnSGVugExZAdaCW1GLaKc2Vo1r1O
        Hy3JN7CIEsvyO08=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9292C178DCE;
        Mon, 21 Mar 2022 15:10:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EEAD7178DCD;
        Mon, 21 Mar 2022 15:10:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: designated init & missing debug in
 ps/fetch-mirror-optim
References: <cover-0.5-00000000000-20220317T171618Z-avarab@gmail.com>
        <CAFQ2z_M7-D4ZCJbj8JituTbR3d7ocRHd=ObdZUnmE=WD7qW0cg@mail.gmail.com>
        <YjhdOUEG1RbWDApX@ncase>
Date:   Mon, 21 Mar 2022 12:10:12 -0700
In-Reply-To: <YjhdOUEG1RbWDApX@ncase> (Patrick Steinhardt's message of "Mon,
        21 Mar 2022 12:10:49 +0100")
Message-ID: <xmqqczifxgtn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 896CBD7E-A94A-11EC-9DA7-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Mar 17, 2022 at 06:45:13PM +0100, Han-Wen Nienhuys wrote:
>> On Thu, Mar 17, 2022 at 6:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>> > Aside: It seems that the GIT_TRACE_REFS facility has been broken sin=
ce
>> > it was added, i.e. running the test site with e.g.:
>> >
>> >     GIT_TRACE_REFS=3D/tmp/log.txt make test
>>=20
>> I wasn't aware that this is even possible. I've only used it with
>> GIT_TRACE_REFS=3D1
>>=20
>> I looked over your patches and they LGTM.
>
> Seconded, the patches look good to me.

Thanks, all.  The topic will be in 'master' hopefully by the end of
the week (I'll be offline part of today, mostly tomorrow and also
Friday, so things may slow, though).

