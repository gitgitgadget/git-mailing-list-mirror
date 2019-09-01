Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F281F461
	for <e@80x24.org>; Sun,  1 Sep 2019 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfIAQVu (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Sep 2019 12:21:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52323 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfIAQVu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Sep 2019 12:21:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 691EF68AA9;
        Sun,  1 Sep 2019 12:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oH3yqMh1KNuJq8LTp+MmnoxyGNY=; b=FiEPyQ
        0ylD4QcwbM6pfzN7tcQP56BNNcaSJGhrvwmETqrP7GulE/rAvC6P/QAFlIOW4Q+V
        YSjEZxvKk7eP5jsQ84paAcd5FFvCH/4nBgI9qltHBKGjpjGX7/phv4UxcJdtjZgS
        z1L+riz7ICrkBJHdwW/J88UcBXI7xwS9p5Yek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WwB+EhJXZoXXYTdvor3hGKJMPtUebSRe
        GyJd8PGkmdNpOullkV6vHjvi147r98iZxrpIN92Wh54MzQAcY2wIrLWUB1GBTGCj
        rog1U3f141rhloTBPsbqZpbltZHjLix3r6PpxBp3LwL8rGZ3fGN6zlBafVinAkvw
        n+XhaSFFWeg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60AD068AA7;
        Sun,  1 Sep 2019 12:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 842E168AA6;
        Sun,  1 Sep 2019 12:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-gui: Add hotkeys to set widget focus
References: <xmqqbmg13sxq.fsf@gitster-ct.c.googlers.com>
        <20190831122326.9071-1-birger.sp@gmail.com>
        <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com>
Date:   Sun, 01 Sep 2019 09:21:43 -0700
In-Reply-To: <20190901113218.3lfu4ifsxhzrsw4g@yadavpratyush.com> (Pratyush
        Yadav's message of "Sun, 1 Sep 2019 17:02:18 +0530")
Message-ID: <xmqqmufougvc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9754F80C-CCD4-11E9-BF03-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> ... I am acting as the interim maintainer of git-gui for now, 
> ...
> You can find my fork over at https://github.com/prati0100/git-gui.

I am aware of three topics (call-do-quit-before-exit, reload-config
and revert-hunks-lines) of your own, plus your 'master' over there.
I'd expect that you'd also queue others' topics in the repository as
you act as the (interim) maintainer, updating the changes as they
get reviews, and then eventually when a topic matures enough [*1*],
you'd merge it to your 'master' and tell me to pull from there.

	side note *1*.  Decidinging when a topic gets mature enough
	is at your discretion as a subsystem maintainer.  With your
	reputation on line, I think everybody on the list would
	trust that you'd make a good judgment ;-).

Thanks again for volunteering.
