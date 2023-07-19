Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A0C001DE
	for <git@archiver.kernel.org>; Wed, 19 Jul 2023 21:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGSVV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jul 2023 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSVVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jul 2023 17:21:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6767A1FC1
        for <git@vger.kernel.org>; Wed, 19 Jul 2023 14:21:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D9FF431864;
        Wed, 19 Jul 2023 17:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=024r8QxvygGU
        oS+VeKF69u3OJa+fn9ah5P1sfwg32TE=; b=b9NnJfAW3PfkLA51dZIFu9xYd46C
        CCgHtSulZSqg5KHHPOSnKI4DtYAzC1YpYshCPhIzL0KyhGVo0eTBhQylPcv1czx1
        vrzmIG7xM0HqSGlEJXbYwQ2QQSvfWgvn4PIZ1gi2fsmeCxgFYtnYZ8D/fEvdsfkF
        1fz121vtDW2rfQk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2D1C31863;
        Wed, 19 Jul 2023 17:21:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E0A2D3185E;
        Wed, 19 Jul 2023 17:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: Re: [PATCH] blame: allow --contents to work with bare repo
References: <CAG1j3zFps5yKwu=DEgkfmZDrzVoRkdeRFMFbq16ZmyOaTXxWeQ@mail.gmail.com>
Date:   Wed, 19 Jul 2023 14:21:18 -0700
In-Reply-To: <CAG1j3zFps5yKwu=DEgkfmZDrzVoRkdeRFMFbq16ZmyOaTXxWeQ@mail.gmail.com>
        (=?utf-8?B?IumfqeS7sCIncw==?= message of "Wed, 19 Jul 2023 03:48:34 -0700")
Message-ID: <xmqqjzuva981.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 343D2DEE-267A-11EE-ABDA-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E9=9F=A9=E4=BB=B0 <hanyang.tony@bytedance.com> writes:

> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 setup_work_tre=
e();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 if (!sb->conte=
nts_from) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0 setup_work_tree();
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 }

Unwanted {braces} around a single statement.

The patch is severely whitespace damaged and does not apply.

Please check your outgoing mail route and make sure it does not
happen when you send out an updated patch.  Sending an e-mail to
yourself and checking what you received may also work as a way to
sanity-check without bombarding other people and the list with a
test message.

Thanks.

