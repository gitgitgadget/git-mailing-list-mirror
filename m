Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6885AC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 22:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiAQWXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 17:23:51 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63169 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiAQWXv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 17:23:51 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 437C8160783;
        Mon, 17 Jan 2022 17:23:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZHWs0ego4qszNC4nWGVfdwBuSPSxxBsgURR971
        pW5xs=; b=fb+iGA/LTF8JUBJXXcek4OGmQZt+EZv8LYG0e8PvhkPmKTB1XT/Few
        oywnXXxwfUWTGVbwPiMS/r2ne5OS42S021U0yExnLzbKUey5Yhe2t2myhgKG1RaU
        NpMSldRRt6T2Rc803+z+Gbq1UzMY2W6NnWZ9IGSAhyblICYmXpIT8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3AA38160782;
        Mon, 17 Jan 2022 17:23:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A4DE116077E;
        Mon, 17 Jan 2022 17:23:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2] merge-ort: avoid assuming all renames detected
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
        <pull.1194.v2.git.git.1642443955836.gitgitgadget@gmail.com>
        <xmqqh7a2uphk.fsf@gitster.g>
        <CABPp-BF+eUGJ7FgMRG9vOUh8X5ExU+jkR3WHZeFGnKH80SO7gQ@mail.gmail.com>
        <YeXotaZmqhkJaQr6@nand.local>
Date:   Mon, 17 Jan 2022 14:23:47 -0800
In-Reply-To: <YeXotaZmqhkJaQr6@nand.local> (Taylor Blau's message of "Mon, 17
        Jan 2022 17:07:49 -0500")
Message-ID: <xmqqy23et30s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 244CD4AC-77E4-11EC-9DAD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jan 17, 2022 at 01:21:11PM -0800, Elijah Newren wrote:
>> On Mon, Jan 17, 2022 at 11:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> > Thanks.  An Ack?
>>
>> Taylor told me the code change fixed his case, and that he'd review my
>> full patch with the testcase when I posted it.  Let's wait to hear
>> from him.
>
> Ack. I can't vouch for the ort-specific details, but I trust Elijah's
> judgement (obviously). Running a version of Git with this patch applied
> fixes the issue I originally reported.
>
> Thanks, Elijah!

Thanks.  Will queue with your Tested-by, then.

Thank you very much, both of you.
