Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9FE81F954
	for <e@80x24.org>; Sun, 19 Aug 2018 04:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbeHSHKt (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 03:10:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56702 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeHSHKt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 03:10:49 -0400
Received: from pb-smtp20.pobox.com (unknown [10.110.30.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPS id 075C8110639;
        Sun, 19 Aug 2018 00:00:41 -0400 (EDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 774461A3E6;
        Sun, 19 Aug 2018 00:00:40 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Hx8GYt6EhkHHisq0OA2g0UX8lY=; b=KOKsHx
        GqWHI1/UTOiI1fNad4ZSRJMZAEXZIwHMcOiofxglWwbKkp1R09Y1IHSINX2jgiRD
        7RKNFEEER6+M/qXOZTHoCLd9kTxTRTjKq3AezUz6hTA1RamcgRuI7JFcK8DwPN8e
        lx9lzNfymYQDkqHWZ/dr0G56FZ8jf5EL7vxOI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 705C41A3E5;
        Sun, 19 Aug 2018 00:00:40 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type; s=mesmtp; bh=qzjU+NVq3bSxLvCoTqWdeL8i9sEWayuRrjqZZoblUUk=; b=vGuURahamQemepFuc/V9rmaabxP/aF9q119CLeRSh7oxnYevYH3FmIwCQIEnAsfsiGjvgo6XVbhY5P+azIrr2K5VDZBx+D2v/vEN75CcGCl6JfNC/rreXdgafAm6b8jj19/2xYY4sZBmUYtwbPHo1k2v2ErVZqcbaC4olZwA3lE=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CA0651A3E2;
        Sun, 19 Aug 2018 00:00:37 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael =?utf-8?Q?Mur=C3=A9?= <batolettre@gmail.com>,
        git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: git-bug: Distributed bug tracker embedded in git
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
        <xmqq6007abmu.fsf@gitster-ct.c.googlers.com>
        <20180819012748.GA175033@aiede.svl.corp.google.com>
Date:   Sun, 19 Aug 2018 00:00:35 -0400
In-Reply-To: <20180819012748.GA175033@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Sat, 18 Aug 2018 18:27:48 -0700")
Message-ID: <87y3d3m2e4.fsf@kyleam.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E5C7424-A364-11E8-9F28-F5C31241B9FE-24757444!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc Stefan Monnier]

Jonathan Nieder <jrnieder@gmail.com> writes:

> (cc-ing Scott)

[...]

> I believe you're thinking of TicGit[1].
>
> Some other related work is listed at [2].  Most of these projects have
> gone quiet:
>
> - ditz[3]
> - git-issues[4]
> - cil[5]
> - Bugs Everywhere[6]
> - milli by Steve Kemp, which I haven't found a copy of
> - simple defects[7]
> - kipling[8]

To add to that list: There's also BuGit [1,2], though it too seems to
have gone quiet.

[1]: https://gitlab.com/monnier/bugit
[2]: https://public-inbox.org/git/jwva8psr6vr.fsf-monnier+gmane.comp.version-control.git@gnu.org/


-- 
Kyle
