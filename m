Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 321961F463
	for <e@80x24.org>; Tue, 10 Sep 2019 00:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390523AbfIJATt (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 20:19:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65106 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732404AbfIJATt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 20:19:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EEAB32DC54;
        Mon,  9 Sep 2019 20:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wy6G6F0EHCYFk7qNBet4CEcSlZA=; b=EDUgM8
        8+WCaDNg1Sb2lcd3VtXgGHvwEcCDFnk6mOGHZMCKVz+9prP42xeeo6x7kAEPF7Ux
        3evXMpQ/LvzNTpqyDBZji65bdA06p2IyjT58mAcqCrfTaHxJMjmAlmeOEp7E1N1E
        9/R4h5yeHYyvG06q5FvWe3M2PxCDz4LAl2R4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lM7x3yBOXXj2L3TjACYvcEywPsgIn6UC
        b7O+DdeoWwq25v2NKPYyBGA4oFCTGxGP9jVV1/OSY9XjiFD9/qc5Eq7T4xl/CRQW
        pPUdh00r75Y+y/uw7OBdjzzO5VaMzlfWCY7D7csoVF8xh3J3pG5I3ts2UrLW/9Gf
        oRLBHRa7rec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E5D2DC53;
        Mon,  9 Sep 2019 20:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56FA82DC52;
        Mon,  9 Sep 2019 20:19:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
        <20190909234715.GO11334@genre.crustytoothpaste.net>
Date:   Mon, 09 Sep 2019 17:19:45 -0700
In-Reply-To: <20190909234715.GO11334@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 9 Sep 2019 23:47:16 +0000")
Message-ID: <xmqq1rwphuji.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1BC685A-D360-11E9-BA60-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2019-09-07 at 17:26:53, Junio C Hamano wrote:
>> * bc/object-id-part17 (2019-08-19) 26 commits
>>  - midx: switch to using the_hash_algo
>>  ...
>>  - builtin/replace: make hash size independent
>> 
>>  Preparation for SHA-256 upgrade continues.
>> 
>>  Looked mostly OK, with a possible update.
>>  cf. <20190820223606.GJ365197@genre.crustytoothpaste.net>
>
> Just to update on the status of this, I wasn't planning on a reroll,
> although I'm happy to do so if folks have feedback.  Opinions for or
> against the current state are welcome.

FWIW, I am quite pleased with these and deeply appreciate the work
you've been doing on this topic.

Thanks.
