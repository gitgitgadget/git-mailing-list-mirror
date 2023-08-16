Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C0CC07E8A
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 18:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345560AbjHPSfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345562AbjHPSfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 14:35:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360A0E7F
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 11:35:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D26712D8F4;
        Wed, 16 Aug 2023 14:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yc44IRJtzQRA
        6Gpqtwg1OvOgL4Nko6JaYNIv4vZylcs=; b=DfYKZ8v40bZdbgJpfkflmkgjsGRJ
        JtG2kubL3gYWNyG/6TSD99u1vcwwJBp5K7D88kud5PDquKdXB0MoZ/XNMx9edKP8
        T1oc74FPPq15o3nuAzG8G4fj3KwECIGdYNd4m5+0/XnL9zaZ5I0NqxyJiFBx6u5v
        D8Ka8PLcRgdTJ+s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAD7B2D8F3;
        Wed, 16 Aug 2023 14:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D82572D8EF;
        Wed, 16 Aug 2023 14:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] some doc fixes on v2.42.0-rc2
References: <cover.1692194193.git.martin.agren@gmail.com>
Date:   Wed, 16 Aug 2023 11:35:17 -0700
In-Reply-To: <cover.1692194193.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 16 Aug 2023 16:24:32 +0200")
Message-ID: <xmqq7cpug7iy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A690E468-3C63-11EE-9A81-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Looking into the changes to our documentation from v2.41.0 up to
> v2.42.0-rc2, I found some improvements we could make. I've cc'd the
> original authors on this cover letter and the respective patches.

It is good that you looked into these, as everything else is slow
during the pre-release freeze period, and we are prioritizing
regressions made during the latest cycle.  Watching out for bugs in
the documentation updated during the cycle is much better than
building a random new feature ;-)

> I realize we're fairly late in the release cycle. The impact of these
> patches is small, which could mean they're "low risk" or "low benefit"
> depending on how you want to look at it.

That is certainly true.

Thanks.
