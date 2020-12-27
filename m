Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E8C433E0
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 23:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945CE221F5
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 23:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgL0XOU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 18:14:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56024 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgL0XOT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 18:14:19 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52F0A98294;
        Sun, 27 Dec 2020 18:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MK7QwscQF8djR9WGlzbm19xe7ag=; b=NaExVW
        +JdBIjx/AmguYfPp5FVL+GUlnD43TxAjleYv8jBxKMY+1FkPQg85jq1wBSGdlo82
        J1KXB/m+vRV+H7G8FVSrwJPDO02rX5aMakYr48iP5KPzhcke75V36uNOWnag5hu1
        nMoe7wkS77Jv1o1kWHGbXfujD/2qzsoGvSIuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NUrqh5Tc6380Ah8AX0PyCsSgsGoVaxbW
        HSM5ezJWz4yX6vGqaIcvFYWbPnziYAhP2x4L+pPGuv0YFhXcOtMK5Ip1rHDfufAH
        arfK+nMmu+Cj+56M1l3vmZ+vb0BgSSewXh22FYkD2ZQBqqAzlB7H/CdqSRBzAFnj
        VC4ilEJAWws=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47AF098293;
        Sun, 27 Dec 2020 18:13:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B566A98291;
        Sun, 27 Dec 2020 18:13:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>,
        Baptiste Fontaine <b@ptistefontaine.fr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir =?utf-8?Q?Sar=C4=B1?= <bitigchi@me.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>, m4sk1n <m4sk1n@o2.pl>
Subject: Re: [GIT PULL] l10n updates for 2.30.0 round 2
References: <20201227144257.26283-1-worldhello.net@gmail.com>
Date:   Sun, 27 Dec 2020 15:13:35 -0800
In-Reply-To: <20201227144257.26283-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 27 Dec 2020 09:42:57 -0500")
Message-ID: <xmqqv9cmn8ps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25E1415C-4899-11EB-BE65-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.30.0.
>
> The following changes since commit 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707:
>
>   Git 2.30-rc1 (2020-12-18 15:15:18 -0800)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.30.0-rnd2
>
> for you to fetch changes up to d13389bf27f1618525ab4c29c53aca1334fdfa74:
>
>   l10n: zh_CN: for git v2.30.0 l10n round 1 and 2 (2020-12-27 19:23:27 +0800)

Thanks.
