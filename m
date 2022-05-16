Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D4C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 16:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiEPQnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 12:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiEPQnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 12:43:49 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4111D300
        for <git@vger.kernel.org>; Mon, 16 May 2022 09:43:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6820C18ECD8;
        Mon, 16 May 2022 12:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kZrb/i8j6CVH55ieJCSHwM+DMDmM+6G3DX9M7d
        u3kSk=; b=fKBXy0VYme9LLpjY2t1S92gsZhd/CC0en6FgAZfYn98uVZie+z2ye+
        lYig56sSD+Rg2iBxXqY2grxf00RYIsSKe9XPSr47KSXJ6naVLd4uoYortbTAWwU+
        1IVC+87Wt80WueFoPhFZ9glwJH5trpUKJSV5g41cHveCPRTnKdoz8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6013B18ECD7;
        Mon, 16 May 2022 12:43:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBF7418ECD2;
        Mon, 16 May 2022 12:43:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
        <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 09:43:29 -0700
In-Reply-To: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com> (Glen
        Choo via GitGitGadget's message of "Fri, 13 May 2022 23:37:36 +0000")
Message-ID: <xmqqtu9p2zta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57702DEC-D537-11EC-94E1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  t/t0034-discovery-bare.sh          | 69 +++++++++++++++++++++++

This number is already in use by an in-flight topic, if I am not
mistaken.  Please make it a habit to always check your topic works
well when merged to 'next' and to 'seen'.

Thanks.

