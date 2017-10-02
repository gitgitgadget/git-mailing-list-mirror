Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A7020A10
	for <e@80x24.org>; Mon,  2 Oct 2017 01:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751720AbdJBBft (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 21:35:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50996 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751613AbdJBBfs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 21:35:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6CC0B6CF1;
        Sun,  1 Oct 2017 21:35:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NWUNl1c9No7YjvSff0Db4ZjAI1I=; b=Knm7YW
        3WhCZYN1RT12VAXikbBATOSAlb3f/2jm6O3sWCIfTtT9NfW+WgPC7YxMGodXneQ1
        xZd+4yI3zNHsAB5CrjfflxtPt1QZwRMAfPNEm7KZXsgLv7rALqWH6c98G7dlWUho
        52MCxIQJ9Zr9ZvLahLCAjf1gjbq/KyA8cxRE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h+0/CxhUyr2+/Hcmtclw3v7l8sqsCbda
        PMKFVv1myMKKsMiSMVBxrEZEyAcYO0OirkqddvmuuvZBCw6n4mjEh/V88eCawsqP
        Fd24VWxR+ASaISz1iogDhasNToz59XxtR25WVo/8h54n56tvGS59Pzjc+ERA1/rJ
        T+wjT5vr8BM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2941B6CF0;
        Sun,  1 Oct 2017 21:35:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B0D1B6CEF;
        Sun,  1 Oct 2017 21:35:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 4/6] doc: use modern "`"-style code fencing
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
        <20171001161852.84571-1-me@ttaylorr.com>
        <20171001161852.84571-4-me@ttaylorr.com>
        <xmqqlgkutoc6.fsf@gitster.mtv.corp.google.com>
        <20171002000630.GA63556@D-10-157-251-166.dhcp4.washington.edu>
Date:   Mon, 02 Oct 2017 10:35:45 +0900
In-Reply-To: <20171002000630.GA63556@D-10-157-251-166.dhcp4.washington.edu>
        (Taylor Blau's message of "Sun, 1 Oct 2017 17:06:30 -0700")
Message-ID: <xmqqtvziqqku.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03C4AF86-A712-11E7-9C71-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> Is this just me who wants to do s/fenc/quot/g?  Unless somebody
>> objects, I'd do so while queuing.
>
> I don't object, I think that fencing is less appropriate than quoting.
> I couldn't find the term myself when writing this commit :-).
>
> I am happy to send out v5 of this patch series with this commit
> re-written, or you can change it while queuing. Whichever is easier for
> you.

Just FYI, here is what I ended up with.  I do not think this is
about "modern" vs "old style"; it is more about using the more
appropriate mark-up and our desire has always been to use `literal`
for things that users need to type literally.

I notice that I didn't remove 'modern' from the title in the versoin
below, though.

Thanks.

commit a184d836bcf1a557520095a90b22edf659ee88f2
Author: Taylor Blau <me@ttaylorr.com>
Date:   Sun Oct 1 09:18:50 2017 -0700

    doc: use modern "`<literal>`"-style quoting for literal strings
    
    "'<string>'"-style quoting is not appropriate when quoting literal
    strings in the "Documentation/" subtree.
    
    In preparation for adding additional information to this section of
    git-for-each-ref(1)'s documentation, update them to use "`<literal>`"
    instead.
    
    Signed-off-by: Taylor Blau <me@ttaylorr.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
