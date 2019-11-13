Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381CC1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 03:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfKMDmf (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 22:42:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53561 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMDmf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 22:42:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46B09A49B1;
        Tue, 12 Nov 2019 22:42:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nEbtuJShNNLuvX9YQQeTTLkE7B0=; b=vl72DG
        7KqaHhtb29NGS7jGaUGNScJs6LWK8MrIxppQaLQRwK1J1z0EUNY8rMSEYATpMXpU
        pw4LKAuSJvH9kmrzQ5Z585NMmbMtJlH4WkAH962Xf3UWWZi6Z4XFEu1R+0W88fnV
        /05oHnxioEKZ5CDYVvm8u0hK7CQQ2fLCL81ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HwnZnfVkZf8kd1wqePwr3U98FfJ2pmPX
        wWneFOm+1FLm9JpyDscsKkkRaZjmgy2517hLBOlzx4fdLJTHRzRfAZnnAtlr4CjD
        mBv6SPwvQheRd5wEYH0VqfCQiTgCim2Fuz5YxKaLu7boifOgoG2GNvRAloAORMGF
        IL+bJGbT8KY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F095A49B0;
        Tue, 12 Nov 2019 22:42:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CD02A49A7;
        Tue, 12 Nov 2019 22:42:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Force.Charlie" <force@forcemz.net>
Cc:     "git" <git@vger.kernel.org>
Subject: Re: Protocol v2: The wrong --shallow-since time format causes git to wait indefinitely
References: <tencent_AB1A7466D1F2EF9A84B437705F06A7652709@qq.com>
Date:   Wed, 13 Nov 2019 12:42:28 +0900
In-Reply-To: <tencent_AB1A7466D1F2EF9A84B437705F06A7652709@qq.com> (Force
        Charlie's message of "Wed, 13 Nov 2019 09:00:52 +0800")
Message-ID: <xmqqpnhwbfx7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E886F4C-05C7-11EA-84D2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Force.Charlie" <force@forcemz.net> writes:

> # time format wrong
> git -c protocol.version=2 clone https://github.com/git/git.git --shallow-since=20151012

That's the valid/right way to specify the timestamp that is
20,151,012 seconds after the epoch (i.e. 1970-01-01), isn't it?



