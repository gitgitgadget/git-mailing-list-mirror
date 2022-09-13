Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE38C54EE9
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 20:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIMUrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Sep 2022 16:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIMUrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2022 16:47:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236F6D101
        for <git@vger.kernel.org>; Tue, 13 Sep 2022 13:47:00 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B51841A8768;
        Tue, 13 Sep 2022 16:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N5nWnLALEvK7ekntF9Xj0GpghYyFnFsl5Buc51
        tiHIg=; b=Mk5KivIZ5agj3f4I711lY7oo7I08LKs84RBTdNY62BiTVzjg6UKjNS
        o9JFepN3SoYRmbcNmTgeDLQnfh2M2r2tPU/Hn/N+2Il8SwSq5xrcA2EUQN5thKw5
        G0BiBMWmRiKlC7ZZKN7MuuVntIWIMdXIL7z9SJTzQ+C/jZKy1T/sg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE6271A8767;
        Tue, 13 Sep 2022 16:46:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A6D61A8766;
        Tue, 13 Sep 2022 16:46:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] chainlint: colorize problem annotations and test
 delimiters
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com>
        <pull.1324.v2.git.git.1663041707260.gitgitgadget@gmail.com>
        <YyDqycOlUYJO3332@coredump.intra.peff.net>
Date:   Tue, 13 Sep 2022 13:46:55 -0700
In-Reply-To: <YyDqycOlUYJO3332@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 13 Sep 2022 16:40:41 -0400")
Message-ID: <xmqqfsgv80jk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 349FDE3A-33A5-11ED-9BD3-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 13, 2022 at 04:01:47AM +0000, Eric Sunshine via GitGitGadget wrote:
>
>>     Reverse video certainly makes the "?!FOO?!" annotations pop out and draw
>>     the reader's attention. I find that I don't have a strong preference
>>     between this version and v1 which merely used bold-red, but I suspect
>>     that v2 with its reverse video is probably the better approach.
>
> I find this one slightly uglier, but they are equally
> attention-grabbing. And as I hope to rarely see them in the first place,
> I am fine either way. :)

Yup, I tend to think that reverse red is uglier and is more
attention grabbing than bold red.  Let's stop here for now and let
others paint it in other colors by introducing configuration knob or
whatnot but outside the topic.

> Thanks again for adding this.

That too.
