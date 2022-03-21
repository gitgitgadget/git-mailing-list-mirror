Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266ECC433F5
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 16:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351425AbiCUQwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 12:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351460AbiCUQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 12:52:49 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4A01728AE
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 09:51:24 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D68C6110F20;
        Mon, 21 Mar 2022 12:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=udftDAB+wKEd
        fwPKeRFitG7hxzd1bw6T3uJ108motV4=; b=jwFHvmzuhQEsaHtLskz1Wbt6o59M
        dOSaM9SotEIrP3O77TxArCbrIKgMGGXqYNCqcuPhrY/U6m0RM7GK3cUB8AX0AOjx
        dLU9WOXh9U3cF+3olxN2vuTHqXF11KK3zmn0SgJgHI87KZaIDU3PUoj3p30DxWZf
        wiY7HH03/XNm2Y4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE373110F1F;
        Mon, 21 Mar 2022 12:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39344110F1E;
        Mon, 21 Mar 2022 12:51:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2022, #04; Thu, 17)
References: <CAGTqyRzeYqXT_HXKZ794XmtD7HodvHEQeK3efUw=Pb0ObLvXPg@mail.gmail.com>
Date:   Mon, 21 Mar 2022 09:51:19 -0700
In-Reply-To: <CAGTqyRzeYqXT_HXKZ794XmtD7HodvHEQeK3efUw=Pb0ObLvXPg@mail.gmail.com>
        (Justin Donnelly's message of "Sat, 19 Mar 2022 14:08:37 -0400")
Message-ID: <xmqqy2131c6w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 22B934A8-A937-11EC-8432-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Justin Donnelly <justinrdonnelly@gmail.com> writes:

>>* jd/prompt-upstream-mark (2022-03-03) 4 commits
>> - git-prompt: put upstream comments together
>> - git-prompt: make long upstream state indicator consistent
>> - git-prompt: make upstream state indicator location consistent
>> - git-prompt: rename `upstream` to `upstream_type`
>>
>> Tweaks in the command line prompt (in contrib/) code around its
>> GIT_PS1_SHOWUPSTREAM feature.
>>
>> What's the status of this one?
>> source: <pull.1162.v2.git.1645991832.gitgitgadget@gmail.com>
>
> I'm the author of these patches. I'm not too familiar with the
> workflow and I just want to make sure this question isn't directed at
> me and you don't need anything from me right now. =C3=86var provided
> initial feedback and FWIW I think these are ready to be merged.

I am asking both people who use "git prompt" (they would hopefully
care, as new breakages would inconvenience them) if they mind this
series to appear in future releases in "Git" in its current form,
and who wrote the series (that's you) how ready the series is.

Thanks for giving one of the two halves I wanted ;-)

