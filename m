Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266711F45F
	for <e@80x24.org>; Tue,  7 May 2019 14:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEGOC2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 10:02:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62270 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEGOC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 10:02:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D278F148EED;
        Tue,  7 May 2019 10:02:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=noU3Q2lWGY+yzj//XrjyGUCTjyA=; b=kLpm9k
        hiCukPWzc2JFdBKrhCo+f2IXHMI9TKZHlcPgsJrWV31siZVLjr5hFTaNAivbGanW
        Yh2RbSq5VzALd1+KhW7xbEHr2qRCRQQ5rN9tHgz2zfKQzJLOOgKSCXqwkB+qjVqe
        ctmCXvysfWqaME6iDwXZtHs9R6zu8ttTd9Qxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HNOXYvPvvvJQqAKhWEUvxLkQfURX32gT
        tnTWxNUhj3dtUTYGMGb+FUAvK/Obg2J9523BPQ32bMSEf1DcFpQ4fVzjazpaFQS5
        d50Ls6Ccj5EdMeTa1XmGZHgyhYjxSWEUsf0relw6NMmbiR12h6IkIMsF/U0w2d5x
        AZLuFS9gndw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C93C9148EEB;
        Tue,  7 May 2019 10:02:25 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F37FF148EEA;
        Tue,  7 May 2019 10:02:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dustin Spicuzza <dustin@virtualroadside.com>
Cc:     Dustin Spicuzza via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] cvsexportcommit: force crlf translation
References: <pull.132.git.gitgitgadget@gmail.com>
        <9b508af11be125ce5fd80c40c732dbcaf45067fb.1556575126.git.gitgitgadget@gmail.com>
        <xmqqtve6lito.fsf@gitster-ct.c.googlers.com>
        <4da677fb-47c3-a1ac-e7e0-6b74cdb7334c@virtualroadside.com>
Date:   Tue, 07 May 2019 23:02:23 +0900
In-Reply-To: <4da677fb-47c3-a1ac-e7e0-6b74cdb7334c@virtualroadside.com>
        (Dustin Spicuzza's message of "Tue, 7 May 2019 09:51:55 -0400")
Message-ID: <xmqqd0kul5w0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDBA4B56-70D0-11E9-B5B6-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dustin Spicuzza <dustin@virtualroadside.com> writes:

> Yes, your interpretation is exactly correct, even the interpretation of
> the uncertainty of the message.
>
> I didn't send the patch to this list though, not sure why gitgitgadget
> decided to do so (I've never heard of it before now). The patch was
> originally submitted to git for windows (PR #938), with an even worse
> commit message. :)

The credit goes to Dscho, making effort to slim down patches Git for
Windows carries on top of my tree by upstreaming them.
