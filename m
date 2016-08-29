Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4B91FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 18:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbcH2SRY (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 14:17:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51890 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751983AbcH2SRX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 14:17:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 741683AEB8;
        Mon, 29 Aug 2016 14:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d4sDEDqeCFGgB6nxpPtZD7lCdms=; b=paLcwb
        ZIQXwprvW7pTSfviTk2rtpe4IKILxD5G+Nv/EFMRIjX+u2RNH6xm0V/qsBOVllSL
        LRVFSoyC8FZrD9NSLQViqh52Nqgtd6rsBHIIRmeHA7/FzjT3yAhswSqFLWdokC/b
        EsvxOayAL6xYBhKmXWJfh7HC5xblh7SgXWDgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fzLHVVjYOiUMWBvJT1eYW9XQChkdVHXL
        bO1BgjRuOIa9SHut610CI3NLiGnMFniXQ8XOPZ0G0zGETpqmSSSSAS4at4HLpBAb
        CoIsomwQiUoHEX47NdIGRIOzVO6XnVsqOAGWCqFJOMt76psTR0n4mELCDFPwJmwX
        A6VWiuww338=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B0DD3AEB7;
        Mon, 29 Aug 2016 14:17:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E39283AEB6;
        Mon, 29 Aug 2016 14:17:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Beat Bolli <dev+git@drbeat.li>, Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] gitk: align the commit summary format to the documentation
References: <1472230741-5161-1-git-send-email-dev+git@drbeat.li>
        <xmqqoa4fgzhv.fsf@gitster.mtv.corp.google.com>
        <a9731f60-5c30-0bc6-f73a-f7ffb7bd4231@kdbg.org>
Date:   Mon, 29 Aug 2016 11:17:19 -0700
In-Reply-To: <a9731f60-5c30-0bc6-f73a-f7ffb7bd4231@kdbg.org> (Johannes Sixt's
        message of "Sat, 27 Aug 2016 09:21:33 +0200")
Message-ID: <xmqqpoorbftc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D436158E-6E14-11E6-AE57-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 26.08.2016 um 20:24 schrieb Junio C Hamano:
>> Beat Bolli <dev+git@drbeat.li> writes:
>>> In 175d38c ("SubmittingPatches: document how to reference previous commits",
>>> 2016-07-28) the format for referring to older commits was specified.
>>
>> is easier to read when pasted into a sentence than what the recent
>> update 175d38ca ("SubmittingPatches: document how to reference
>> previous commits", 2016-07-28) suggests to do, i.e.
>
> While it may be easier to read due to the extra mark-up, the resulting
> text where such a quotation appears does not flow well, IMO. A commit
> message text that references another commit reads more fluently
> without the quotes around the summary line because the quoted text is
> not so much a quotation that must be marked, but a parenthetical
> statement.
>
> I absolutely welcome the proposed change to gitk, because I always
> edit out the double-quotes.

I think that is highly subjective, and as you very well may know,
I've been referring to commits without double-quote pair, and have
an obvious bias for something I am used to ;-)

I do not see the "" as introducing a quotation.  I just view it as
very similar to the "" in the following sentence:

    The commit whose title is "foo bar" did not consider there is
    also need to consider baz.

The whole thing is inside () pair, so I agree that with or without
"" pair, it is possible to see where the title ends.  So I do not
have a strong opinion either way.

