Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E326C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 04:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiGUEpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 00:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGUEpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 00:45:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1A595AA
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 21:45:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 172D21A8585;
        Thu, 21 Jul 2022 00:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0sUaqWR12JTzG0XsYImlrLf+MwFtHowTWRi9v1
        CA5QU=; b=lEERJv5D/8/fMt8W8MvFxhUFWJOVb6yLti/CiR68Y7yw/Kmr09EJgR
        BO+TcZfRr2QhHWsdFdJVAUSLlzQUmUDHrNfoZDajm1BwnkkVpwvWHJ8tYvmosBFh
        2oCvAcX1z3Nb/8ChvYUphJeGn0lstYc1NBl3tYH/wSOXtomIQcSbM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 104801A8584;
        Thu, 21 Jul 2022 00:45:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5F2C1A8582;
        Thu, 21 Jul 2022 00:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] string_list: use the right kind of STRING_LIST_INIT
References: <xmqq7d471dns.fsf@gitster.g>
        <CABPp-BFUoufmoQx8Oq=3C1ct-7paBs1fqzi8b8jhOadrndGkkg@mail.gmail.com>
Date:   Wed, 20 Jul 2022 21:45:06 -0700
In-Reply-To: <CABPp-BFUoufmoQx8Oq=3C1ct-7paBs1fqzi8b8jhOadrndGkkg@mail.gmail.com>
        (Elijah Newren's message of "Wed, 20 Jul 2022 20:28:45 -0700")
Message-ID: <xmqqk087m5v1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E56A00CC-08AF-11ED-BF68-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Makes sense, but shouldn't the subject have s/string-list:/remote:/ ?

Oh, you are absolutely right.

I was influenced by 183113a5 (string_list: Add STRING_LIST_INIT
macro and make use of it., 2010-07-04), which I was staring at too
much while thinking that this fix was finishing up what it started.

Will amend.  Thanks.
