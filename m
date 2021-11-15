Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6A2C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787EC630EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 05:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhKOF4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 00:56:02 -0500
Received: from pb-sasl-trial3.pobox.com ([64.147.108.87]:61146 "EHLO
        pb-sasl-trial3.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhKOFzv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 00:55:51 -0500
Received: from pb-sasl-trial3.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 90EA41B065;
        Mon, 15 Nov 2021 00:52:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qQNOqdnsPloj5njvzWf0CT7dlUk=; b=fgRVVO
        YB3qizuIjqv1iGLSudB6w2qdaqyiSos4nax2ZgdTwcgkOzBuj3l8ZOYGO9Gu1SDk
        f2DukXzV3QyFabzhHisQbhvg1RC+7jG4p5XvTust0Ache6NvZIZ10PHngmvcnhKi
        9Er+829N0zm5ro4KOs42swyMzi0m6xwN1Xovk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E7e73q1peDuYb0shN999tMjADKnkrp4V
        X0mj7EYA1gQa4IF183C6N49ZsgFdq7q9zLtMj2+g2T1f98jHFpjm5jbOzOG6Sk5C
        ssy3i+bv3UhqwkGThVjXUe0fGIaqh0+KrEz2q/QGCFGKLZTyIG1jeWFm8C+O3PL1
        /p1m2idEOWM=
Received: from pb-smtp1.nyi.icgroup.com (pb-smtp1.pobox.com [10.90.30.53])
        by pb-sasl-trial3.pobox.com (Postfix) with ESMTP id 7E5F01B064;
        Mon, 15 Nov 2021 00:52:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E318FEE2F;
        Mon, 15 Nov 2021 00:52:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <daniel@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.34.0 round 3
References: <20211114122952.11564-1-worldhello.net@gmail.com>
Date:   Sun, 14 Nov 2021 21:52:46 -0800
In-Reply-To: <20211114122952.11564-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 14 Nov 2021 20:29:52 +0800")
Message-ID: <xmqqa6i6klsh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42BF187A-45D8-11EC-9B4E-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Please pull the following l10n updates for Git 2.34.0.
>
> The following changes since commit 6c220937e2b26d85920bf2d38ff2464a0d57fd6b:
>
>   Git 2.34-rc2 (2021-11-09 13:19:51 -0800)
>
> are available in the Git repository at:
>
>   git@github.com:git-l10n/git-po.git tags/l10n-2.34.0-rnd3
>
> for you to fetch changes up to 5a0724ad3ec51d8f75cf139c4d82dbcf55766b9d:
>
>   l10n: it: fix typos found by git-po-helper (2021-11-14 19:40:41 +0800)

I see rnd3.1 tag that has one extra commit on top of 5a0724ad (l10n:
it: fix typos found by git-po-helper, 2021-11-14) but not rnd3, so
after checking that extra commit cae3877e (l10n: pl: 2.34.0 round 3,
2021-11-14), which has one more message translated for Polish in
po/pl.po, I've merged it to 'master'.

Thanks, all.
