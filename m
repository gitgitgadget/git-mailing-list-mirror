Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317D9C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiAJRGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:06:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64036 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbiAJRGb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:06:31 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CE6717E865;
        Mon, 10 Jan 2022 12:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QukpgFtA3r9Tw0D4GIYXRw/ZkW+a2+V4RV8YGW
        l1nnY=; b=vwMxoYMYesX3Bl+d6Oyp1hMiyQK4EyHGeEaBsPz1DvMoc+GGCH2d9F
        C6X4C5J/XTfc0fQSEgt5G9iM2ex27ka0M81U0AUzPcxyL88SHrPFXVqZdLUWwBdC
        3zEUQAx4fX/62a1P7Fp0JA3/m9nIt2ion7FHX0aQV0gzg881TXr8g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65CD617E864;
        Mon, 10 Jan 2022 12:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CED5717E863;
        Mon, 10 Jan 2022 12:06:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ramkumar Ramachandra" <r@artagnon.com>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: git bisect bad @
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
        <xmqqilus3ctf.fsf@gitster.g>
        <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
Date:   Mon, 10 Jan 2022 09:06:27 -0800
In-Reply-To: <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com> (Ramkumar
        Ramachandra's message of "Sun, 09 Jan 2022 21:48:19 +0100")
Message-ID: <xmqq4k6b34h8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6C96A56-7237-11EC-9A02-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ramkumar Ramachandra" <r@artagnon.com> writes:

>   # on coq.git, for those curious
>   $ git bisect start
>   $ git bisect bad @
>   $ git bisect good V8.14.1
>   $ git bisect run bisect.sh # oops!
>   Lancement de  'bisect.sh'
>   'bisect.sh': bisect.sh: command not found
>   La base de fusion ea3595845f5013359b2ba4402f948e454350a74c est mauvaise.
> ...

"command not found"?

