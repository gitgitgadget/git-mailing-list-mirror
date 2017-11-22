Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52AFC2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 05:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdKVFyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 00:54:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55050 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751240AbdKVFyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 00:54:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D566B2B7C;
        Wed, 22 Nov 2017 00:53:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aQeva4F7usF1kAhIkS8bk5ZFfm4=; b=vrfHav
        XGSQWASY4G91ZoHMZjK15MR93W5468Rz/Uw5BN/cURwAEXuIxchHo3DJRCwQ7NB2
        TJXkcxTcDFVR2ybzNmzhwIoUZlo3syoobeIkvlow+g+a6k7PhzuKzEy0prN2OR1I
        mdAHqgAaFJnm8AN/B7axBkKveaCKzqhIrFdM4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fent7DsKFX/UqeJVXufmAUYPBoeSa4ga
        otGketQrn6MFPZc11a68gNYR5YUp8cS6KX3BjgGjeLEbay9yH2kKZ1y57HQGQksn
        O5ngTQ4MSzwvlBhKWF5c88AYcutYUJMgA24Dikbpb5jIM4nNEL4uiaiwq7q2zRmm
        6Bj9I4IMKMU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86618B2B7B;
        Wed, 22 Nov 2017 00:53:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0129DB2B7A;
        Wed, 22 Nov 2017 00:53:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Ann T Ropea" <bedhanger@gmx.de>,
        "Git Mailing List" <git@vger.kernel.org>,
        "Daniel Barkalow" <barkalow@iabervon.org>
Subject: Re: [PATCH v3 5/5] Testing: provide tests requiring them with ellipses after SHA-1 values
References: <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
Date:   Wed, 22 Nov 2017 14:53:57 +0900
In-Reply-To: <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> (Philip Oakley's
        message of "Mon, 20 Nov 2017 12:25:34 -0000")
Message-ID: <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88A59A1C-CF49-11E7-B0A7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> Ann T Ropea <bedhanger@gmx.de> writes:
>>
>>> *1* We are being overly generous in t4013-diff-various.sh because we do
>>> not want to destroy/take apart the here-document.  Given that all this a
>>> temporary measure, we should get away with it.
>
> So, the need to reformat the test for the future post-deprecation
> period is being deferred to the time that the PRINT_SHA1_ELLIPSIS env
> variable, and all ellipis, is removed - is that the case? Maybe it
> just needs saying plainly.

And if we say it that way, it is clear that with this series, we are
shipping a new feature with a test that does not protect the output
format we claim to be the improved and preferred one.  That sounds
quite bad.

Having said that, I have already queued this to 'pu' and I do not
terribly mind to merge it down to 'next', leaving the test updates
to cover the new output format as well as the backward compatible
one at the same time for a later follow-up patch.  

I'd however hate it if I have to carry the topic in the current
shape in 'next' forever, waiting for such an update to come, that
may never materialize, and be forced to do it myself without being
explicitly asked by (and thanked for) anybody, especially because
this is not exactly my itch X-<.

> Or is the env variable being retained as a fallback 'forever'? I'm
> half guessing that it may tend toward the latter as it's an easier
> backward compatibility decision.

We do not know until this change is released to the wild, at which
time we will hear noises about the lack of expected ellipses their
(poorly written) scripts rely on and tell them to set the workaround
environment variable.  We may not hear from such people at all, in
which case we may be able to remove it within a year or so, but it
is too early to tell.
