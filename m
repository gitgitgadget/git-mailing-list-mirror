Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B891FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 16:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbcHZQ62 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 12:58:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57032 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754008AbcHZQ60 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 12:58:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D56A3707C;
        Fri, 26 Aug 2016 12:58:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CD4NtiwkYXBW+6t7/bd5vddhc2A=; b=X3iodN
        eoWiXnA+Jpb+2IVqNE32k8iqpYmA8LaSUIePLBH+AB8iNmAPfKLN5zSj2B+LC3Bx
        8FXn5OEoxLE2O91XUeceNxPDacNcGrLRg3PErKgHsmAwhpeoemSHu08hkmkCbgNs
        qXZP+ZooPEUh4XuL61ccDIy8TvEUHdoCqWoCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JIwOC60Ek9IL/IMFLmnHwQ82HC9TZINU
        4GQdZmrOIt7xsxLvz76X4t/J9raD7jelMgyBPAiY8DUGPAZrKHOV8oXBSOV+fd71
        TtfHwJiUUENfzwJttkvI8e2aUidVclgsKSZm+r/mmvE45DlD+Z7E+OoVfg2vhxgw
        /2SUxvZhCl0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DEBC3707B;
        Fri, 26 Aug 2016 12:58:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 85F9A3707A;
        Fri, 26 Aug 2016 12:58:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/15] sequencer: lib'ify read_populate_todo()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <0de75bbce8ade0c6e5cf87d3647faa71a89c6275.1471968378.git.johannes.schindelin@gmx.de>
        <xmqqeg5cjw02.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608261540470.4924@virtualbox>
Date:   Fri, 26 Aug 2016 09:58:22 -0700
In-Reply-To: <alpine.DEB.2.20.1608261540470.4924@virtualbox> (Johannes
        Schindelin's message of "Fri, 26 Aug 2016 15:45:07 +0200 (CEST)")
Message-ID: <xmqqmvjzii1d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D3B7898-6BAE-11E6-AB1D-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In short: I would really appreciate it if you could cut quoted text after
> your last response.

I think you are referring to the patch part in this case.

As I was not making point-by-point comments on the proposed commit
log message, quoting only that part and cutting the patch text would
have been pointless.  I could have cut the proposed log message and
left the patch in, though, because the comments were not about what
was in the proposed log message, but about what was not in it [*1*].

I left the patch part for other people's use, to make it easy for
them to see what I was saying was correct and appropriate for what
the patch does.  Removing that would not have made much sense.

But that is only true in this case.  I try to see if I can trim
quote more aggressively, but I would still err on the side of
over-quoting than under-quoting [*2*].


[Footnote]

*1* As to what was IN the proposed log message, I have one comment.
I do not think "To be truly useful" adds any value, as there is
nothing "truly" about what this series does.  The original was
"truly" useful for the purpose of the sequencer machinery and its
use in the current callers, just like with this series it becomes
"truly" useful for envisioned new callers that want to handle error
conditions themselves.  The change is making it "more useful" for
one different use case.  It may not be "truly" useful for other use
cases that sequencer machinery could be used even with the
"eradicate die and exit" change and other people may bring a new use
case that wants it to be even "more useful".  The fact that it may
not be directly usable by a new use case without further change does
not make the result of applying this proposed series less than
"truly useful".  The "truly" adjective implies absolute, but there
is nothing absolute in incremental improvements.  It is always
relative to the context within which the machinery was designed to
be used.  "To make it usable for callers that want to handle errors
themselves (instead of just dying and the calling process handle
it), let's turn die's and exit's to returning negative values." is
probably closer to what I would have expected.

*2* As I read the quoted part before sending my response out, erring
on the side not to underquote tends to avoid a mistake that invites:
"I think you misunderstood what I wrote in the part you snipped from
your quote; perhaps you skimmed it without fully reading."
