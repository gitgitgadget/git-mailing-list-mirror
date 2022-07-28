Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40361C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 20:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiG1Uke (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiG1Ukc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 16:40:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C0474FA
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 13:40:29 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ECD8132958;
        Thu, 28 Jul 2022 16:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YHKL/snBSJ1P
        xGaRYmDbAmao2FNPqf6cM/N0sntk3T8=; b=Q6l8+WPUoIMJAQ/3Hza2Iy/OKqMV
        3JZB3QJg+zlBDNNUpDAQI2p0OMFal0xAyIjdR14giSANbsFZgaTkrYBTFPNR1v7G
        gei6T30B+q93nRLVvGxfkFrfxoNxDQshv80uf8f1DdJlkOEMb/5G0lmNrHeOM657
        9mqMAjrpyt9lIxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36A21132957;
        Thu, 28 Jul 2022 16:40:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A05A9132954;
        Thu, 28 Jul 2022 16:40:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH v6 0/9] docs: create & use "(user|developer) interfaces"
 categories
References: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
        <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
Date:   Thu, 28 Jul 2022 13:40:25 -0700
In-Reply-To: <cover-v6-0.9-00000000000-20220728T164243Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 28 Jul
 2022 18:46:39
        +0200")
Message-ID: <xmqqzggt9dja.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82ECE200-0EB5-11ED-A6F9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> See the v5 for a general overview:
> https://lore.kernel.org/git/cover-v5-0.9-00000000000-20220721T160721Z-a=
varab@gmail.com/
>
> This trivial v6 fixes a grammar error in a commit message pointed-out
> by Eric Sunshine, thanks Eric!

This seems to be identical to what we already have in my tree, which
is OK.

Will not queue but instead keep the old one that has the fix applied
when it was queued, to keep the author & committer dates.

Thanks.
