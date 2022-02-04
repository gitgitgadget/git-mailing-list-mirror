Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964F4C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 20:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiBDUyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:54:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61457 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiBDUyj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 15:54:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48027174B76;
        Fri,  4 Feb 2022 15:54:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AcitVHoljxPu
        1JpmPZjMqPC9bJ/1dboKF0dFUwm1Hos=; b=BrYJfNqExONf5ppv5uw1aNeX18+W
        yxJGXOdo14TtFNwcEbR8HNb3go5bLjNdFCg0LSIOvYeLO9mZNDmBGTyTdeRktDOB
        ZpheEXQKdJUKdBMfq6vE0A2NG3fcXNuesE/ZZd2IlcFwAjQ5ZsLB0/iN7Gf62fw2
        HWKF3VJ97NbXipk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41EFF174B75;
        Fri,  4 Feb 2022 15:54:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1795174B73;
        Fri,  4 Feb 2022 15:54:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 05/11] object API: correct "buf" v.s. "map" mismatch
 in *.c and *.h
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
        <cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com>
        <patch-v2-05.11-207aec4eb64-20220204T135005Z-avarab@gmail.com>
Date:   Fri, 04 Feb 2022 12:54:35 -0800
In-Reply-To: <patch-v2-05.11-207aec4eb64-20220204T135005Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 4 Feb
 2022 14:51:19
        +0100")
Message-ID: <xmqqo83ml5dg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9B9905A-85FC-11EC-AFC4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the name of the second argument to check_object_signature() to
> be "buf" in object-file.c, making it consistent with the prototype in
> cache..h

Double dot X-<.
