Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB0C1F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758464AbcIURhE (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:37:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55960 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758459AbcIURhD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:37:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50F0D3ED89;
        Wed, 21 Sep 2016 13:37:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EH1af99739+xJjre04mI6UZC03o=; b=QmBDE0
        MnfHUbNPn+fxysUDdMJWWypcRKgxK/mEPHQ4lWnqkJBaCBJBX1Tn058yfy6ug9FK
        HAASPN84cTd+D02kHyT0P3+NNiCNemD2BCY3mSlfGwDCqW6aTLFVuAp2m56A0Sc4
        ZCAFlrD6sdp8Im7YJdnw4ronBUZEVUu9acxPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=r+hqQrE5E3ji7qFQl89+EiYkcfpKh+EH
        35C5harpPn68t9jEpvpWkteT/n6JCqgRHG37sW3/yXf/OT31gtF6053y3bK7mLAo
        qln7Gfb3BXM/sYBdKLsvrkjROC21M/GXOyH5+MFNM7x6KIf2lUJnhCEpI0mVN2AG
        4fCXs2jfC2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B580A3ED87;
        Wed, 21 Sep 2016 13:37:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D1BA63ED85;
        Wed, 21 Sep 2016 13:36:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #05; Mon, 19)
References: <xmqqd1jzcvs5.fsf@gitster.mtv.corp.google.com>
        <20160921162628.GA27363@ikke.info>
Date:   Wed, 21 Sep 2016 10:36:57 -0700
In-Reply-To: <20160921162628.GA27363@ikke.info> (Kevin Daudt's message of
        "Wed, 21 Sep 2016 18:26:28 +0200")
Message-ID: <xmqq7fa59mti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0001D904-8022-11E6-9557-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Mon, Sep 19, 2016 at 04:30:34PM -0700, Junio C Hamano wrote:
>> 
>> * kd/mailinfo-quoted-string (2016-09-19) 2 commits
>>  - mailinfo: unescape quoted-pair in header fields
>>  - t5100-mailinfo: replace common path prefix with variable
>
> Is this good enough, or do you want me to look into the feedback from
> jeff?

If you are talking about the simplified loop that deliberately sets
a rule that is looser than RFC, yes, I'd like to see you at least
consider the pros and cons of his approach, which looked nicer to my
brief reading of it.

It is perfectly OK by me (it may not be so if you ask Peff) if you
decide that your version is better after doing so, though.

Thanks.
