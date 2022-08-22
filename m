Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF6BC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 16:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbiHVQVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVQVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 12:21:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268243F1E5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 09:21:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95FF61AB847;
        Mon, 22 Aug 2022 12:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0rV3YOtg6QRo
        MzM1ZkKyDGxRozSfOyn25nlxpv464s8=; b=eYIFmajh3aYRq0wCVn75T9ep3C2Q
        b+7YofRTpIoERSmRIzCXNz4zHn+vXcsWQnZsV8tgv4/S4SsjXGaLR/k+MlRuHIhY
        DDVmdAhGcpOuREyx66F6XHqBZrbLqcUNU4woa2NMA1OKkkE6TyQxjLzxU9nPPHol
        CovnZKVoAhjjVRE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D5E51AB845;
        Mon, 22 Aug 2022 12:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 325C81AB844;
        Mon, 22 Aug 2022 12:21:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org, meta@public-inbox.org
Subject: Re: `git patch-id --stable' vs quoted-printable
References: <20220822022503.M873583@dcvr> <xmqqczcsgbvn.fsf@gitster.g>
        <4e3edfa1-9c04-7a63-30ee-65fe6f2de62f@web.de>
Date:   Mon, 22 Aug 2022 09:21:04 -0700
In-Reply-To: <4e3edfa1-9c04-7a63-30ee-65fe6f2de62f@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 22 Aug 2022 17:58:36 +0200")
Message-ID: <xmqqmtbwdzbj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6BE71230-2236-11ED-A2D8-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 22.08.22 um 06:06 schrieb Junio C Hamano:
>> Ren=C3=A9, do you remember if you used diff.suppressBlankEmpty
>> configuration when generating the patch in question at:
>>
>>     https://public-inbox.org/git/6727daf1-f077-7319-187e-ab4e55de3b2d@=
web.de/raw
>>
>> by the way?
>
> I did not use that option.  Attached the copy from my Sent folder, whic=
h
> has spaces at the start of the blank lines in the config.txt hunk.

Hmph, so I cannot quite explain what removed the leading spaces from
the copy public-inbox archived.

Thanks.
