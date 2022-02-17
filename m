Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FE4C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 22:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiBQWa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 17:30:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiBQWa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 17:30:26 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF831688D2
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 14:30:11 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 117DC187422;
        Thu, 17 Feb 2022 17:30:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mX2WbkGprWJBwHtRJ5jYa84eGikzK+GwiV/3WN
        pjynQ=; b=SHHDROeZhhSyXh3Pbu+5mffURILGpilTwtgx2r0kPYhjEns4/fTnw7
        uVSKcZ/7v3yKbWRGGdu3OsrDjw30TUhBhb7c94bIbYcBRsWO8X9k6wMZUzOi2C9U
        KO4SozxsYHVv8O15wad0eu85iSexfmpbbf4A6oVUdugEQZe5hrwjg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09F53187421;
        Thu, 17 Feb 2022 17:30:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6B275187420;
        Thu, 17 Feb 2022 17:30:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/7] fetch: improve atomicity of `--atomic` flag
References: <cover.1645102965.git.ps@pks.im>
        <CAP8UFD1xiTaOvjT1UYZCUbhEF_ukgZ1cAZgbYiV+Px74RskS5Q@mail.gmail.com>
Date:   Thu, 17 Feb 2022 14:30:07 -0800
In-Reply-To: <CAP8UFD1xiTaOvjT1UYZCUbhEF_ukgZ1cAZgbYiV+Px74RskS5Q@mail.gmail.com>
        (Christian Couder's message of "Thu, 17 Feb 2022 16:50:44 +0100")
Message-ID: <xmqqee416s9c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2976A5A0-9041-11EC-A55F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Feb 17, 2022 at 2:04 PM Patrick Steinhardt <ps@pks.im> wrote:
>
>> This is the second version of my patch series which fixes these
>> problems.
>
> I took another look and found only a very minor improvement in one of
> the tests in patch 1/7.

Yup, the whole series was a pleasant read.

Thanks, both.  Will queue.
