Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B33BEE57DF
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 06:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjIKGJo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjIKGJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 02:09:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD511F
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 23:09:35 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EF581BD766;
        Mon, 11 Sep 2023 02:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Ssu7gJWcJ5UH3qLgOBLb5w4H6NQKqsq1GPFsRP
        kpt4s=; b=kZz4LoQqySQXGpD7eJraAqCQlWPq/wv3gX0zKyoUFIQ2xTseDgt4Q/
        8OXA0yky4RKaWk4P4imb8CDCclEFJsSom+qQgM1/aSI1QTbbU1X8SXzU9Ny4YrPA
        kQs/SYK8pud6POywBL5LJmWIjTskqhmQXE5rh4TlyKHr4+OnyMHFs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66FE61BD765;
        Mon, 11 Sep 2023 02:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEC901BD764;
        Mon, 11 Sep 2023 02:09:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] completion(switch/checkout): treat --track and -t the same
In-Reply-To: <4f7d166c-040e-eb7c-ef27-81f9748d44a0@gmx.de> (Johannes
        Schindelin's message of "Sun, 10 Sep 2023 10:22:27 +0200 (CEST)")
References: <pull.1584.git.1694176123471.gitgitgadget@gmail.com>
        <xmqq1qf8vf1e.fsf@gitster.g> <ZPtISYVufU0MazO_@pobox.com>
        <4f7d166c-040e-eb7c-ef27-81f9748d44a0@gmx.de>
Date:   Sun, 10 Sep 2023 23:09:32 -0700
Message-ID: <xmqq34zljl5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C72FD458-5069-11EE-B22B-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Thanks for catching this. It is a debugging left-over, when I wanted to
> make sure that the `-t` validation I added would run immediately.
>
> I see that Junio helpfully dropped it before merging down to `next`, so I
> will refrain from sending a v2.

Yup.  Thanks, all.
