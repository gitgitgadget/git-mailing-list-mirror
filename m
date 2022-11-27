Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE44C4332F
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 04:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiK0Eeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Nov 2022 23:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiK0Eeo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2022 23:34:44 -0500
X-Greylist: delayed 251 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Nov 2022 20:34:43 PST
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC9DEF2
        for <git@vger.kernel.org>; Sat, 26 Nov 2022 20:34:43 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED30A16AD32;
        Sat, 26 Nov 2022 23:30:29 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=aQwg9YeID60SC
        9rBeRu11CUvvIKRlqE6Aaffgsc2X8E=; b=C1bXWwW07v1r5pdmvYBXOb0y4BevD
        wWaLY/WArY1o78b3Jfpj0mNeG4KMa8KzlCSjQ4VZ3jjg18ECB1b9bMHkeqTXwNSE
        KXQyTNclAZaqiTGP1CeWLwX2fwtFKfkBcDYa4Byk/w5tKvAai/crXlgTccKn3XJf
        8dssdcOtb8urGQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E386516AD30;
        Sat, 26 Nov 2022 23:30:29 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6187016AD2F;
        Sat, 26 Nov 2022 23:30:29 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Sat, 26 Nov 2022 23:30:27 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Fangyi Zhou <me@fangyi.io>,
        =?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] i18n: fix command template placeholder format
Message-ID: <Y4Ln43f6iP1b6EHo@pobox.com>
References: <pull.1435.git.1669483442230.gitgitgadget@gmail.com>
 <xmqqr0xp9of5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xmqqr0xp9of5.fsf@gitster.g>
X-Pobox-Relay-ID: 39141674-6E0C-11ED-BEC5-2AEEC5D8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Jean-No=EBl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:
>=20
>>     i18n: fix command template placeholder format
>>    =20
>>     This patch applies to the revision 2.39 rc0 during the l10n proces=
s.
>=20
> Thanks, will queue.

In case its helpful, an identical patch was sent on
Wednesday, Subject: [PATCH] revert: add angle bracket around
argument 'parent-number' in usage.

    <pull.1386.git.git.1669241489179.gitgitgadget@gmail.com>

Its commit message notes:

    8c9e292dc0 (doc txt & -h consistency: add missing
    options and labels, 2022-10-13) adds detailed usage line
    for revert and cherry-pick, which both contain a flag
    `-m` for parent number.

    Angle brackets shall be marked around parent-number,
    since it represents
    an argument.

--=20
Todd
