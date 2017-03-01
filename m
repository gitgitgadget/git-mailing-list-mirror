Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2179E2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 18:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdCASn6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 13:43:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59845 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752143AbdCASn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 13:43:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72EA1761E0;
        Wed,  1 Mar 2017 13:42:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OT6cTXiL+uw1G0rxldGonkB+0EA=; b=O9WHpz
        BJqGIdl4Sl0hcocXpMysKc4U+bptvdM4Z01o+7j+ZvPaooDytytHaVLrsS/oxhP9
        e+IH2Xy8mQivL1/VhSYMuv7rRheETZfIRfTW8RH8oBIoQ2XIWXWgyrJIcXI6vfUc
        fkgOViHl5FxQDnmn3o7WrpzuT4CiSEFH3mJ64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M8P6VqxubUdrqnmvNqeKInfjfUsEyAL1
        ODesPkwWZ3oUPOVqU4wiXs76eSUWc+UbBn036XgBZQsLrd8YbPLfqCZ1bDCrzJ3A
        zNVdFPWcfa1SgY3Ob7gqCvRZTmWQQvJhFhpk2lFkT1zJxchI8ERuDtNCEk+6rahB
        iOZ+LWpiks8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 691AA761DF;
        Wed,  1 Mar 2017 13:42:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD25F761DE;
        Wed,  1 Mar 2017 13:42:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
Date:   Wed, 01 Mar 2017 10:42:55 -0800
In-Reply-To: <alpine.LFD.2.20.1702281621050.22202@i7.lan> (Linus Torvalds's
        message of "Tue, 28 Feb 2017 16:30:26 -0800 (PST)")
Message-ID: <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E30E573A-FEAE-11E6-8CDC-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I notice that sha1dc is in the 'pu' branch now, so let's put my money 
> where my mouth is, and send in the sha1dc diet patch.

I see //c99 comments and also T array[] = { [58] = val } both of
which I think we stay away from (and the former is from the initial
import), so some people on other platforms MAY have trouble with
this topic.

Let's see what happens by queuing it on 'pu' ;-)

Thanks.
