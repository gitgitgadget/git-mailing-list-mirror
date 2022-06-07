Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1F2CCA47F
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376683AbiFHA2e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578347AbiFGXcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:32:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C7C251026
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 15:02:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41B3318977E;
        Tue,  7 Jun 2022 18:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+CTv+RUtAPH/OQ3Ly6Jd0oXJsyBkktqLOEOoqs
        G0x+8=; b=j/qX2fZv05FOsAkYkvDeN1GphZqE/kgdJ85/bOm2UCrHWTnMFzboTQ
        +mm1IAWliQdhg2oX+T6jfxqD3Gr/ZxAm/KYydKWwq3JCWthC7ufTw42FjU1yV2dq
        vgh8+dr5+D+aYsnqbajRYKdrpTYd2Otjw9EnEYwoIY/jHEtttNEG0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39DD118977D;
        Tue,  7 Jun 2022 18:02:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2171A18977C;
        Tue,  7 Jun 2022 18:02:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Vicent Marti <tanoku@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v2 2/3] bitmap-format.txt: fix some formatting issues
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
        <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <cb919513c14d426b51051ee5c16badec37538032.1654623814.git.gitgitgadget@gmail.com>
        <Yp+6WU+k2OwHDB1b@nand.local>
Date:   Tue, 07 Jun 2022 15:02:22 -0700
In-Reply-To: <Yp+6WU+k2OwHDB1b@nand.local> (Taylor Blau's message of "Tue, 7
        Jun 2022 16:51:37 -0400")
Message-ID: <xmqq1qw0uo7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 824E2014-E6AD-11EC-A90F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Similarly, everything below the "A header appears at the beginning"
> list item appears in a <pre> element, so the rendered HTML looks more
> like plaintext to me.

True.  Unless we are going to revamp the text in some major way so
that we produce "true" HTML, not just the text source enclosed in a
<pre></pre> pair, I would think we are better off keeping it not
passed to AsciiDoc and leaving it in text format.  After all, modern
browsers, which I presume those who want HTML output files would
read them with, can display plain text files just fine, don't they?

> This isn't new from your patch, but I wonder if now is a good
> opportunity to make some light use of the formatting options that
> ASCIIDoc gives us to make the page read a little bit more easily when
> rendered as HTML.

There was some talk about asking those who are adept at website
engineering to work on git-scm.com; it may be a good starting point
to look at these text files that weren't originally written to be
given to AsciiDoc and convert them to be true AsciiDoc sources.

Thanks.
