Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70B8C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiF3Xxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiF3Xxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:53:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD145109
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:53:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5F6A136AC1;
        Thu, 30 Jun 2022 19:53:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0jI/7eR6JwrZ
        L6BCwMC8B2ePoRGPQFhvQJAfybyVJlw=; b=G6me+OX3Gyvq1L1+CmAIv+XGrW5x
        fJj1+8c17+gtqSUV7ELsptvbJgTMAgPmlmnhj440EsUoA0Os+XORHuK8+Pvd6YGl
        c4eazzzO+9GcnFXYQWlYClTAxbu6gYkeI6n09y/mEzehsGbnabEmD7NaFwDX1eSb
        c+bDYBdEcnAfyqI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8075136AC0;
        Thu, 30 Jun 2022 19:53:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4FB4136ABF;
        Thu, 30 Jun 2022 19:53:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Siddharth Asthana <siddharthasthana31@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
References: <20220630142444.651948-1-siddharthasthana31@gmail.com>
        <20220630142444.651948-4-siddharthasthana31@gmail.com>
        <220701.86sfnlbu0j.gmgdl@evledraar.gmail.com>
Date:   Thu, 30 Jun 2022 16:53:03 -0700
In-Reply-To: <220701.86sfnlbu0j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 01 Jul 2022 01:36:40 +0200")
Message-ID: <xmqqr135aeu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C8A137AC-F8CF-11EC-AC39-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> So not as a blocker for this change, which I think can be made small
> enough to be justified in cat-file, but just for context: If "git log"
> had a similar --batch mode,

Perhaps "xargs git show" is what you want? ;-)
