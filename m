Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7A5C433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FFD60EBC
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 06:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKAGD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 02:03:58 -0400
Received: from pb-sasl-trial20.pobox.com ([173.228.157.50]:53291 "EHLO
        pb-sasl-trial20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhKAGD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 02:03:57 -0400
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 02:03:57 EDT
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id BD7EA230C2;
        Mon,  1 Nov 2021 01:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hib8JPTede8S
        ahIU69oPPcLYp6I=; b=j/WHYJ+FKBg3DRRIxok6Q9VLNnhJNfcEBGgM9dPD6e/Q
        8mrQ3JRbDtwHMBQsIvGjgxqhxUETJEiXQtY9OarMvEda29XK7DtxV4lZw6voxC4T
        20jLF0vxkqnJHd9lL0HiKILGez0Cl1AmY6bx86jkXHG9JFM3T6WFW7a7vzN794E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Zt2RBK
        DWQ326taI0NUCILzH6OIClw4INHXztaFqEy9cA1hXWCxLKvwq37m69QycY8RK89k
        snJa2pdXM8OGAqz1+PjO7Lcykx6OC7BPfgbsk3+Iyax5ijQhfPbe3mBr/S+1yGER
        6fM0efJVX08iZbnxaBpPXzDIKeeKxc8EEXDyM=
Received: from pb-smtp20.sea.icgroup.com (pb-smtp20.pobox.com [10.110.30.20])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 9E381230C1;
        Mon,  1 Nov 2021 01:51:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35DF115CCBF;
        Mon,  1 Nov 2021 01:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Fabian Stelzer <fs@gigacodes.de>,
        ZheNing Hu <adlternative@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
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
Subject: Re: [PATCH v2] i18n: fix typos found during l10n for git 2.34.0
References: <20211031052156.5237-1-worldhello.net@gmail.com>
        <20211101021417.9549-1-worldhello.net@gmail.com>
Date:   Sun, 31 Oct 2021 22:51:07 -0700
In-Reply-To: <20211101021417.9549-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Mon, 1 Nov 2021 10:14:17 +0800")
Message-ID: <xmqq8ry8e850.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B64D5B0A-3AD7-11EC-BF26-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Emir and Jean-No=C3=ABl reported typos in some i18n messages when prepa=
ring
> l10n for git 2.34.0.
>
> * Fix unstable spelling of config variable "gpg.ssh.defaultKeyCommand"
>   which was introduced in commit fd9e226776 (ssh signing: retrieve a
>   default key from ssh-agent, 2021-09-10).
>
> * Add missing space between "with" and "--python" which was introduced
>   in commit bd0708c7eb (ref-filter: add %(raw) atom, 2021-07-26).
>
> * Fix unmatched single quote in 'builtin/index-pack.c' which was
>   introduced in commit 8737dab346 (index-pack: refactor renaming in
>   final(), 2021-09-09)
>
> [1] https://github.com/git-l10n/git-po/pull/567
>
> Reported-by: Emir Sar=C4=B1 <bitigchi@me.com>
> Reported-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  builtin/index-pack.c | 2 +-
>  gpg-interface.c      | 2 +-
>  ref-filter.c         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

All three hunks look sensible.

Will directly apply on 'master'.

Thanks. =20
