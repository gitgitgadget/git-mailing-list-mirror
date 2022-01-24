Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB306C433F5
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 17:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbiAXRKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:10:30 -0500
Received: from pb-sasl-trial20.pobox.com ([173.228.157.50]:58957 "EHLO
        pb-sasl-trial20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiAXRK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 12:10:28 -0500
Received: from pb-sasl-trial20.pobox.com (localhost.local [127.0.0.1])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 4F4ED1B4B3;
        Mon, 24 Jan 2022 12:10:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IhSoHgu+yizfQk6ePg22NnxS5Do=; b=euV628
        Tqj+jWPHfZaso/DW+KjN2D6RnksIkHicQVxpTqXKSNENP5vOsIwMrUwGea+xDvg0
        sTcvpJ8RSCHGNF2wRXtjh1GNgZ4Ybtl2a6Wobbfqwm/hmtwIZ6ISk6HUR+LgPqIX
        KmoZstucmnWuyKCjHU/Sal4ZMY52gtaTCcZKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XnxkPKQGAzbHb+2m+G7Jd2ImLxMUWz1Y
        aU3nJPWiaM3hvhvlGTA2cNKfUKiz5x9iISjvx+pzKNX56k5kQIWb2rdLcrwB0hfS
        Z2IIms2eo4/MMVu82ajRVWx+AHL49NQf7SjHHZMPK8vEscFqKhJb2Jzu0vNXjlJm
        rkkMcR8zD3Y=
Received: from pb-smtp21.sea.icgroup.com (pb-smtp21.pobox.com [10.110.30.21])
        by pb-sasl-trial20.pobox.com (Postfix) with ESMTP id 3EEDC1B4B0;
        Mon, 24 Jan 2022 12:10:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 916FE1785B3;
        Mon, 24 Jan 2022 12:10:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git l10n discussion group <git-l10n@googlegroups.com>,
        Git List <git@vger.kernel.org>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Alexander Shopov <ash@kambanaria.org>,
        Arusekk <arek_koz@o2.pl>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Daniel Santos <daniel@brilhante.top>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Emir SARI <bitigchi@me.com>, Emir SARI <emir_sari@icloud.com>,
        Fangyi Zhou <me@fangyi.io>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Jordi Mas <jmas@softcatala.org>,
        =?utf-8?Q?J=C3=BCrgen_Kr=C3=A4mer?= <jkr@jottkaerr.de>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBR?= =?utf-8?B?dcOibg==?= 
        <vnwildman@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.35.0 round 2
References: <20220123122925.22967-1-worldhello.net@gmail.com>
Date:   Mon, 24 Jan 2022 09:10:22 -0800
In-Reply-To: <20220123122925.22967-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sun, 23 Jan 2022 20:29:25 +0800")
Message-ID: <xmqq5yq96ow1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8518F9C4-7D38-11EC-8D4D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following l10n updates for Git 2.35.0.
>
>  po/bg.po    | 6281 +++++++++++++++++++--------------------
>  po/ca.po    | 9522 +++++++++++++++++++++++++++--------------------------------
>  po/de.po    | 6332 +++++++++++++++++++--------------------
>  po/fr.po    | 6661 +++++++++++++++++++++--------------------
>  po/git.pot  | 6009 +++++++++++++++++++------------------
>  po/id.po    | 6719 ++++++++++++++++++++---------------------
>  po/sv.po    | 6681 +++++++++++++++++++++--------------------
>  po/tr.po    | 6379 +++++++++++++++++++--------------------
>  po/vi.po    | 8645 ++++++++++++++++++++---------------------------------
>  po/zh_CN.po | 6911 ++++++++++++++++++++-----------------------
>  po/zh_TW.po | 6627 +++++++++++++++++++++--------------------
>  11 files changed, 37060 insertions(+), 39707 deletions(-)

Thanks, all!  Pulled.
