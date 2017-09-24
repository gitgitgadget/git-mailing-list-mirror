Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B61202A5
	for <e@80x24.org>; Sun, 24 Sep 2017 07:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdIXHBn (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 03:01:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750947AbdIXHBn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 03:01:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4025B5AB2;
        Sun, 24 Sep 2017 03:01:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uMTpk8T5AJxM
        AqkEe/v97+pw/Mw=; b=cfuud284xNGvx9520YGDvK0uWmuYjKv7rlntPmA2Rs8s
        Wos6eN0e9Vdkh7ExuLxUl+Cr3ABVkrxZszThVkuUC788xQA29Qpo+rOX8TDzqKMP
        bUPY12NX9p/BzTTKTbr4tVoikNYPt6FGaWfuD63oF2F+sHsB4xM/JHAFnn2FTC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nutSkY
        fela1Sp5wvNThNkJ+rKPnTmCYbBxLcymMilQ6mq3el6ofea8HLqosl8w6lcqu/BF
        UFQiacxDlVUdTgfnJSLkHiPzf5BCdkrA3JhoFIcggNhXl1bAzkJrqXik6vpwyiS6
        NrVAMeWXzYw+9gMj5d6sK4VEPiMCiB/kya0yw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACF7EB5AB1;
        Sun, 24 Sep 2017 03:01:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E46CB5AB0;
        Sun, 24 Sep 2017 03:01:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
        <cover.1506120291.git.martin.agren@gmail.com>
Date:   Sun, 24 Sep 2017 16:01:40 +0900
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sat, 23 Sep 2017 01:34:48 +0200")
Message-ID: <xmqqh8vsh963.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3814E9B2-A0F6-11E7-BC1F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Since Junio collected my "independent" patches into ma/leakplugs, this
> is a re-roll of that whole topic. I got the first two patches from
> Junio's tree. The only difference there is "builtin/" at the very start
> of the first commit message.

Thanks, all 6 look sensible.

