Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5150DC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiFFRo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiFFRo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:44:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A74F32A8D2
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:44:56 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEB3112E9ED;
        Mon,  6 Jun 2022 13:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=CNA/5HCPpEDZn56jh0CRNdW6C
        99PT6Muq24Eqxs+cf8=; b=S2ArVodDIdfxu4ujcFROJMAtGIL1hIguP6oNupO+K
        ztLtq63pzFrTxaQgmMBmDPVamRlrwhGZnjjde1m3PySo5BurahgSulgIjP19NT4b
        3h4Gn+J2GQJZ8I8dOtbJ3qp2faHO0wq8slzNadxU/xVwWkr8AafAWGCTQxPwG7an
        5g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C74C812E9EA;
        Mon,  6 Jun 2022 13:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39E8412E9E8;
        Mon,  6 Jun 2022 13:44:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb"
 without NOOP run slowdowns
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
        <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
Date:   Mon, 06 Jun 2022 10:44:54 -0700
Message-ID: <xmqqa6ap8z55.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6039C4BC-E5C0-11EC-ABD6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The $subject is a proposed re-roll of SZEDER's
> https://lore.kernel.org/git/20220525205651.825669-1-szeder.dev@gmail.co=
m;
> As noted downthread of that fix having the Makefile invoke "make -C
> gitweb" again would slow us down on NOOP runs by quite a bit.

It would be nice to hear comments SZEDER and others, even if the
comments are clear negative or positive.

Thanks.
