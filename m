Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9A3C433EF
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbhLZSvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 13:51:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50645 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLZSvs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 13:51:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3ED6A17F561;
        Sun, 26 Dec 2021 13:51:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=jhJFmeqOCsATFGRRTbcdlqGhA
        1aHk5xYoDcXZWn3HKY=; b=aEA6YRGV34CLJFENF19utGTV7R9p0g7anKZU6S0cW
        573OL8QJhesvvW+LjfNsNRS7KGhksjlJMwnpBHpcbQW0UCAbQ3VFiLfSVrIuEIV5
        Y89c9uQDxwaEJQNYC7+RfjAyS1wnNy6iwUxaaOMjMKIO9plTaq5ul3y6K9GWYzlp
        Ew=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37BB717F560;
        Sun, 26 Dec 2021 13:51:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99AD617F55F;
        Sun, 26 Dec 2021 13:51:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Git ML" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: ab/make-dependency (was "What's cooking in git.git (Dec 2021,
 #05; Thu, 23))
References: <211224.86bl15hpec.gmgdl@evledraar.gmail.com>
Date:   Sun, 26 Dec 2021 10:51:43 -0800
Message-ID: <xmqqilvb2o8w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DF16B36C-667C-11EC-BBD5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Between the December 15th[1] and 23rd[2] "What's Cooking" the
> "ab/make-dependency" topic was dropped.

Yup, I thought it was per your request to drop it in [*], so that we
can we can replace them.

> In the interim I'd submitted
> these smaller topics split-out from it:

Thanks, as I've already declared bankrupcy on the messages of list
archive during that period, a summary like this becomes quite handy.

>     patch-1.1-58408f384e7-20211217T000729Z-avarab@gmail.com/
>     patch-1.1-1fafa6c643b-20211217T001137Z-avarab@gmail.com/
>     patch-1.1-90d1e77ad5e-20211217T001628Z-avarab@gmail.com/
>     cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com
>     cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com

[Reference]

* https://lore.kernel.org/git/211217.86a6h09km9.gmgdl@evledraar.gmail.com=
/
