Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1418D1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfJCWbO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:31:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59218 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbfJCWbO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:31:14 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00E6D8DBF7;
        Thu,  3 Oct 2019 18:31:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yp6MqFM0iQ5B3amPIsncbWMCCNE=; b=kUY83d
        cGijyiyGVtI4H7Q6n2EgdpPxagtcOYcf1004GGvgYu/ryq6ajlZ7nG5gmTPSGF7z
        ucpvOaXdUUycassKotRh+hjoQm+c1KiHbxu/EMhBik2TFpmDQ70kZpfZUOsNUBDb
        LXK08QYBr8ZWBBKkFL3wzloGckLhr3kdm/8QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BM+8CZ5CWUoy2m6Hej9OY1fhJ6FFN4GD
        jwiymWpyNJOCw/DgncRdFn+6kXuNTzuqr8S9X4Lx91wnkGfVPvSsOWUiIPwDuU/0
        aX//7KXXA5GZf9BEh7UtYGkucGBKphT/wp6rey/BAJwCccIVp3z2jVJSZ2EVIeyL
        hU+LIKLHa9M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDD858DBF6;
        Thu,  3 Oct 2019 18:31:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2052B8DBF5;
        Thu,  3 Oct 2019 18:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2019, #01; Thu, 3)
References: <xmqqsgoabes8.fsf@gitster-ct.c.googlers.com>
        <20191003182838.GA173211@google.com>
Date:   Fri, 04 Oct 2019 07:31:06 +0900
In-Reply-To: <20191003182838.GA173211@google.com> (Emily Shaffer's message of
        "Thu, 3 Oct 2019 11:28:38 -0700")
Message-ID: <xmqqbluxbgwl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F14926C-E62D-11E9-A301-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Thu, Oct 03, 2019 at 02:04:39PM +0900, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>> 
>> You can find the changes described here in the integration branches
>> of the repositories listed at
>> 
>>     http://git-blame.blogspot.com/p/git-public-repositories.html
>> 
>
> Hi Junio,
>
> How do you feel about
> https://public-inbox.org/git/20190930220355.108394-1-emilyshaffer@google.com/
> which fixes a user-facing SIGABRT during partial clone operations? It's
> reviewed by Peff and Christian.

Already picked up on the tip of cc/multi-promisor and pushed out, I
think, as part of yesterday's integration cycle.

Thanks for fixing.
