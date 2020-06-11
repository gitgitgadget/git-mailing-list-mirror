Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4DC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F94206C3
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E80pTuKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgFKPZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:25:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55638 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:25:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD5255DA51;
        Thu, 11 Jun 2020 11:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WLkD8lXk57g4CijSm0c733zg9NY=; b=E80pTu
        KrcDrD56ED66hImftnzQu4zR5JEARd7UcfPvziW15Nl7HpkyNM8ygecv1lWI8BJg
        8HewRhyc8TPe0LEeXmI0IFT/gjbM8fzZYpdHSCL+mwwsEGG9hokikrUJ/ko64HQT
        yjDZLA9wX8cF/a/tq1e9fTAfO4REBHh/B16PE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hPrHLPXN26RBhID834tqKmiFgYeWpSYo
        GZvXuTOp0rnL7ov9qMOHjj0Ky11hf2JAWUWr3KPSY8lPjtEHYbGgLeAwSk3tQGVV
        p3lKE7RN8oPbKNwgEqi0wafsTc3PC6R3lNx/hDc4eynARYdDtPQbz0vI6TR/oOum
        JKDfcIB9C0I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B29695DA50;
        Thu, 11 Jun 2020 11:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 156605DA4C;
        Thu, 11 Jun 2020 11:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        git@vger.kernel.org
Subject: Re: Virtual Inclusion Summit
References: <20200610222719.GE148632@google.com>
        <xmqqwo4eedwc.fsf@gitster.c.googlers.com>
        <20200611011040.GB21728@syl.local>
        <xmqq7dwecpsp.fsf@gitster.c.googlers.com>
        <20200611023503.GA24130@syl.local>
Date:   Thu, 11 Jun 2020 08:25:30 -0700
In-Reply-To: <20200611023503.GA24130@syl.local> (Taylor Blau's message of
        "Wed, 10 Jun 2020 20:35:03 -0600")
Message-ID: <xmqqh7vhbp5h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C951A5FA-ABF7-11EA-982F-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jun 10, 2020 at 07:13:58PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>> >> It is OK to have an optional meeting in the hope that a video
>> >> meeting may have a better chance to keep those who easily become too
>> >> aggressive and confrontational in text-only conversation in check
>> >> and instead have civilized conversation.
>> ...
>> What I am hesitant to see is that such an opt-in meeting becomes
>> "you got a chance to attend and have your voice heard---if you
>> didn't come, that was your choice, and whatever objection you give
>> after it does not count" summit.
>
> Ah, thanks for your clarification (and sorry for the misunderstanding).
> I figure that any synchronous discussion should augment the on-list
> discussion, not replace it.

By the way, if I sounded like I consider this "virtual summit" to be
no more than just a place for people with heated head to deflate
before having a civilized conversation, that was not my intention.

I do agree that it is good to have some gathering (or perhaps a
couple of them in shifting time to accomodate people from different
parts of the world) to help make sure everybody is moving towards
the same goal, and I have nothing against a virtual/video meeting
for that purpose.

Other than that it may be held on Zoom, where I do not particularly
like to send people to, after seeing articles like [*1*], that is,
but there may not be a viable alternative.  I dunno.


[Reference]

*1* https://www.ft.com/content/f24bc9c6-ed95-4b31-a011-9e3fcd9cf006
