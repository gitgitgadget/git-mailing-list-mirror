Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1D0C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FB661152
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbhD0HS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:18:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54250 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhD0HS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 03:18:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7024711EDCC;
        Tue, 27 Apr 2021 03:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uG4j8Ro4jemT65v3mjHs+0IMUG1+ya7X47zHEX
        G6y/g=; b=Ut/qiQffrsom4eTfdA04eUsSH2DxXCXx8khYWccOSYAHIBc7cktsCw
        EVx8hYX31bGu0AE4q3pNtsAuEZooa4dshIu3zlUcb/3YnjlXODHu/DuO+orWGcNY
        2TQBYchf3Ou3Bk4nqRMebR1QcVTuAvacoxlm2OmK4mE8u/+Tj/L+8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5B23811EDCB;
        Tue, 27 Apr 2021 03:17:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9036011EDC9;
        Tue, 27 Apr 2021 03:17:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Luke Shumaker <lukeshu@lukeshu.com>,
        Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 04/30] subtree: t7900: use consistent formatting
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
        <20210423194230.1388945-5-lukeshu@lukeshu.com>
        <CAPig+cT=jZdq=oDSHRF6DnvqZVo4OiPGy7x7AzTzdcy6RV76kw@mail.gmail.com>
Date:   Tue, 27 Apr 2021 16:17:38 +0900
In-Reply-To: <CAPig+cT=jZdq=oDSHRF6DnvqZVo4OiPGy7x7AzTzdcy6RV76kw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 23 Apr 2021 17:51:53 -0400")
Message-ID: <xmqqpmygdwml.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6EE26B4-A728-11EB-BCF2-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +check_equal () {
>>         test_debug 'echo'
>>         test_debug "echo \"check a:\" \"{$1}\""
>>         test_debug "echo \"      b:\" \"{$2}\""
>> -       if [ "$1" = "$2" ]; then
>> +       if [ "$1" = "$2" ]
>> +       then
>
> We prefer `test` over `[`, so it might make sense to update that, as
> well, along with these other style cleanups.

If I were working on this, I wouldn't bother.

As far as I am concerned, contrib/subtree has always been treated as
a borrowed code [*] that is written in a dialect of shell that is
different from what our scripts are written in, and there are too
many style differences (I wouldn't call them violations---nobody has
expected the code there to follow our style, or attempted to enforce
our style there) to bother coercing.

If Luke is volunteering to take over its maintainership, it would be
appreciated by its users.  It has been in the "abandonware" status
for too long.


[Footnote]

* ... as opposed to a properly maintained part of the git-core
  proper.
