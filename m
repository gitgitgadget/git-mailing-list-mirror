Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BEDC2018E
	for <e@80x24.org>; Tue, 30 Aug 2016 18:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbcH3SRx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 14:17:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59940 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752339AbcH3SRw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 14:17:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15F9C3ADDA;
        Tue, 30 Aug 2016 14:17:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l8gA/J64cPTM8IAPYLg8N5nF74w=; b=WqkZgV
        SMbEnlEQG3CZZBN85dCVvSw+LMDTpGQ8mKrL3Yv25pOP8eH/fpkGrzEbS1PYE3Dg
        aMPKQ2K7lM+SV1xBY+RQD2fl9fam+ZglAMohps/Jg20Y84RWyBtXrsW1py9xnQOy
        b8R08dPjsvbwXujWeg5eyl6SCbxFqDlHCkC1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cdw7m6Ml35Hb9KqKJgZSXldkRai8O30H
        rpU6FYMy9fdKdkwBlSUqCYWzHF7JeW8U83uDGZFnUzIGsTNwKeTAECxMNUahuXf7
        AIYNzWTlvAp554vE9EscPhbuTPnbThwtC6Dw3RytorEHHi8K3g2moN9ZHEFwh5kg
        24W2n/VVd4o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E8C63ADD9;
        Tue, 30 Aug 2016 14:17:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85ACF3ADD8;
        Tue, 30 Aug 2016 14:17:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joe Perches <joe@perches.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: git am and duplicate signatures
References: <1472573556.5512.93.camel@perches.com>
        <xmqqwpiy5haf.fsf@gitster.mtv.corp.google.com>
        <1472577999.5512.107.camel@perches.com>
        <xmqq8tve5fet.fsf@gitster.mtv.corp.google.com>
        <1472578879.5512.111.camel@perches.com>
        <1472579363.5512.113.camel@perches.com>
Date:   Tue, 30 Aug 2016 11:17:48 -0700
In-Reply-To: <1472579363.5512.113.camel@perches.com> (Joe Perches's message of
        "Tue, 30 Aug 2016 10:49:23 -0700")
Message-ID: <xmqqshtm3yur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FA4238A-6EDE-11E6-9DC3-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Tue, 2016-08-30 at 10:41 -0700, Joe Perches wrote:
>> Maybe something like traces or chains.
>
> Or "taggers" or "tagged-bys"

I am afraid that you are way too late; the ship has already sailed a
few years ago, if not earlier, I think.

