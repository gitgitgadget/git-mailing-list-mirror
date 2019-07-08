Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D89C31F461
	for <e@80x24.org>; Mon,  8 Jul 2019 22:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405415AbfGHWCN (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 18:02:13 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51228 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405412AbfGHWCN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 18:02:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C2397DD19;
        Mon,  8 Jul 2019 18:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9JkrmknvjeE+c6taavG9RlmBs80=; b=WoTadM
        sEM+I9wAjdaaNJO3NWLLju99eKXjvY/jFF+W80voBn1nZlPTFqDZmm5dFwXFSpyu
        EP6GEQA9AKrQ8g8dCkTHZ2A47LGygPRkHVCjL5wyN6JCQ2lk/VykR7pzxi5Wru/v
        JcUntuYTsZ1LZwSI43E/jU2U0Mx4ufVXZRTAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BcveIhdv5FjYL1rLNjRz+Mon2yrHLH58
        gLEdKJaXnd6kxM23pkvzWORNsSnCA1vBJCoRxp/UmHBydThmAocMmXV3plBESD0G
        Ob7gfrHjYKxUhWeT4a1B/CAbrlDD14chndg03IhlCchX+FN0u2H79zZylfq6r0dk
        YrSfEkkzQns=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 644DA7DD18;
        Mon,  8 Jul 2019 18:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DEF57DD14;
        Mon,  8 Jul 2019 18:02:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #01; Wed, 3)
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
        <9b0fa396-6aae-ff4b-afee-0310a4f601f9@gmail.com>
Date:   Mon, 08 Jul 2019 22:02:07 +0000
In-Reply-To: <9b0fa396-6aae-ff4b-afee-0310a4f601f9@gmail.com> (Phillip Wood's
        message of "Thu, 4 Jul 2019 10:56:21 +0100")
Message-ID: <xmqqzhlow5gg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0892B182-A1CC-11E9-807A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> * pw/rebase-progress-test-cleanup (2019-07-01) 1 commit
>>  - t3420: remove progress lines before comparing output
>>  (this branch uses sg/rebase-progress.)
>> 
>>  Test cleanup.
>> 
>>  Will merge to 'next'.
>
> I've just posted an update to this which avoids the repeated printf calls

Thanks.  Picked up the one from "Date: Thu Jul 4 02:47:02 2019 -0700".

