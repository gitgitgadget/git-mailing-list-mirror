Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682FE1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 03:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfHFDdz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 23:33:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63548 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfHFDdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 23:33:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 510EB8F48A;
        Mon,  5 Aug 2019 23:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zjV08XggR5YbC2CyAUUvqrCqdPI=; b=Qa6qn9
        JMHvzxqe/xVuOtmJoQdi10JLbKYEBJYFMrQ4qrB7WKmTi7Lr+B3ocfViYKb19Aj+
        aT0FrOQA4LmvejVOmeTOhKlRUyEXSd9EDfPCb1JUzIBZ4Z6xBtOo7XdmRYOWYPBs
        3uEwCX2OM+dT2xPIrOY59k6QhDq0G5V3KXHmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yH9p1yDMdsAKaycobbnXQoBKcGURvlKd
        H2PjtEJ8HH13xvg89GIKUONy5noB/1kQAyCQ1ebgStCYuCql2M9dJVDDut1Zyz5g
        tSLVXQqe3SgPLChUyfYqAsnw0ghkr01h+HteWl1taggxrPrtjc1H1ZrLDPzSbcqi
        HgSa6gKPnhY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 498828F489;
        Mon,  5 Aug 2019 23:33:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A9C08F488;
        Mon,  5 Aug 2019 23:33:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: RFC - Git Developer Blog
References: <20190806014935.GA26909@google.com>
Date:   Mon, 05 Aug 2019 20:33:47 -0700
In-Reply-To: <20190806014935.GA26909@google.com> (Emily Shaffer's message of
        "Mon, 5 Aug 2019 18:49:35 -0700")
Message-ID: <xmqqlfw7klwk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00EFC538-B7FB-11E9-A681-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> In backchannels recently there has been some discussion about the idea
> of a Git-project-blessed blog written by Git contributors, generally
> covering usability tips or overviews of the internals of Git which the
> general public tend to find confusing.
> ...
> The idea is that we could cover high level topics stringing together
> multiple components or giving power user advice, which we can't really
> do with the manpages.
>
> Thoughts?

Interesting.

I recall that I used to do the "Fun with ..." series back when I was
more into use-case-exploration mode; writing those articles was fun,
but it took a lot of time and quite an effort, so I stopped after
writing enough.  

Making it a group effort may help by allowing writers and reviewers
to encourage each other.
