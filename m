Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65326C433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 21:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350128AbiDKVQm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 17:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350147AbiDKVQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 17:16:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF1F11A26
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 14:14:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0982618903B;
        Mon, 11 Apr 2022 17:14:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K4obtctaKcyt
        mNjycKpzYIkeE6h9dEJLE6iauuG9f7Q=; b=h9Eq1lYqAPpksbScrKvifPGvFezY
        6hND2QAaK7a7M9xmq0lnJ8FpE7h31dck5IlKnCvLEg4ewT6Sr9lK0nDV/J3ecghr
        MU8HAB7tVnr3+58uMOTMbM5MEfD2k0aV+XNXsVVGzq6Y/LXU5bOdP6yBUOG1EMiz
        VYFHN/XnW1xsX4E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0212418903A;
        Mon, 11 Apr 2022 17:14:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 58E66189039;
        Mon, 11 Apr 2022 17:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] i18n: fix some badly formatted i18n strings
References: <pull.1212.git.1649705011178.gitgitgadget@gmail.com>
Date:   Mon, 11 Apr 2022 14:14:20 -0700
In-Reply-To: <pull.1212.git.1649705011178.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
        Avila via GitGitGadget"'s message of "Mon, 11 Apr 2022 19:23:30
        +0000")
Message-ID: <xmqqwnfvfhlf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5B163462-B9DC-11EC-B7D7-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> String in submodule--helper is not correctly formatting
> placeholders. The string in git-send-email is partial.
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>     V2.36 i18n fixes
>    =20
>     While translating the latest version of the messages, I encountered=
 a
>     few errors of formatting or management.

Thanks.  Will queue directly on top of 'master'.
