Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD0C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8F5611AD
	for <git@archiver.kernel.org>; Wed, 19 May 2021 23:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhESXXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 19:23:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59680 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhESXXk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 19:23:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F078D224A;
        Wed, 19 May 2021 19:22:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3O/YLt7i62LsPorD1t2zOl8DfNsSLd2mVd+qJ+
        6KhUA=; b=EGXP1/gY4OM8oQ5kxfPtNkyuQYo3uRPfiVjDTMt1UrI0CN269REz5n
        SVgie2n/URzjaxMdzapXE3uY7SedYYNKYBR/wAb7jDNn73PHJUHDzYRanAyWhguk
        hKU/w12IDvZbMQP/QN8ahmXgAHfYImiRswrMbcB8f80ubk33yWekM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84297D2249;
        Wed, 19 May 2021 19:22:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C1D8D2248;
        Wed, 19 May 2021 19:22:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
        <YKViF9OVLeA95JPH@google.com>
Date:   Thu, 20 May 2021 08:22:18 +0900
In-Reply-To: <YKViF9OVLeA95JPH@google.com> (Jonathan Nieder's message of "Wed,
        19 May 2021 12:08:07 -0700")
Message-ID: <xmqqv97ewbpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E447494-B8F9-11EB-A5C1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> It looks like most of the Freenode admins have moved to
> https://libera.chat/, so that would be a close equivalent.  Another
> alternative is OFTC <https://www.oftc.net/>, which is used by
> irc.debian.org, for example.
>
> There are also other real-time chat programs such as Zulip (open
> source, used in Outreachy), Discord (used by LLVM), and Slack (used by
> Chromium); each has its benefits and flaws.

I usually refrain from suggesting us to side with anybody in a
confrontation that is outside our main mission, but I do not mind
supporting the folks who were at freenode to show appreciation for
the service they gave us so far, by moving to where they are now.

If all candidates offer similar level of stability and archival,
that is.

Thanks.
