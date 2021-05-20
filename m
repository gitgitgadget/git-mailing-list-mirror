Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B81C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5DC613AD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 22:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhETWpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 18:45:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56297 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhETWpT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 18:45:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DCC413B1D3;
        Thu, 20 May 2021 18:43:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u9C26er9/D3B+0C5dDeM1H2Q3/J7fs5koQ2LTi
        E0Z+c=; b=BYOLVfSRtbY+QURYrlVPXZvU7a+4cNxzza7YpkFoZhxkYzg54kxtoH
        ZDjxNVHWBtmy1sB/g4lc0sorX2QVpIEyHT6bLNWIsILMWoT4x1oAEj6vAumQ+GQZ
        WwyzDxIUuXbNICnFWFKnTHRlPRoj9XY++Elkb0Qa1QMQC28Z51zz0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 26E9613B1D2;
        Thu, 20 May 2021 18:43:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D6D313B1D1;
        Thu, 20 May 2021 18:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2021, #03; Thu, 20)
References: <xmqqtumyulv8.fsf@gitster.g>
        <CABPp-BGmGbX6bz6mQPgqdo4KPdtEb2u6UMznCEedUf_iA0KVrw@mail.gmail.com>
Date:   Fri, 21 May 2021 07:43:52 +0900
In-Reply-To: <CABPp-BGmGbX6bz6mQPgqdo4KPdtEb2u6UMznCEedUf_iA0KVrw@mail.gmail.com>
        (Elijah Newren's message of "Thu, 20 May 2021 01:18:12 -0700")
Message-ID: <xmqqfsyht49j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB072986-B9BC-11EB-A92A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, May 19, 2021 at 8:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> [Graduated to 'master']
> ...
>
>> * en/dir-traversal (2021-05-13) 9 commits
>>   (merged to 'next' on 2021-05-14 at 316f9264c1)
>>  + dir: introduce readdir_skip_dot_and_dotdot() helper
>>  + dir: update stale description of treat_directory()
>>  ...
>
> Did you change your mind since
> https://lore.kernel.org/git/xmqqtumzzedd.fsf@gitster.g/, or did you
> just accidentally merge all 9 patches instead of only the first 7?

My mistake.

> Sorry about this, I was going to resend corrected versions of the last
> two patches...but I'm guessing that's just not warranted anymore?

Then let me take them; I'll revert those last two in preparation.

Thanks.
