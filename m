Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C511F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 02:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbfJYCvX (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 22:51:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57661 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732696AbfJYCvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 22:51:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1A9528804;
        Thu, 24 Oct 2019 22:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ob+CVxYNeUdl1uob49QjO/y77ZQ=; b=IcDZWn
        UQLezKd9z/6siMlQsDH+oan4dsLYu3+PTXQ1J7XaDKBc/bS8+ZU3o1rHvE8rXh9O
        vtygmwm0egmAtUj9N7j5fATUMbiWBw90lxMVKZx8FCfUtlfQH0/pY9zwzGHcy4dB
        b/qL15bU+UjSveU1Cfj85RE2vrf2c/9kARkLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ne1SHJCfF0T86Ya/OUfDs/H2Ik72k6mF
        6dRNjOJjaX3ROmNPgRIJ7UgjrMVGCUFSVzvV5vxBvo+60FTBWJOMgOCWSX4fIRKh
        /vTYhP/QAwIkv7TnGYoZDiTGYnwOA5hxoE6KpzhFJLRfyzRa6L01hRjWsLFQP+LN
        adcN1CrEsHo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E97F228803;
        Thu, 24 Oct 2019 22:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FB9728802;
        Thu, 24 Oct 2019 22:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2019, #06; Thu, 24)
References: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
        <20191024230902.qdy3fv3dh5lvrcz3@camp.crustytoothpaste.net>
Date:   Fri, 25 Oct 2019 11:51:18 +0900
In-Reply-To: <20191024230902.qdy3fv3dh5lvrcz3@camp.crustytoothpaste.net>
        (brian m. carlson's message of "Thu, 24 Oct 2019 23:09:03 +0000")
Message-ID: <xmqqimodedw9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52B6D5A8-F6D2-11E9-A9CF-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2019-10-24 at 06:01:08, Junio C Hamano wrote:
>> * bc/hash-independent-tests-part-6 (2019-10-06) 15 commits
>>  ...
>>  May be rerolled.
>>  cf. <20191008194012.4s35pbwbh25rblhb@camp.crustytoothpaste.net>
>
> I will indeed reroll this, and I hope to have a new version out soon.
>
> A reroll will also be coming for the documentation series I was working
> on.

Thanks.
