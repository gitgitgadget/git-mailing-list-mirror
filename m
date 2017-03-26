Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7094220958
	for <e@80x24.org>; Sun, 26 Mar 2017 23:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbdCZXIx (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 19:08:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51643 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751633AbdCZXIv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 19:08:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 431E870A7C;
        Sun, 26 Mar 2017 19:02:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ImhQdjZKaEGtLjnGABWDfGSmCJ4=; b=Ag9UpS
        6qxzXNiIYfYR8qON64yVyhopV+sFBiVNuRM6D+l80QfRxAOYthvvuXNbMgjeDE6k
        j0WW9lvm3hw3gx+lVZ2lDBKaAJ9E337C6iN/D34oivWv+BT13bnf9Z7rLm/d4xzX
        MJeBE+/tcLtYa4WyKKsTwK3ieYFCsuz1Py2dg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hvO0cjker2aTL7h7Ipm3jzoapMRKzpva
        kArKeB+hivm2qTpg+y8bi6DjJ0MT54RjLcaVE9qT04y0vsMEC8dtK6zDyZgBBp+y
        BNErcLVots4hntcWlPQnnn6rv0mXoYgd6Zp3F4wwimzWDtW2Zyy0U4J4zy9WcuDu
        1ZOQtFLQwdA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3405A70A7A;
        Sun, 26 Mar 2017 19:02:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A35D870A77;
        Sun, 26 Mar 2017 19:02:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2017, #10; Fri, 24)
References: <xmqq4lyi74lw.fsf@gitster.mtv.corp.google.com>
        <20170324235357.GA26537@google.com>
Date:   Sun, 26 Mar 2017 16:02:27 -0700
In-Reply-To: <20170324235357.GA26537@google.com> (Brandon Williams's message
        of "Fri, 24 Mar 2017 16:53:57 -0700")
Message-ID: <xmqqo9wn4p6k.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48EAB0A8-1278-11E7-A8C0-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 03/24, Junio C Hamano wrote:
>> * bw/recurse-submodules-relative-fix (2017-03-17) 5 commits
>>  - ls-files: fix bug when recursing with relative pathspec
>>  - ls-files: fix typo in variable name
>>  - grep: fix bug when recursing with relative pathspec
>>  - setup: allow for prefix to be passed to git commands
>>  - grep: fix help text typo
>> 
>>  A few commands that recently learned the "--recurse-submodule"
>>  option misbehaved when started from a subdirectory of the
>>  superproject.
>
> Anything more you think needs to be done about this?  I noticed that
> Dscho's config series hit master so I could rebase against that (as
> there is a small conflict).  Aside from that it didn't seem like there
> were many complaints with the proposed fix.

I saw no particular issues myself.  Do others find this series good
(not just "meh--it is harmless" but I want to hear a positive "yes
these are good changes")?

