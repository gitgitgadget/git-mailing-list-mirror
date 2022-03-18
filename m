Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71842C433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 16:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiCRQ5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbiCRQ5A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 12:57:00 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494462976D2
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:55:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ADEF110A45;
        Fri, 18 Mar 2022 12:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BynvpI+uIiCFZ/xl8pLDdGqBl8esizIAaeVwKD
        yqBvU=; b=q9XoZdGu6rD2pGzXtV+2ptkOawWkETJQf1Vqn60nuhQihEou8OF2xx
        8dnS9K7NpikaLtyGlxceCO+iE8BNgczFNVANdbdM0hjL3zF2ofWnTbDDVXyYSMKA
        ujd+LiFXwA8lntjUzWm3TQt31vTFcLKFyqJYyGJNYfoudi/3V3hk8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51BA3110A44;
        Fri, 18 Mar 2022 12:55:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3EDC110A42;
        Fri, 18 Mar 2022 12:55:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael McClimon <michael@mcclimon.org>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v5 0/2] rebase: update HEAD when is an oid
References: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
        <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com>
Date:   Fri, 18 Mar 2022 09:55:38 -0700
In-Reply-To: <pull.1226.v5.git.git.1647611643.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 18 Mar 2022 13:54:01 +0000")
Message-ID: <xmqq35jfb3p1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D90BA7E-A6DC-11EC-934E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fixes a bug [1] reported by Michael McClimon where rebase with oids will
> erroneously update the branch HEAD points to.

Looking good.  I am tempted to say that we should declare victory.

Thanks for working on this fix.

