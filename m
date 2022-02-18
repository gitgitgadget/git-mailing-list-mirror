Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2EBC433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiBRQv6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 11:51:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiBRQv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 11:51:56 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9935646F
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 08:51:38 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 965E318CED0;
        Fri, 18 Feb 2022 11:51:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zLwVhYVsGbIv
        nH6KzOfTl/Ab0vg5eQWeXE/EJG/Dqnk=; b=mCckE5ySf54GkE3rcpFbFTjQpV/Y
        5Vti+85Uw0M+rTadp92ScCj+biXCu+AU2fdMZvqKAb0unnzbjTXQThZgjNHtB2mM
        xfbSeVIfyzHEaNHZKxs99xRjI2HGY3lXRkoO6KnIFVlwdgEfhHhWT1a8ftrig5W7
        112KS03ZDjpqfr8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F8C018CECF;
        Fri, 18 Feb 2022 11:51:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F222218CEA5;
        Fri, 18 Feb 2022 11:51:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2022, #05; Thu, 17)
References: <xmqqley93rkw.fsf@gitster.g>
        <CABPp-BEpQaHwyj_0h5V8tMWSPsqhSg3E42McAow-q50=MNpyyA@mail.gmail.com>
Date:   Fri, 18 Feb 2022 08:51:34 -0800
In-Reply-To: <CABPp-BEpQaHwyj_0h5V8tMWSPsqhSg3E42McAow-q50=MNpyyA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Feb 2022 19:28:30 -0800")
Message-ID: <xmqq35kg3yp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08B6C9CC-90DB-11EC-9524-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * en/sparse-checkout-fixes (2022-02-17) 5 commits
>
> Please hold off; I'll send in a re-roll with some improvements
> suggested by =C3=86var and you.

Thanks.  Will expect a reroll.
