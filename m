Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0A9C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1E761289
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhEFVPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:15:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62743 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhEFVPt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:15:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6945127CA0;
        Thu,  6 May 2021 17:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/2s7FiVNsk8/
        s5NECTGZ+czruM8u/iTkjQq1CfAjRqY=; b=ntbNsn3neaSrkVDF17yxVm+qiYbB
        MeS9BryKhNz/MqZuzhwnFxwqHwrunZnRJmO2imxx4EC65oKA6ZSBnVdxw1AGAlBh
        aCUfaijUVcNeByy4T1hzJiolpxB9u7OVYFCE/gSFjeuED1PryMAe/NcQfzNh7ohu
        YwWWvB2WelVx6Fg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9ED0E127C9F;
        Thu,  6 May 2021 17:14:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7692C127C67;
        Thu,  6 May 2021 17:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] add: die if both --dry-run and --interactive are given
References: <20210505145204.51614-1-oystwa@gmail.com>
        <20210506141011.18245-1-oystwa@gmail.com>
Date:   Fri, 07 May 2021 06:14:45 +0900
In-Reply-To: <20210506141011.18245-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Thu, 6 May 2021 16:10:11 +0200")
Message-ID: <xmqqczu3y37e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1635AB80-AEB0-11EB-BEB9-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=98ystein Walle <oystwa@gmail.com> writes:

> Hi, Junio and thanks for accepting the patch.
>
>> The interactive machinery does not obey --dry-run. Die appropriate if
>> both flags are passed.
>
> I just noticed a minor spelling error here: "appropriate" should be
> "appropriately". I can send a v2 if that's easier for you.

Thanks, will locally amend---no need to resend.

Thanks for contributing.
