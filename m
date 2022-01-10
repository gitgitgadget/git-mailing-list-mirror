Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB794C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 22:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbiAJWUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:20:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54939 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiAJWUm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 17:20:42 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79898103C44;
        Mon, 10 Jan 2022 17:20:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rsobmQhN2soZ
        wuv9QXQQeHmNavvBfLa/bPL3555pyZM=; b=db4e9TztHMac7WqLC8eGpPfDUqTQ
        +sgjZvfaKBnFpM9/b2dA9KNNdHE+c1DtgDM0vIPZRlj8UWh4P7oHRucaHLAxwvip
        ep0FZPp5puIqNwEJx7TcPkI0216AxDKnn85aqL9eoYe4oc5VDcKRTuTW0uzzwh9F
        iB87miq2cDyHe1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7053E103C43;
        Mon, 10 Jan 2022 17:20:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D395B103C42;
        Mon, 10 Jan 2022 17:20:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 0/2] fixups for issues in next-merged ab/cat-file
References: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com>
        <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
Date:   Mon, 10 Jan 2022 14:20:37 -0800
In-Reply-To: <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 10 Jan
 2022 23:08:44 +0100")
Message-ID: <xmqqczkzxmfe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8C10034C-7263-11EC-953F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series goes on top of ab/cat-file, which was merged to next in
> e145efa6059 (Merge branch 'ab/cat-file' into next, 2022-01-05).

Both patches look good.  Will queue.
