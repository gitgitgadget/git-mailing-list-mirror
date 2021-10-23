Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D56C433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 22:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A76660F43
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 22:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhJWW2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 18:28:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52978 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhJWW2y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 18:28:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7908FECD7;
        Sat, 23 Oct 2021 18:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=N23OWUxTa4CJ
        VnTnt4I9aovtvV5CA17xbFjEyI7U2JM=; b=oR6PAgzx7NJNFJvEHFFf6GZjCRp/
        akekBsPSPbbnUi2ULx8vI4+Pgu6WJGFh0hkO1nxW/HhTOHmBvduZFtz69g056C1c
        9iSi9fcWqdO2X8qwOCRqKhLS/p7Wp4OeL8XoUkjWrFdgIuwNHe4OBWNznscix6Bh
        0au2asCnpnKBZjI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE6ACFECD6;
        Sat, 23 Oct 2021 18:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33E23FECCC;
        Sat, 23 Oct 2021 18:26:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 09/10] generate-cmdlist.sh: replace "grep' invocation
 with a shell version
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
        <patch-v2-09.10-7903dd1f8c2-20211022T193027Z-avarab@gmail.com>
Date:   Sat, 23 Oct 2021 15:26:33 -0700
In-Reply-To: <patch-v2-09.10-7903dd1f8c2-20211022T193027Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 22 Oct
 2021 21:36:13
        +0200")
Message-ID: <xmqq35or9y3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4772584E-3450-11EC-A977-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +		"#"*)
> +			continue;
> +			;;

Stray ';' after continue.
