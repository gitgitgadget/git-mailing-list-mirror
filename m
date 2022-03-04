Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1188C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbiCDAak (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiCDAaj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:30:39 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3488BE0E
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:29:53 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B24918D1BF;
        Thu,  3 Mar 2022 19:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BO+Q4/p7cZaYU4xE+EQozI6x4D8NPDjZfRl00l
        n1Hi8=; b=Sp2lGVkR9UNUcy9LZNN4+B/IPxaATNOA+9Y9WBgFf9i9NcBvUhko5s
        oISYT5yzNgRjppMPIurAxcGW2zIWH6cMFsmhxHl26dt35SJ6HoKGIM77GaGgszZx
        ULTvp834q3XYr8wMb0xvEzBVSoC2dKfg/Jeh2wVX4oHcagTF5xO3A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44CF918D1BE;
        Thu,  3 Mar 2022 19:29:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C2B1918D1BD;
        Thu,  3 Mar 2022 19:29:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] SubmittingPatches: explain why we care about log
 messages
References: <20220126234205.2923388-1-gitster@pobox.com>
        <20220127190259.2470753-4-gitster@pobox.com>
        <YiFY693P6E/eVS3k@google.com>
Date:   Thu, 03 Mar 2022 16:29:49 -0800
In-Reply-To: <YiFY693P6E/eVS3k@google.com> (Emily Shaffer's message of "Thu, 3
        Mar 2022 16:10:19 -0800")
Message-ID: <xmqqr17i5zlu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3443D608-9B52-11EC-8F43-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> +The goal of your log message is to convey the _why_ behind your
>> +change to help future developers.
>> +
>
> This is pretty compelling. Is it clear enough why we care about this in
> the commit message, as opposed to in the patch description (cover letter
> or post-"---" blurb)? Is it too obvious to explicitly mention that the
> commit message is the first thing we try to make sense of during a 'git
> blame' or 'git bisect'?

Having to say "this may be better in the in-code comment rather than
the log message" to some patch recently (I do not remember), I tend
to agree that some guidance would help people decide between the two
(or writing both).

Again, patches welcome ;-)

