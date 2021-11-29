Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D116FC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 17:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348366AbhK2Rfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:35:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55565 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhK2Rdo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 12:33:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BE10EEC86;
        Mon, 29 Nov 2021 12:30:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=O+K7eAjeJGWL
        pUK68rjO+HljNqocdhR2GMKFMrm6Vcg=; b=jbnkPUwEFdHYiZeFkdfJMnUaJIze
        xvtsMzKH/x51CdtW/wjWx+xJx5ObEhcUgp7X1Ue4o5kgfMr9R5tVGdyljUS/XOqC
        7hySz7qCNQllu1PqFuhbCvPwoXAoeTqUUsZ33JTYwwq8hV4i5wuTlGp6M+abCKlu
        GoPyCIT2X+mZIbs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FA4BEEC85;
        Mon, 29 Nov 2021 12:30:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 79420EEC83;
        Mon, 29 Nov 2021 12:30:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2] mingw: avoid fallback for {local,gm}time_r()
References: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
        <pull.1142.v2.git.git.1638008132992.gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 09:30:24 -0800
In-Reply-To: <pull.1142.v2.git.git.1638008132992.gitgitgadget@gmail.com>
        ("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Sat, 27
        Nov 2021 10:15:32 +0000")
Message-ID: <xmqq1r2y50pb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A57EDC8-513A-11EC-8E66-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlo Marcelo Arenas Bel=C3=B3n via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Carlo=3D20Marcelo=3D20Arenas=3D20Bel=3DC3=3DB3n?=3D <=
carenas@gmail.com>
>
> mingw-w64's pthread_unistd.h had a bug that mistakenly (because there i=
s
> no support for the *lockfile() functions required[1]) defined
> _POSIX_THREAD_SAFE_FUNCTIONS and that was being worked around since
> 3ecd153a3b (compat/mingw: support MSys2-based MinGW build, 2016-01-14).
> ...
>     Changes since v1:
>    =20
>      * Fixed grammar in the commit message (suggested by Junio)
>      * Added ACK (proposed by dscho)

Thanks. Queued.
