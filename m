Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86583C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 21:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiG2V65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 17:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiG2V64 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 17:58:56 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB3A8722B
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 14:58:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E4E11A48E4;
        Fri, 29 Jul 2022 17:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RPz1IQ3hAqmf
        d3w/YX+iq5M+R2JuV0lT5E1nidem8nw=; b=bQtAytbvdsGD1r2hqtQ8/XvVcUNc
        wogHeI4K7orUVrjQiXY3xxS5GJx0iCebdW7bblG6CwxqbHmfG1BbufbMA499Mw+4
        2wzOSipe7LzeODJEKOyTK+rfv2WTEBqe/HRQ9pdVlIqj6nA9FCbnND6tmzSIjoGx
        2Ytprsycl/mHhbA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8669B1A48E3;
        Fri, 29 Jul 2022 17:58:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 254B61A48E0;
        Fri, 29 Jul 2022 17:58:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v2 8/9] docs: add CONFIGURATION sections that map to a
 built-in
References: <cover.1657819649.git.matheus.bernardino@usp.br>
        <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
        <patch-v2-8.9-5c379ab1476-20220729T081959Z-avarab@gmail.com>
Date:   Fri, 29 Jul 2022 14:58:51 -0700
In-Reply-To: <patch-v2-8.9-5c379ab1476-20220729T081959Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 29 Jul
 2022 10:25:54
        +0200")
Message-ID: <xmqqv8rf4m3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2077374-0F89-11ED-9909-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a CONFIGURATION section to the documentation of various built-ins,
> for those cases where the relevant config/NAME.txt describes
> configuration that is only used by the relevant built-in documented in
> git-NAME.txt. Subsequent commits will handle more complex cases.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  Documentation/git-add.txt          | 7 +++++++
>  Documentation/git-am.txt           | 7 +++++++
>  Documentation/git-clean.txt        | 7 +++++++
>  Documentation/git-clone.txt        | 7 +++++++
>  Documentation/git-commit-graph.txt | 7 +++++++
>  Documentation/git-commit.txt       | 4 ++++
>  Documentation/git-fast-import.txt  | 7 +++++++
>  Documentation/git-mailinfo.txt     | 7 +++++++
>  Documentation/git-maintenance.txt  | 7 +++++++
>  Documentation/git-push.txt         | 7 +++++++
>  Documentation/git-revert.txt       | 7 +++++++
>  Documentation/git-show-branch.txt  | 7 +++++++
>  Documentation/git-stash.txt        | 7 +++++++
>  13 files changed, 88 insertions(+)

This is one of the larger patch in the series, but everything here
follows the same pattern and is easy to see that they are correct.

