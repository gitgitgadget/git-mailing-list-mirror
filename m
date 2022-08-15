Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E11C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 16:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiHOQIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiHOQIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 12:08:22 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D561A82F
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 09:08:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BEFD151D0E;
        Mon, 15 Aug 2022 12:08:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=24U8xPXXy/XbEXECIZPUkDQnsn3mdCLvNoVLlX
        mzECg=; b=Tq55XcK0qu3+dlVXFUVYHnPCvfQjFwXCkW3sZ/FiiX6N4yuF3Uvjft
        HxT+ugk1n59wJFWc9aky6Qcmn1JdKVRz0syHgxpl0SRgoTIF0XoUG47XieIjQ0Wp
        h3I8Y2TBHHuwqM3VCAF6yyjI1ch0b7MrsVtcLT8/JWtRN1RJH3jLU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41D7D151D0D;
        Mon, 15 Aug 2022 12:08:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94B83151D0C;
        Mon, 15 Aug 2022 12:08:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Victoria Dye <vdye@github.com>, git-for-windows@googlegroups.com,
        git@vger.kernel.org
Subject: Re: fixup! bug, was Re: [ANNOUNCE] Git for Windows 2.37.2
References: <20220811214252.4351-1-johannes.schindelin@gmx.de>
        <0e859fe2-3f23-4526-083c-082adb0028fc@github.com>
        <xmqqwnbdct1m.fsf@gitster.g>
        <16r2s842-1r7r-p05n-82o5-q01921r35oqr@tzk.qr>
Date:   Mon, 15 Aug 2022 09:08:18 -0700
In-Reply-To: <16r2s842-1r7r-p05n-82o5-q01921r35oqr@tzk.qr> (Johannes
        Schindelin's message of "Mon, 15 Aug 2022 13:30:20 +0200 (CEST)")
Message-ID: <xmqq35dx4hhp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AAE5990-1CB4-11ED-AC64-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 12 Aug 2022, Junio C Hamano wrote:
>
>> Victoria Dye <vdye@github.com> writes:
>>
>> > Johannes Schindelin wrote:
>> > Just a heads-up: there was an issue with the process used to generate this
>> > version. ...
>>
>> Sorry to see that it caused two cycles of release process.  Would it
>> have helped you if I had done things differently (other than "not
>> issuing maintenance releases that are not security relevant"), perhaps
>> giving a notice in advance by say a few days?
>
> Thank you for offering to accommodate Git for Windows' needs.
>
> In this instance, we tracked the problem down to ...

Well, I was not asking for postmortem of a particular breakage,
per-se.  Such a bug is well within the competent hands of GfW
developer(s).

I was more interested in learning an improved process, e.g. giving
you an advance notice of a few days so that you can do a practice
run in the not-so-final-but-close-enough tip of the 'maint' branch
to find out unexpected recent breakage either in the code or in your
toolchain before the real release needs to be made in timely
fashion, would have helped.

Thanks.
