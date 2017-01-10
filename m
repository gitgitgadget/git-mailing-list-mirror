Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48C520756
	for <e@80x24.org>; Tue, 10 Jan 2017 22:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbdAJWBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 17:01:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59425 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751911AbdAJWBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 17:01:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A9335FCCC;
        Tue, 10 Jan 2017 17:01:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5wcT8Kt6yd1k8aI2Fr7DBh4mAO4=; b=mawLYP
        YOaIqa4x65wFD9fJfssorOPK0jXe4p0dbQIEorv7TkvirOw4wO/PhnHredS3+bos
        tkoB5iKke8b/hDBcW/eMA5HA34tMKZ3frr6yjXheSwYJzroUeMYcgHPurHvum8D2
        DHcpIx24AT9LD/M8OCyRDm505PBijXWYQFIhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jnBu9xTwXzrDSsreD5BZaUv1x2DyTsu5
        qlQPUU+WkYN9xOm+AKiw5ZpsaUAVy92Bs8Cmc6KOAdApEWMhjMg2/q8QHBKbaE4M
        XvQGdLEWsaPC0kj6MBLMrsuBbRtnYoNNlmHcf40s7/b+kSP/Bm+k1/dzFgndeNr6
        wSVrGQ+g9OY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EE325FCCB;
        Tue, 10 Jan 2017 17:01:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6A905FCC8;
        Tue, 10 Jan 2017 17:01:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/4] t1000: modernize style
References: <20170110014542.19352-1-sbeller@google.com>
        <20170110014542.19352-3-sbeller@google.com>
        <xmqqr34ar6s1.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbm4GRwNe7J_KP_V3eP8ZyAMEhOy-HL_ytHGtPoe19NPg@mail.gmail.com>
Date:   Tue, 10 Jan 2017 14:01:27 -0800
In-Reply-To: <CAGZ79kbm4GRwNe7J_KP_V3eP8ZyAMEhOy-HL_ytHGtPoe19NPg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 10 Jan 2017 12:43:12 -0800")
Message-ID: <xmqqy3yipoaw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 569242EE-D780-11E6-824E-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jan 10, 2017 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> The preferred style in tests seems to be
>>
>> s/seems to be/is/;
>
> If this is the only nit, mind to fix up the commit message locally?

Certainly.  It wasn't even meant as a "nitpick".  I was just
confirming your observation.
