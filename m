Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 298371F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 22:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbfHOW32 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 18:29:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60609 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733079AbfHOW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 18:29:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 037FF160854;
        Thu, 15 Aug 2019 18:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ysmMmbaWyTURNkvgucVecYYOX+U=; b=USsfVL
        UR05edONxsrXQ2NeG9ZemtDvTCe+uU00f4rZ71A4Y7Z4YAKD1XMVzjWWJR/z7po+
        QCYF/X/AF1GNxFssQ3HevK82OxMMJvIQZssldQF9mwKsRpy1a2Juo6d7AfunLg71
        y06ZguVvjAfxhgTE/gE1UgvoT+vpRvZgj5U8U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mknp9LD0Ppqwt7E8SDMDNtxIe/wN3cGP
        b6qG+WK3Nd/hUK/C4Ar6rWfyI2H2OFFyhi1EJAdDofJgyJwlvxnVaibLCo6Xk6p8
        AwZwYDeYZk1zBC+TqEbKIQMx1MMWmltAzB9URk4kMVJt8Hv7q4omWyjWb0/85p9H
        b5vTIWoWjME=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED1AD160853;
        Thu, 15 Aug 2019 18:29:25 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5A94F160851;
        Thu, 15 Aug 2019 18:29:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
References: <20190815023418.33407-1-emilyshaffer@google.com>
        <xmqqzhka2tbv.fsf@gitster-ct.c.googlers.com>
        <20190815215225.GB208753@google.com>
Date:   Thu, 15 Aug 2019 15:29:24 -0700
In-Reply-To: <20190815215225.GB208753@google.com> (Emily Shaffer's message of
        "Thu, 15 Aug 2019 14:52:25 -0700")
Message-ID: <xmqq7e7e2hbv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22FDDF44-BFAC-11E9-8759-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> > +NOTE
>> > +----
>> > +Bug reports can be sent to git@vger.kernel.org.
>> 
>> I am not sure if this belongs here.
>
> Sure, I wasn't certain either. Would you rather I remove the "what to do
> with this bugreport" NOTE section entirely?

Not really.  You are invoking an editor to let the user edit the
pre-populated report, and I would imagine that a comment in that
file would be the best place to give instructions, not a manpage
for "git bugreport" command.

> So, what's your suggestion? Not to check the output at all? (This may
> actually be fine; it occurred to me while reading your review that if a
> user is filing a bug report about something, one of the diagnostic
> commands in bugreport might be what's broken for them. So perhaps it
> should be tolerant to missing information...)

Right.
