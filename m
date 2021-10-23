Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB735C433F5
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F63360F36
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 21:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJWVF5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 17:05:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64587 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhJWVF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 17:05:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4F77E95E6;
        Sat, 23 Oct 2021 17:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=barvtHiUcZvr/IAFUrZhiO63zx28jmYXUNGkwC
        3KkwQ=; b=Y0tnB7smKMF/mDzV5bZ8cmIkmZ1zEuV8xrUSn4nJIs9i5uXbcoVPdU
        3G9VAqnMDCYMpaozWeVtqBAxVm3adNh51aEnxix/JJYoIKdCP1KLW1E1e2lAUCFy
        kC8/5KX3ObXkAml/lhsXNAth4/xqGQGN0t5TfG6SyQdubr0tm5tN4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C36EE95E4;
        Sat, 23 Oct 2021 17:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1193CE95E3;
        Sat, 23 Oct 2021 17:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH] MyFirstContribution: teach to use "format-patch
 --base=auto"
References: <20211022064044.28761-1-bagasdotme@gmail.com>
        <CAPig+cSgEvxVBUhrVf9ceG5L1DU5qTbfOgo=wOsOja1X8y+pfg@mail.gmail.com>
Date:   Sat, 23 Oct 2021 14:03:35 -0700
In-Reply-To: <CAPig+cSgEvxVBUhrVf9ceG5L1DU5qTbfOgo=wOsOja1X8y+pfg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 22 Oct 2021 02:48:02 -0400")
Message-ID: <xmqqh7d7bgig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B03DF722-3444-11EC-9A07-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 22, 2021 at 2:43 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> From: Junio C Hamano <gitster@pobox.com>
>>
>> Let's encourage first-time contributors to tell us what commit they
>> based their work with the format-patch invocation. As the example
>> already forks from origin/master and branch.autosetupmerge by
>> default records the upstream when the psuh branch was created, we
>> can use --base=auto for this.  Also, mention to the readers that the
>> range of commits can simply be given with `@{u}` if they are on the
>> `psuh` branch already.
>>
>> As we are getting one more option on the command line, and spending
>> one paragraph each to explain them, let's reformat that part of the
>> description as a bulletted list.
>
> s/bulletted/bulleted/

Thanks; will fix locally.
