Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756F5C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F58C22D71
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 06:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbhAFGGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 01:06:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60050 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAFGGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 01:06:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B874110233;
        Wed,  6 Jan 2021 01:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=x2801B5UYkEUTtumHut4uWD9W
        Ro=; b=uCeojyghmkdKVAoLn9Hq3YZ0J2pRiQSjErAFmtkuhG5BaHZqDiPI1kOaU
        5tB0UqSEdmzEbBHKDpIb4t6+abWwUeTky5LjbGXYj3l+JLngaC2wu9hIHADM2jP2
        Io4Ngj75zkVUO9UgXB5mgdGlyEluT62duLYSmedX4DGpyPcQ80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=IhXpr6hVaBAnJ+yGGuX
        B8L5Ols9XoC2D4/1JzZuGstrYCsfMM5swolAlthCe+ScaR7M7LmnSOvJPN+Q8tft
        YKV2zToW+5v6YPbmYsGKwnXof0mTIRxLH49YGvigFBmCqUk3hmOOCusmUcJ+PO0e
        CY30sFkY27kWtwOBnMvf9/oY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 171DD110232;
        Wed,  6 Jan 2021 01:05:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3B855110231;
        Wed,  6 Jan 2021 01:05:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Gustaf Hendeby <hendeby@isy.liu.se>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
References: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
        <pull.942.v2.git.git.1609695736001.gitgitgadget@gmail.com>
        <CAN0heSpGyHKkiod6TE5jvVc_Y2MTWVY6DLS1Dg4FvS_m71Gs4A@mail.gmail.com>
Date:   Tue, 05 Jan 2021 22:05:23 -0800
Message-ID: <xmqq8s96vbvg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2B023030-4FE5-11EB-AE14-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Hi Philippe,
>
> On Sun, 3 Jan 2021 at 18:42, Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>>     Changes since v1:
>>
>>      * added Martin's suggestions
>
> Yup, this looks good to me.
>
> Martin

Thanks, all.
