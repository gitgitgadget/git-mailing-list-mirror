Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0754B20988
	for <e@80x24.org>; Tue, 18 Oct 2016 15:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030237AbcJRPyY (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 11:54:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56217 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936747AbcJRPxs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 11:53:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6FE1475BF;
        Tue, 18 Oct 2016 11:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=thEfnA7hibkzzLZOKkCYzhW47sk=; b=fNUEoo
        MCrIaNWRrjhyAXLu3NwMWcM3SKvEzd7khaqGl2KLPfKPIv2rubR2uXGIP2LEqWPo
        pC1WGC25PFAa2cuC+9GdesQjxGiFkgfr8rXPoo7sBMBlHWgHn8ydLEHBgqWxHimR
        XTOHE0EDIJ33hW0mN3ymYfVDUnVbzt+DNPmBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uv26wPQTSa6xFKX3ZVLqArWkmguHi5M4
        yVs9aDYNzGnaH4/au0pdEAUkfsKOUHBOq8WQ4vF8KeAknh7/ZpGndeoNC+x84fLI
        PZhFwdoJRn5/f0mnOxcA74I5zSAwlwmO7X1VDDhaWp7ox1/jZnBjCEGvcCSaSPMr
        kix1+2jh22g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF3EC475BE;
        Tue, 18 Oct 2016 11:53:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 30265475BD;
        Tue, 18 Oct 2016 11:53:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
        <20161018133518.hwbv3gbeddjjfvcz@LykOS.localdomain>
Date:   Tue, 18 Oct 2016 08:53:44 -0700
In-Reply-To: <20161018133518.hwbv3gbeddjjfvcz@LykOS.localdomain> (Santiago
        Torres's message of "Tue, 18 Oct 2016 09:35:18 -0400")
Message-ID: <xmqqtwc9r6uv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D736998-954B-11E6-B1BD-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

>> * st/verify-tag (2016-10-10) 7 commits
>>  - t/t7004-tag: Add --format specifier tests
>>  - t/t7030-verify-tag: Add --format specifier tests
>>  - builtin/tag: add --format argument for tag -v
>>  - builtin/verify-tag: add --format to verify-tag
>>  - tag: add format specifier to gpg_verify_tag
>>  - ref-filter: add function to print single ref_array_item
>>  - gpg-interface, tag: add GPG_VERIFY_QUIET flag
>> 
>>  "git tag" and "git verify-tag" learned to put GPG verification
>>  status in their "--format=<placeholders>" output format.
>> 
>>  Is this ready for 'next'?
>
> Hi, I saw this on the previous "what's cooking." Is there anything I
> need to do on my side to make sure this is ready for next?

Posting this exact message to the list would be an excellent way
;-).

Hopefully some competent reviewer comes and points me at a thread
where s/he says the series was already reviewed and in good shape
soonish, and your message may be a good trigger to make it happen.


