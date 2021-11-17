Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622CBC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488CD6152B
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 08:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhKQImN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 03:42:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62895 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhKQImN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 03:42:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 60DB916BD70;
        Wed, 17 Nov 2021 03:39:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=u4sPX4rYjvDAScO/dgHOcdtd7
        muuzld4NAiPdWpAnGk=; b=TsR9+30SnFll+8TaqdKcQ4Gxy9PNSWQtMZ2+xvOKW
        MD9vxdlLQUmgvRqCqbsgiULbt4ZnU7w8Pmzu49ncZ0GJetPqQCkL6TKnVFx4nTns
        d+DCK8cirQBHNqk1LPOozF7R/SLzSXaUdwiZ5DHLlqES5cKbp2SR/+4d8vqQduOc
        t4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5922116BD6F;
        Wed, 17 Nov 2021 03:39:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AF75516BD6D;
        Wed, 17 Nov 2021 03:39:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 8/8] hook-list.h: add a generated list of hooks, like
 config-list.h
References: <cover-0.8-00000000000-20210923T095326Z-avarab@gmail.com>
        <patch-8.8-80aae4d5c13-20210923T095326Z-avarab@gmail.com>
        <20211115220455.xse7mhbwabrheej4@glandium.org>
        <211115.86k0h9qcf5.gmgdl@evledraar.gmail.com>
        <20211115224015.vzfevpvptysxzpaa@glandium.org>
        <211115.86bl2lqbbt.gmgdl@evledraar.gmail.com>
        <20211115230032.3or3qqlsdnxjtrol@glandium.org>
        <211116.86y25opapy.gmgdl@evledraar.gmail.com>
Date:   Wed, 17 Nov 2021 00:39:10 -0800
Message-ID: <xmqq8rxn41n5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D689A8FE-4781-11EC-AA93-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I submitted a re-roll of the greater dependency fix-up & optimization
> series I've got kicking around, which includes a fix for this
> issue. Thank you for the report:

Makes me wonder what other breakages are introduced in such a big
series, in exchange for correcting this single issue X-<.  We'll see
soon enough, I guess ;-)
