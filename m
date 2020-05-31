Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A765C433E0
	for <git@archiver.kernel.org>; Sun, 31 May 2020 18:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E99A206E2
	for <git@archiver.kernel.org>; Sun, 31 May 2020 18:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PbU93K31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEaSPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 14:15:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52225 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaSPt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 14:15:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2C3ED2E62;
        Sun, 31 May 2020 14:15:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R+38zBMLar4st6gNenCHF1bnm3Y=; b=PbU93K
        31uksWvcXnC3Zzol0gfEkXUegIf4hS5pc1vnXJGmG6XRVm/QSEx2f4zANZmx/Y+F
        ka0Hfnb3ApNYz4A6BJK5jfuKoJD7cihFQqWl97m+5T0mUNxfFx12e9onlplE1ZZs
        1JrfLC/T5GNlRJysxN1lAS+GyJzmSooeRrrrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ha5wRuRvA9PSUCB2k0f/lKrpO9D4jT2V
        FXKwC+3IonRfBvPaUZIfTm2Wnm21AxNG8idMvhobbX5IGNxd2gvFj4NxENYu5h9W
        GB2AxeQBEoNfDZ9vvI/SET+tolmGQj9YtcCwsaTH80MgfVhzIsFJXmMMhH2GOeNt
        jnJNybgxfLs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB963D2E61;
        Sun, 31 May 2020 14:15:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 22DCAD2E60;
        Sun, 31 May 2020 14:15:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Christopher Diaz Riveros <christopher.diaz.riv@gmail.com>,
        Emir =?utf-8?Q?Sar=C4=B1?= <bitigchi@me.com>,
        Jan Engelhardt <jengelh@inai.de>,
        =?utf-8?Q?Jean-No?= =?utf-8?Q?=C3=ABl?= Avila 
        <jn.avila@free.fr>, Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Tran Ngoc Quan <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.27.0 round 2
References: <20200531051726.9793-1-worldhello.net@gmail.com>
Date:   Sun, 31 May 2020 11:15:43 -0700
In-Reply-To: <20200531051726.9793-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 31 May 2020 01:17:26 -0400")
Message-ID: <xmqqy2p8ug1c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BED39A24-A36A-11EA-8C0A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.27.0.
>
> The following changes since commit 2d5e9f31ac46017895ce6a183467037d29ceb9d3:
>
>   Git 2.27-rc2 (2020-05-26 09:38:13 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.27.0-rnd2
>
> for you to fetch changes up to cb26198ec6b3fa0bc58d210ea0338f4e972f9f50:
>
>   Merge branch 'master' of github.com:ruester/git-po-de (2020-05-30 11:26:53 +0800)

Thanks.  Swapped GPG key recently?
