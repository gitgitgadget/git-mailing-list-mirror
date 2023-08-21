Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE19BEE4996
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 15:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjHUPob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHUPoa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 11:44:30 -0400
Received: from pb-sasl-trial2.pobox.com (pb-sasl-trial2.pobox.com [64.147.108.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3998DB
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 08:44:28 -0700 (PDT)
Received: from pb-sasl-trial2.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id CFE73290D5;
        Mon, 21 Aug 2023 11:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HXMQ1O1LYM9JOv7rnSxxzVKPSDPyNMCuxfJkYU
        kXvxk=; b=OGNNucmYgd19O9JErIMrDJ6O0YbNLPch7cPCfUWlxCTxolOV+OtW98
        SbJa+dnfieEUoxewVbglGS+m5ZssNVn13qkRKONGVbnuf1vDeky2xTygyZmSUc/B
        fEckMGxzul91xjPvet5c47yvIxeZ5El3t4Wn7MuHgBbvnHjFWZwBI=
Received: from pb-smtp2.nyi.icgroup.com (pb-smtp2.pobox.com [10.90.30.54])
        by pb-sasl-trial2.pobox.com (Postfix) with ESMTP id B5FA4290D2;
        Mon, 21 Aug 2023 11:44:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F19751B9846;
        Mon, 21 Aug 2023 11:44:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arkadii Yakovets <ark@cho.red>, Arusekk <arek_koz@o2.pl>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.42.0 round 2
References: <20230820232538.9751-1-worldhello.net@gmail.com>
Date:   Mon, 21 Aug 2023 08:44:23 -0700
In-Reply-To: <20230820232538.9751-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 21 Aug 2023 07:25:37 +0800")
Message-ID: <xmqqpm3gs8mg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9ADF0CE2-4039-11EE-8F38-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following l10n updates for Git 2.42.0.
>
> The following changes since commit f1ed9d7dc0e49dc1a044941d821c9d2342313c26:
>
>   Git 2.42-rc2 (2023-08-15 10:20:02 -0700)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.42.0-rnd2
>
> for you to fetch changes up to d1f87c2148b025a9c664e64db17205783ef2991c:
>
>   Merge branch 'po-id' of github.com:bagasme/git-po (2023-08-21 07:05:38 +0800)

Thanks, will do.
