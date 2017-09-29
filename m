Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2557B20A10
	for <e@80x24.org>; Fri, 29 Sep 2017 04:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750800AbdI2EHc (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 00:07:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56222 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750730AbdI2EHc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 00:07:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 987F2AF83D;
        Fri, 29 Sep 2017 00:07:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/aKcLoYd4HtnKf3iCKm8HT3eizI=; b=RhTFxK
        IpdWe4NuNAqYcqfYodLe1grCS3HWUenElky7HkD2IULSy/lPSAPJf+qZOKrxeHdD
        3Guf0TEcyWdldhH8oBphUPR9rJnh1SKvDiM0EWaXVyIvPtCXnsCREfedgrPLkgwr
        0LlfEFrySkOpSHmnZ1o5fp9LcqwlZbHPAlD20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PU88vq0k6Vkl/jBbSh5ZXh6CBBWASisU
        St5+jOEQpmkqsS46XdL6zyPizLDMgFu3dOSrqD7qWsGMt8SYzBrlQEe0Em6gscE7
        9kbo3z349p51MPMhziNP9TGazkUTl8pegSFrSSPgZK8IRN6ICvB5h/5xguupFbDt
        16Rg6oxmB+E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 91381AF83C;
        Fri, 29 Sep 2017 00:07:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D49EEAF83B;
        Fri, 29 Sep 2017 00:07:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
Subject: Re: [PATCH] doc: correct command formatting
References: <20170928140648.GC9439@dinwoodie.org>
        <70decbc2-093c-9f9a-3661-ee6500cec641@gmail.com>
        <20170928193412.GB174074@aiede.mtv.corp.google.com>
        <xmqqk20iz2w9.fsf@gitster.mtv.corp.google.com>
        <20170929032653.GA28303@aiede.mtv.corp.google.com>
Date:   Fri, 29 Sep 2017 13:07:29 +0900
In-Reply-To: <20170929032653.GA28303@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 28 Sep 2017 20:27:29 -0700")
Message-ID: <xmqqpoaaxi4e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6B6D810-A4CB-11E7-8672-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Separate from this example: yes, I think adopting Linux's Reviewed-by
> convention would be a good thing.  When I see a positive reply to a
> patch, I often wonder whether an ack or a fuller reviewed-by is
> intended, and Linux's way of formalizing that appeals to me.
>
> I'll try sending a patch to add it to SubmittingPatches tomorrow
> morning (Stefan had also been hinting recently about this being
> something worth trying).

Thanks.  

I agree with the goal of educating list participants not to throw
Reviewed-by: without reading the patches too carelessly.  As akpm
once said in <20121003143200.69a50aad.akpm@linux-foundation.org>,
"Looks ok to me from a quick look" is not a review.

    > > No, lib/lzo has no identifiable maintainer.  I suggest you proceed as
    > > follows:
    > > 
    > > - Post the entire patch series to lkml for review (I'd like a cc please)
    > 
    > Already happened, multiple people reviewed and tested.

    um, I would not consider "Looks ok to me from a quick look." and "I
    couldn't tell from the github view, but I assume you follow standard
    coding style." to indicate a rigorous code review!

    That's the problem with the git presentation: hardly anyone reads the
    patches and there is no patch for a reviewer to reply to.

    So please send the patches out for review.  One at a time, via email.
