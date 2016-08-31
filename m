Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4721F859
	for <e@80x24.org>; Wed, 31 Aug 2016 16:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935535AbcHaQp3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 12:45:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55095 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935621AbcHaQp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 12:45:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C6F139B1C;
        Wed, 31 Aug 2016 12:45:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FiJT58GdDSj5Yu4++LU4difqLCk=; b=FiJuLQ
        kDU8LvjOroYLDaFQgaQMT+Qykm1QVbhQLbFTOwq1ReDwNYCWQjhNGalu+aSoulft
        lq0PzQwjmgs6AbjIpIHML0jqYcidyhzcf9rLfa4menq9hd9Ru3uo0FP19o1catQn
        gbd8jXdx63z6WXjQs2UZHfUj2pd5TyCkEW8hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nL9d5ofOP2pFHlL2vSF6j0B+H14qhi0x
        BE+1SyJaLDmflP2Y+pLNWcWj0Aa2trbqIyvfiVnIKOB8XQhMed7ywyKTaA5OVXIl
        +KT4Y/BxNwOPP0h8ABwAbt114YR3JtM8xIShhd1DSPOVkVEm098eGNpM9pELEhjj
        BXjo502uZ6g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4456239B1B;
        Wed, 31 Aug 2016 12:45:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C17ED39B1A;
        Wed, 31 Aug 2016 12:45:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     jacob.keller@gmail.com, git@vger.kernel.org, j6t@kdbg.org,
        peff@peff.net, sbeller@google.com, stefanbeller@gmail.com
Subject: Re: [PATCH v11 0/8] submodule inline diff format
References: <CA+P7+xpvtdoeK3uiSGAeNzQaYQhS7p0WT+nCcfKAS7FauFNftQ@mail.gmail.com>
        <20160826231320.7038-1-jacob.e.keller@intel.com>
Date:   Wed, 31 Aug 2016 09:45:24 -0700
In-Reply-To: <20160826231320.7038-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Fri, 26 Aug 2016 16:13:20 -0700")
Message-ID: <xmqq37lk3n17.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51C1DD72-6F9A-11E6-A096-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

>> We probably should release for the error case. I'll do that. I don't
>> believe do_submodule_path ensures that the passed in argument is
>> guaranteed to not be initialized or used.
>> 
>> Thanks,
>> Jake
>
> Here's the squash for this fix.

It seems that the topic has been quiet since the message I am
responding to.  Have all the issues been resolved, or are there
still some loose ends to be hashed out?

Hoping that the answer is "the former", I'll mark this topic as
"Waiting for a reroll."

Thanks.
