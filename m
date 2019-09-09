Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8F91F463
	for <e@80x24.org>; Mon,  9 Sep 2019 19:24:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbfIITYu (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 15:24:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57223 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfIITYu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 15:24:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5AF9B2ABE2;
        Mon,  9 Sep 2019 15:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=axl7Yk8ubMHXMTN+ghUcxbDWpY4=; b=hvYkym
        obQrpltM5/TKfDE7SksffzrHq4DAZ6IY1GZzjFPYvTWw2kieqSA8IaUs+CbxiR65
        9E1c5fpF2g6n6tzdqCvhMQfbmWUvEBD2xDu82OsX5os9f4uD9Nj3gD6Dsiw1UBgH
        kTziBG2tY+Nlf6m40H0sWNXaiAnFQWmiRI1UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eJzETfjvib4ficTVbbI/0HBkixVgFUNU
        hGBv8QUa3+LCgNjh2PRp+niZwCN34sX0KWtc7btn8Kw2Kcw8JwZObWs6837kWePZ
        b6dfgY1D2wZ3CUCtRP8puvT+jRVerXYxV/LTrQQ0tLJwxKLJlttKxraWXYZy4D0F
        VIYbJGnAwPs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D4CD2ABE1;
        Mon,  9 Sep 2019 15:24:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CEB62ABE0;
        Mon,  9 Sep 2019 15:24:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v4 0/6] rebase -i: support more options
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190907115034.14933-1-rohit.ashiwal265@gmail.com>
        <xmqq8sqxl557.fsf@gitster-ct.c.googlers.com>
        <d16a2c76-32c0-1080-a2de-00803ff84962@gmail.com>
Date:   Mon, 09 Sep 2019 12:24:46 -0700
In-Reply-To: <d16a2c76-32c0-1080-a2de-00803ff84962@gmail.com> (Phillip Wood's
        message of "Mon, 9 Sep 2019 19:51:22 +0100")
Message-ID: <xmqq1rwpjmrl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C5D2650-D337-11E9-B598-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Yes I had assumed that the cherry pick would become the first patch of
> this series and be dropped from pw/rebase-i-show-HEAD-to-reword.

Ah, such an arrangement would have made a log more sense, indeed.

> As pw/rebase-i-show-HEAD-to-reword is slated for next perhaps these
> could build on that. The first patch needs am -3 to apply to that
> branch but the result looks ok and the rest apply as is.

As this is more or less "new feature" series, I do not mind too much
to make it depend on another topic in flight that is getting solid.

Thanks for helping.
