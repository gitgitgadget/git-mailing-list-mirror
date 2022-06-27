Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB9C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238525AbiF0Pi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbiF0PiX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 11:38:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384EC18E37
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 08:38:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C12B13B565;
        Mon, 27 Jun 2022 11:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GhOmFD3ZVyO2
        5Sy8RlXkGx6V926kb0llTqxA8HZUlA8=; b=KnU2U8gXbmCkTkiCkxOZW+COPkUX
        KLU5A/AnBNg6fCNIAuddFDTHeluoTnCpZVEP8QzPCMzAfBGow2N/4wmm4xr5ROF2
        vxmertPJE4ZJHwVsY7kH6+TOcz+czPO82p8D+wr6vTgZJyapvtZFneHhmV8xzN7i
        ySsVcPgLORYOdNg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88CAF13B563;
        Mon, 27 Jun 2022 11:38:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E524A13B562;
        Mon, 27 Jun 2022 11:38:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revert: optionally refer to commit in the "reference"
 format
References: <xmqqsfp2b30k.fsf@gitster.g>
        <6727daf1-f077-7319-187e-ab4e55de3b2d@web.de>
Date:   Mon, 27 Jun 2022 08:38:15 -0700
In-Reply-To: <6727daf1-f077-7319-187e-ab4e55de3b2d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 26 Jun 2022 11:29:35 +0200")
Message-ID: <xmqqletiqfq0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 29F694E6-F62F-11EC-8497-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Actually include it in config.txt.
>
> Make is used with a bare infinitive after the object; remove the "to".

Thanks.
