Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1E2C2BA15
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 17:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjIPRbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjIPRb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 13:31:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7E81BD
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 10:31:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 906321A3B12;
        Sat, 16 Sep 2023 13:31:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=hculFYozh36xX14JEqQubLrDTIitDzzLJ38T4T
        MHr+E=; b=gfRP03uQY5UOio2MpC4sKO8Ov46x1Nw3d1C2rzeU7iZRKcKBVN4UzP
        E1TBZ40ODZlj1AFKfYahdAeag/EtjCaXanmdmYT7gXhjB2KcxuVwkoSV5tYTZ2Q6
        EeHASWJRywBVdiXhZIw7LdvpOZo4+rMMoOCPluv66yoKLlwNkJ1Hc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 888D91A3B0F;
        Sat, 16 Sep 2023 13:31:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7A2D1A3B0E;
        Sat, 16 Sep 2023 13:31:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        me@yadavpratyush.com
Subject: Re: BUG: git-gui no longer executes hook scripts
In-Reply-To: <2ce41212-41e7-fe5f-cc9f-bcfaa2641e59@gmail.com> (Mark Levedahl's
        message of "Sat, 16 Sep 2023 10:49:12 -0400")
References: <bd510f6d-6613-413b-6d64-c3d2fd01d8a9@gmail.com>
        <xmqqa5tngynh.fsf@gitster.g> <xmqq5y4bgxy1.fsf@gitster.g>
        <454d8b7b-96df-ec8f-2285-e022de66c66c@gmail.com>
        <xmqqil8ad8un.fsf@gitster.g>
        <ffd5e1dc-bad7-2b1d-3344-76ffeb2858f5@gmail.com>
        <2ce41212-41e7-fe5f-cc9f-bcfaa2641e59@gmail.com>
Date:   Sat, 16 Sep 2023 10:31:20 -0700
Message-ID: <xmqqo7i2autz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA61CD0A-54B6-11EE-9A33-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> On 9/16/23 08:56, Mark Levedahl wrote:
>>
>>
>>
>> So, there is hope c:\foo will split into c: foo, or c:\ foo, but
>> testing on Windows is needed. Really need Dscho or someone else from
>> g4w to help out here.
>>
>>
> I did install git for windows into a bare VM, running tclsh.exe on that
>
>
> puts [file split {c:\foo}]
> c:/ foo

Great.  That is exactly what we want to see.  Thanks.
