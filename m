Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D85C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 22:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C1660F43
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 22:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhJWWgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 18:36:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54846 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhJWWgt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 18:36:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8060C15D40B;
        Sat, 23 Oct 2021 18:34:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=/AGfZkWjwbLW4dWFa04X1azEE
        qUTkVNtQ+LnQ3L4xio=; b=UUwviCYZLgSdGIX6X1YQvvXRDoP3VahbpRmeMCNI8
        TgwOAjUvsQwC+hRNcHivHmBYmStEYKc07ykGk0wFzLymDfk6UW+OrkcSojNevzMg
        egzQCSTLrtZjiIMqtfy0vgWsme9QTH4rYlZIArcD/HLTzAfgB+1c+qt3nz4xEqWt
        j8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78BA515D40A;
        Sat, 23 Oct 2021 18:34:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAB1815D409;
        Sat, 23 Oct 2021 18:34:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] Makefile: make generate-cmdlist.sh much faster
References: <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
        <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
X-Gnus-Delayed: Sat, 23 Oct 2021 19:15:28 -0700
Date:   Sat, 23 Oct 2021 15:34:25 -0700
Message-ID: <xmqqsfwr8j66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 612EDD10-3451-11EC-B241-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Subject: Re: [PATCH v2 00/10] Makefile: make generate-cmdlist.sh much f=
aster

Stale topic as there is no change to the Makefile.

> This version of this series drops the Makefile-powered version of the
> cmdlist in favor of making the shellscript much faster, mostly with
> suggestions from Jeff King.

OK.

I looked at the whole thing and it looked almost done, modulo just a
little breakages here and there whose corrections should be fairly
obvious.

Thanks.
