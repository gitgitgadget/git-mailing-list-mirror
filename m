Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E520CC47080
	for <git@archiver.kernel.org>; Sun, 23 May 2021 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B4761205
	for <git@archiver.kernel.org>; Sun, 23 May 2021 17:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhEWQx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 May 2021 12:53:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55619 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbhEWQxY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 May 2021 12:53:24 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C996B11FBA4;
        Sun, 23 May 2021 12:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=4fk92w6euFVsIwssP1W0883yd
        0dm5K7V3msvi13vOkk=; b=BoqBCJkRM+LsQ31bom3Kxhxwv5ny5MXVPZvYb4sw6
        OC3pF9YhlNmoIs/hFIlIzwbhHiuu73o3FLrum60HqNxP15cI+/JnauWYyYFAPg5a
        GHAVloEEGVqTuJOks9awLg/ZsIQ+ekeJnkTp806WayBCrd33LEbPkLN2oRnC31iT
        tY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2BBE11FBA3;
        Sun, 23 May 2021 12:51:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17F1211FBA2;
        Sun, 23 May 2021 12:51:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc1
References: <xmqqk0nqq266.fsf@gitster.g> <3156524.cFZ8jhdkIW@cayenne>
Date:   Mon, 24 May 2021 01:51:53 +0900
Message-ID: <xmqqim39o0k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E279412-BBE7-11EB-8566-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Is there any reason the patch
>
> [PATCH] help: fix small typo in error message
>
> was not pushed for update?
>
> It affects translators.

Thanks for asking.  Immediately after -rc0, the i18n coordinator
asked translators to start working based on a snapshot taken back
then; not merging commits that only changes translatable messages is
a way to avoid invalidating the work translators have been done.

