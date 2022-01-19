Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072DC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 18:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356595AbiASSSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 13:18:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64498 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiASSST (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 13:18:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89B0A175681;
        Wed, 19 Jan 2022 13:18:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tSZ953gRyKnv
        PHurE3yzPVxcSXPdniJ9z8JfKU7ZBic=; b=YX0sIxxLfmIeepdHAefoaCBdd/g+
        PdSxjBJ3svP9JwD3J73pjo7/2oH8NklYtJKgWJW96pHSXLAqZBWmVA6z2+CcPD/H
        SBheR7sRfAvyH2nhvySTNBuOz+aVdNvzTufj4gP0PePGL47JPzZHRn/eMib5ysfI
        PDh4MH0FpUg4RcI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81F3D175680;
        Wed, 19 Jan 2022 13:18:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F1CC217567F;
        Wed, 19 Jan 2022 13:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/2] advice: refactor "action is not possible because
 you have unmerged files"
References: <20220119094445.15542-1-bagasdotme@gmail.com>
        <20220119094445.15542-3-bagasdotme@gmail.com>
        <3083234.G16DuhSZxH@cayenne>
Date:   Wed, 19 Jan 2022 10:18:15 -0800
In-Reply-To: <3083234.G16DuhSZxH@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Wed, 19 Jan 2022 16:42:35 +0100")
Message-ID: <xmqqh79zoahk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2C5B97CA-7954-11EC-B72F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Playing grammar lego with sentences makes it impossible for translators=
 to find=20
> a good translation.

Well said.

Thanks.
