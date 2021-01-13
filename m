Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB43C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 09:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840852339F
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 09:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbhAMJF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:05:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56488 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbhAMJFz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 04:05:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F2D0A1FC8;
        Wed, 13 Jan 2021 04:05:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fSLBZ1DZG12y
        fIpE95eR6Kn/D8c=; b=JdpkznTb932UjqnAxeMw9CqL5VRsYhsuX1sABi0rqtFf
        9tsuot9kdLTaK41gX9OnFwnsR/K3sfXYLcXLLJFX1NCTrlbsVJ6ogMXr+gPqVFdj
        +P/Xh5GoyvcipRxvOjMCD9pE9/VtUL8lU4tjuyoYBLQ/4+PFeM7TQGbsblRwV3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jqOGeB
        sSO+cCG9qiMIAli7RVjNAd55N9/rHti79WyDRigZKNdIsb0YxltAbk0i2RpbwZMu
        SRT/erUM4KODdZoFDnFLJdEFp5vdZeo5eXxZeSmZQYLUFF5KcdES7XbC56YOTiVm
        bhDo2snqJp57DkdqD75B+UH7iSg1sEEUoY4WM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17FF9A1FC7;
        Wed, 13 Jan 2021 04:05:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CB02A1FC6;
        Wed, 13 Jan 2021 04:05:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] CoC: update to version 2.0 + local changes
References: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com>
Date:   Wed, 13 Jan 2021 01:05:09 -0800
In-Reply-To: <xmqqzh1dxmlo.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 13 Jan 2021 00:33:23 -0800")
Message-ID: <xmqqr1mpxl4q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7075A55E-557E-11EB-949B-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Here is to remind those of you who may want to add your Acked-by to
> =C3=86var's proposed update to show your support.  I've collected ones =
on
> the list I saw in replies to the original proposal [*1*] but in case
> I missed yours...
>
> Thanks.
> ...
> [Reference]
>
> *1* Message-Id: <20201228171734.30038-3-avarab@gmail.com>
>
> ----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -----
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Subject: [PATCH] CoC: update to version 2.0 + local changes
>
> Update the CoC added in 5cdf2301 (add a Code of Conduct document,
> 2019-09-24 from version 1.4 to version 2.0. This is the version found
> at [1] with the following minor changes:
>
>  - We preserve the change to the CoC in 3f9ef874a73 (CODE_OF_CONDUCT:
>    mention individual project-leader emails, 2019-09-26)
>
>  - We preserve the custom intro added in 5cdf2301d4a (add a Code of
>    Conduct document, 2019-09-24)
>
> This change intentionally preserves a warning emitted on "git diff
> --check". It's better to make it easily diff-able with upstream than
> to fix whitespace changes in our version while we're at it.
>
> 1. https://www.contributor-covenant.org/version/2/0/code_of_conduct/cod=
e_of_conduct.md
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> Acked-by: Christian Couder <chriscool@tuxfamily.org>
> Acked-by: Derrick Stolee <dstolee@microsoft.com>
> Acked-by: Elijah Newren <newren@gmail.com>
> Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>
> Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

I guess I should lead by an example ;-)  The above misses mine and
Signed-off-by means a totally different thing [*1*] from Acked-by.

    Acked-by: Junio C Hamano <gitster@pobox.com>


[Footnote]

*1* Most importantly, signing off is about recording provenance of
    the change. You certify that you have enough rights to pass the
    patch along to the project, and you agree that the fact that you
    contributed the patch will be recorded in perpetuity.  It does
    not mean that you agree to the change in the patch and you do
    not assure correctness of the patch by signing it off.  I signed
    off the above patch to say I got it from =C3=86var and committing it
    as-is, but it does not say that I agree with the move of our CoC
    to Contributor Covenant 2.0, hence my Ack here.


