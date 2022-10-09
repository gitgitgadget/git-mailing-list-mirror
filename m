Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFDCC433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 05:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJIFhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 01:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJIFhe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 01:37:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FFB32AB0
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 22:37:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EB37151CEF;
        Sun,  9 Oct 2022 01:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=i/2yZ3kotvc5DYsCKTqPM7Ayj
        8NO1rqxZ8/bIXLcx4w=; b=NAwXxsIzBNuvOlmasjMBZGTfZU8x9KBvtr7xMt5d/
        njSFNh2h2S90xZ7h7yOwHNXx3s2a5wIsYP88v2M7voFk5KLlFZK2vG//+ObZpk60
        4/WCA3lTNGwUuSOEQQAL9o86idzrUoLx/l+7VWyY8JRVpwGSjLLy91i9IMEVsmFF
        uI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36740151CED;
        Sun,  9 Oct 2022 01:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72DFE151CEC;
        Sun,  9 Oct 2022 01:37:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] branch: support for shortcuts like @{-1}, completed
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
        <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
        <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
        <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
        <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com>
Date:   Sat, 08 Oct 2022 22:37:31 -0700
Message-ID: <xmqqlepp8smc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 78BF4FEE-4794-11ED-AF88-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> ... I think this is a good stop point for this change if no new problem=
s
> are detected.
>
> Un saludo.

Looks good.

Thanks.
