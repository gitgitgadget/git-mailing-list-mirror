Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8BCC433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 01:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbiEVBfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 21:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiEVBf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 21:35:29 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272629804
        for <git@vger.kernel.org>; Sat, 21 May 2022 18:35:27 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D182312F863;
        Sat, 21 May 2022 21:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IIFxmPvCaiPEkqlb5D37jNlU5GEdlTTGfOnwdH
        TmeuY=; b=KCn6SAFFJaSDawRWZuRsS5F/zCGK+Hv3Q7cRMzzQtlWXitjRcWLvvM
        8QC+AKFvaKCTDs+niYrn7CDkAY2woreA9rvmuKiyp8FIq9PSNBcqCxUsYktWAr1t
        gJsjXBfOez0PM9JeBxUWiZrh95n0k9Tt3HIiVQ9EpKYhF/8pmKf+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7AC612F861;
        Sat, 21 May 2022 21:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2971B12F860;
        Sat, 21 May 2022 21:35:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 0/5] Improve MyFirstContribution's GitGitGadget section
References: <pull.1226.v2.git.1652233654.gitgitgadget@gmail.com>
        <pull.1226.v3.git.1652399017.gitgitgadget@gmail.com>
        <xmqqpmk9kxa8.fsf@gitster.g>
        <f47761e0-bbaa-e4a5-b74e-e9c211bd8d85@gmail.com>
Date:   Sat, 21 May 2022 18:35:24 -0700
In-Reply-To: <f47761e0-bbaa-e4a5-b74e-e9c211bd8d85@gmail.com> (Philippe
        Blain's message of "Sat, 21 May 2022 12:17:12 -0400")
Message-ID: <xmqqy1yubb8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73F873CA-D96F-11EC-B7B9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>> Philippe Blain (5):
>>>   MyFirstContribution: add "Anatomy of a Patch Series" section
>>>   MyFirstContribution: add standalone section on cover letter
>>>   MyFirstContribution: reference "The cover letter" in "Preparing Email"
>>>   MyFirstContribution: reference "The cover letter" in GitGitGadget
>>>     section
>>>   MyFirstContribution: drop PR description for GGG single-patch
>>>     contributions
> I just realized that the additional/tweaked content that I added in v3 went into 2/5
> where as they should have gone into 1/5 (I'm talking about the changes 
> *before* the "The cover letter" heading in [1]). I slightly messed up my rebase
> it seems, I'm sorry... 
>
> Should I send a new version, or is it too late since it's now in 'next' ?

Thanks for letting me know, and sorry about the confusion.

Could you please send an incremental fix to be queued on top of
these 5 patches?

Thanks.
