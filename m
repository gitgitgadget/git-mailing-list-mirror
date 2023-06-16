Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C5BEB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 23:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjFPXpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 19:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFPXpq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 19:45:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B97F26B3
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 16:45:46 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7582518DCF7;
        Fri, 16 Jun 2023 19:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PeE8Xzd4pyaM
        CgxRStpqrhQa6X7oKNxQUgrLybNKYFc=; b=MlgE/IppAc06ySrLW3gwxDcGSqsk
        0h5E4Rjm1DZt1T0wWtyr41sJTi8UyAwjeSUXBHva97ubTt+jaCYcVvsu+8NvaVbl
        kGg1YE0qFrb5PR+v2COvS8XRsA8nAK7/nWud/SXHIW0/6rl3DPdPEbvKqTr0OcP8
        0AkxmOOD5EOF9KQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6DDE518DCF5;
        Fri, 16 Jun 2023 19:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C195A18DCF4;
        Fri, 16 Jun 2023 19:45:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] tests: mark as passing with SANITIZE=leak
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
        <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
Date:   Fri, 16 Jun 2023 16:45:43 -0700
In-Reply-To: <5650c4ed-cec0-d11e-4f68-1661b3638786@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sat, 17 Jun 2023 01:27:47 +0200")
Message-ID: <xmqqfs6rrmxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E946431E-0C9F-11EE-9C07-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> This is the second version of this series.  However, a subset of the
> patches from the first version have already been merged to 'next'.
> Therefore, those are not included here.
>
> These are the rest of them, which address Peff's reviews.

Thanks!
