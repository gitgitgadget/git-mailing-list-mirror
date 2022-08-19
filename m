Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE64FC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 21:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352268AbiHSVSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351430AbiHSVSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 17:18:40 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BA146229
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 14:18:37 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D13913B108;
        Fri, 19 Aug 2022 17:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=IOYg8vGcxnrh
        0If5WzyOyffXu4RVPruK4EJsXnO/bCo=; b=hHCQdJTrEnx6Waid96MfYFocfSkj
        STFTjdweDJMVMWsP2ynkRmnC3SeyX4rUXbwvRjY+MDHiN68fthIRFUIeqJc+G73g
        fUwane8f8l4y6GYYwvEgH+M5V+5f4YtnE0nqYR87PFJHvR3iugy6YTuW9I3eYMgJ
        QRR0/3Qu9IZb6r0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94E5713B107;
        Fri, 19 Aug 2022 17:18:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A0A213B106;
        Fri, 19 Aug 2022 17:18:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 0/2] tr2: shows the scope unconditionally with config
References: <cover.1658472474.git.dyroneteng@gmail.com>
        <cover.1660272404.git.dyroneteng@gmail.com>
Date:   Fri, 19 Aug 2022 14:18:34 -0700
In-Reply-To: <cover.1660272404.git.dyroneteng@gmail.com> (Teng Long's message
        of "Fri, 12 Aug 2022 10:56:44 +0800")
Message-ID: <xmqqpmgwj5jp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7C972482-2004-11ED-A1EC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> Diff from v1:
>
> * Fix the premature code in [1/2] by Junio's comment in:
>
>   https://public-inbox.org/git/xmqqy1wkc0yw.fsf@gitster.g/
>
> * Optimize the documentaion in [1/2] by =C3=86var's comment in:
>
>   https://public-inbox.org/git/220722.86fsits91m.gmgdl@evledraar.gmail.=
com/
>
> I send this patch version a little earlier maybe because some context n=
ot fully
> discussed or solved, intend to avoid context signal disappearance becau=
se it's
> been lasted a while now.=20

We haven't seen any comments (other than mine) for a full week, and
am wondering if everybody is happy with it.  Let me mark it for
'next' in the draft of "What's cooking" and merge it down.
