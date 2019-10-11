Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C772F1F4C1
	for <e@80x24.org>; Fri, 11 Oct 2019 23:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfJKXw0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 19:52:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56834 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJKXw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 19:52:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EDE42D2D9;
        Fri, 11 Oct 2019 19:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xBSwmkKq9cBe39uybPm7ImN8Ol0=; b=NXoe2U
        TS7KMPiQoHGFHAeBtjhXx+lt77MyI3MQpHRsaF8sXL0TGlmdbWGdSNBDCSrTI1wQ
        +BXFCFVzs6d3xer6xfsX0Pj1XsV+AsfXIGtH13AmyNv6O3Zh4K4DjsYGDAUhADEU
        vy41herjXnkz9TMaiKnbUuoLgEg3ruDL+2AbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fn+PAp9aU6RGa04U1d8xcVNdMVJj1TC4
        7Xe7CBjSSokTeFQuQr+jtg82t36UDZg2svI1VTFS0sBks74BvQZA/RdCLDKF0k5e
        xw0XXivmrWQK19kLMV9gMSi5ToXm8NIUBTTfmF+Gtgyb7wt17JiWctf2+DMrvw9k
        YUxt+/Wskxw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 671C42D2D8;
        Fri, 11 Oct 2019 19:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7AE52D2D7;
        Fri, 11 Oct 2019 19:52:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2019, #03; Fri, 11)
References: <xmqq8sprhgzc.fsf@gitster-ct.c.googlers.com>
        <CABPp-BE4f5f3HyZu9wOyq599JN-n0EMF08di+2V51uxDMEwuGQ@mail.gmail.com>
        <xmqq4l0fgroj.fsf@gitster-ct.c.googlers.com>
        <CABPp-BF346QbjCyWP7HSP9Lh7mDRgtwtPC8b4mqNv4znUHoGFw@mail.gmail.com>
Importance: high
Date:   Sat, 12 Oct 2019 08:52:22 +0900
In-Reply-To: <CABPp-BF346QbjCyWP7HSP9Lh7mDRgtwtPC8b4mqNv4znUHoGFw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 11 Oct 2019 13:39:32 -0700")
Message-ID: <xmqqwodag7rd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BE24C6E-EC82-11E9-B64C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Did I shoot myself in the foot by being quick to jump on Rene's couple
> of cosmetic touch-up suggestions he posted over a week after the
> series was originally posted?

If the suggested updates were simple enough to do and would improve
the result sufficiently (which is probably true in this case), it is
possible that the topic would have been marked "Expecting a reroll"
and stayed out of 'next' longer.  Or I may have missed the suggested
updates before merging the known-incomplete series to 'next', and
the topic may have got marked "Expecting a follow-up" and stayed in
that state until the update happened.  Or I may have simply missed
the suggestion and allowed you to successfully game the system.  So
you have 2/3 chance of delaying the topic's graduation by doing so
;-).

But over time in the longer run, those contributors who prioritize
quality over haste are rewarded with more trust (which results in
shorter gestation period for their topics in both 'pu' and 'next'),
while those contributors with tendency to sneakily gaming the system
eventually get caught and their contribution has to be looked at with
finer toothed comb than usual, making more work on everybody and
delaying the whole thing, including but not limited to their topics.

At least, that is how the system hopefully works.

By the way, I think I made a mistake in my calendar math.

This topic was merged to 'next' on the 7th and it is not especially
tricky; unless I (or somebody else) find glaring issues in it during
the final sanity check before merging it to 'master' during the next
batch, it would take the normal course to 'master' before the 18th,
on which the rc0 is planned.
