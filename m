Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CEEC433E0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EB2D64E68
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 22:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCNWt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 18:49:58 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50606 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCNWtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 18:49:55 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2388711BD49;
        Sun, 14 Mar 2021 18:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w6HxYLVfhyZz1TL/laktwp3Vh7Q=; b=q9Ivjh
        WgFtGdfE9+uIu6e3DiXukk4eclZA/nyu0ZoAvYv3TYZd5uOTwfha8ndBwKykwdx1
        IeaZEJgV29jIjeZMcc1HxxA3K/wlCm/xhLVXM3aI0emSZVHNm7k1pXWfmTmFVmJt
        sSFSiE0Vg0EsR5QsPMeKG4LxghB60xNTKyApw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Dc0mSIe5ohpbHo+DsFeAQrXeTtdRmdcR
        yM2UEjYyZPu7KYpSDKdjVxwHzpHDbvrHl2BkudALLSe4nFYxSjVlTYbxR5X9+doe
        w9700r7DzCh7porhjtHCxefbV3VkBkG5b737JG+9ewEfDRTrKP5WTSM0eV64P3oI
        UVW9Qlea4H4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B44411BD48;
        Sun, 14 Mar 2021 18:49:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E19611BD47;
        Sun, 14 Mar 2021 18:49:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Emir =?utf-8?Q?Sar=C4=B1?= <bitigchi@me.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.31.0 round 2
References: <20210314162021.28282-1-worldhello.net@gmail.com>
Date:   Sun, 14 Mar 2021 15:49:50 -0700
In-Reply-To: <20210314162021.28282-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 14 Mar 2021 12:20:21 -0400")
Message-ID: <xmqqy2ep2vw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B3B788-8517-11EB-A35B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following l10n updates for Git 2.31.0.
>
> The following changes since commit f01623b2c9d14207e497b21ebc6b3ec4afaf4b46:
>
>   Git 2.31-rc1 (2021-03-02 22:41:13 -0800)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.31.0-rnd2
>
> for you to fetch changes up to 473eb54151ef8756fd2cfa1ef37d8b941a081049:
>
>   l10n: zh_CN: for git v2.31.0 l10n round 1 and 2 (2021-03-15 00:05:25 +0800)

Thanks, will do.

