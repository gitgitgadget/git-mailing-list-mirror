Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE2C433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 06:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350262AbiDTGQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 02:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiDTGQP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 02:16:15 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D3938BF8
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 23:13:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F98A17BB11;
        Wed, 20 Apr 2022 02:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=KSD+dKXCp7D9iCh6AO/ZK5rNPeg+yg+yYxiCjAqYW04=; b=kaWc
        BFpums/i+oegW1cWjKvH2oNpm1F2SKIPInixX0OxN8Cb66AbdATrdqFe8+5U+LYj
        qckvqAJJ7MjLqwDknNgbussE7zb/DjmilcvJnrcYOpj7CWuFx9lvd7Ju8QWgPXyX
        UYOUwq6UgjV2jgySKFsDvFxQJISeyERnPogFMLI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6539517BB10;
        Wed, 20 Apr 2022 02:13:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 745C917BB0F;
        Wed, 20 Apr 2022 02:13:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jack McGuinness via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jack McGuinness <jmcguinness2@ucmerced.edu>
Subject: Re: [PATCH] area: /t/t4204-log.sh, partially modernized test script
 t4202
References: <pull.1218.git.1650096550631.gitgitgadget@gmail.com>
Date:   Tue, 19 Apr 2022 23:13:24 -0700
Message-ID: <xmqqmtggs2nv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCFC866A-C070-11EC-83D3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jack McGuinness via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jack <jmcguinness2@ucmerced.edu>
> Subject: Re: [PATCH] area: /t/t4204-log.sh, partially modernized test script t4202

I am not sure what "area" in this context is.  Do not report what
you did in past tense on the title.

Perhaps

    Subject: [PATCH] t4202: modernize code layout

or something?

> Remove test body indentations made with spaces, replace with tabs.
> Remove blank lines at start and end of test bodies.

OK.  The title says "partially", strongly hinting that the script is
not fully modern even if we take this patch.  There should be some
mention of left-over work that is left to a later occasion here.

Thanks.
