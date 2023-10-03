Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A54E8FDB8
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241135AbjJCVKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 17:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJCVKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 17:10:11 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718FEAB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 14:10:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E7462DDC4;
        Tue,  3 Oct 2023 17:10:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/QVbBf03BQlD
        zgodhW8adebxOBe+ABt3HLU5hi8Mo78=; b=iwiMUdUcW5ahMkXLhG+HLsDbo8P6
        +0XXagdZ45O5Xkzfty0ttq5tOGYP9LKdC39GxFvMCrUKgu4QGDtl7oJw5yT1weHc
        moxy420RhWwVuIjROazIw6QElr2O0EGyq08rRI9vPEzP6cPzvla7jQX7UwNU84RR
        GveT0rNW1MJqoQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 282D12DDC3;
        Tue,  3 Oct 2023 17:10:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00A842DDC2;
        Tue,  3 Oct 2023 17:10:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/5] Fix some typos, grammar or wording issues in the
 documentation
In-Reply-To: <20231003220951+0200.221551-stepnem@smrk.net> (=?utf-8?B?IsWg?=
 =?utf-8?B?dMSbcMOhbiBOxJttZWMiJ3M=?=
        message of "Tue, 03 Oct 2023 22:09:51 +0200")
References: <20231003082107.3002173-1-stepnem@smrk.net>
        <CAPig+cR2wgAsGCTphqHsf_pbM0q_xLcMx=acVD6MDKhpEt3HNA@mail.gmail.com>
        <20231003220951+0200.221551-stepnem@smrk.net>
Date:   Tue, 03 Oct 2023 14:10:02 -0700
Message-ID: <xmqqbkdfxvit.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 38C19164-6231-11EE-9965-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@smrk.net> writes:

> Come to think of it, 'doc: fix some typos, grammar and wording issues'
> might have made sense to begin with; I don't suppose C header comments
> are off-limits to doc:.

Yup, they do count as part of developer documentation.

>>> diff --git a/contrib/README b/contrib/README
>>> @@ -24,14 +24,14 @@ lesser degree various foreign SCM interfaces, so =
you know the
>>>  I expect that things that start their life in the contrib/ area
>>> -to graduate out of contrib/ once they mature, either by becoming
>>> +graduate out of contrib/ once they mature, either by becoming
>>
>> You probably want to add a comma after "area".
>
> That would read awkward to me.  How about going the other way,
>
>   I expect things that start their life in the contrib/ area
>   to graduate out of contrib/ once they mature
>
> instead?

That reads well.  I do not recall whom "I" in this sentence refers
to, but if this were me talking about my wish, then yes, I expect
them to graduate once they mature, and the ">>>" quoted change to
drop "to" does not sound grammatical.

Thanks for working on improving the documentation, thanks for
reviewing, and thanks for working well together.
