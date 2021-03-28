Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DFBC433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF33B6157F
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 18:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhC1SdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 14:33:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51526 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhC1Sco (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 14:32:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CD346BD027;
        Sun, 28 Mar 2021 14:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vaXSWudOzPfr99g83Mn5ZGPygVM=; b=dhX+ei
        S8gihNYphGcoxa/c8CdQLwJUuWAxZH/w79LMKbFqWsYzG2AxmhNHt6wDvJkyi6KL
        SGLlgFmK8Gi14Ku/JdsSlKvPIyhlwNENOoymW4ipA1hpesetci0hDakQs5WphGb7
        0GE0LeoSsj3+Geyyz1OkZZuEAALcWsM+ylCrI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XlsvV2CmGXew7mhuffK58+ZssKaZ2kiK
        VHZgD9+Z3z9WwCyz5nirK6lCmVGDe6uNuStzZSdNBiYZNunZAPlltaGg2Ts1efLY
        qgEpfK1td1LsuYcPegl6QbwdGfTmewgBSMQtsbJhgsqjjZy5TQGtp0PSAwOpgGsu
        dkXNRkhY1oQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4CCBBD026;
        Sun, 28 Mar 2021 14:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 56BAEBD025;
        Sun, 28 Mar 2021 14:32:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chinmoy via GitGitGadget <gitgitgadget@gmail.com>,
        Chinmoy <chinmoy12c@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Documentation: amended usages of various (sub)commands
References: <pull.920.git.1616913298624.gitgitgadget@gmail.com>
        <e85a653c-2650-313d-b5ca-5874559d9528@gmail.com>
        <de6d56b5-89e4-1e50-1011-0a9b9c46f4d9@gmail.com>
Date:   Sun, 28 Mar 2021 11:32:42 -0700
In-Reply-To: <de6d56b5-89e4-1e50-1011-0a9b9c46f4d9@gmail.com> (Bagas Sanjaya's
        message of "Sun, 28 Mar 2021 15:13:54 +0700")
Message-ID: <xmqq35wfm8mt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC109EA2-8FF3-11EB-A100-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>>> ...
>> Wait, I expected that this patch touches Documentation/* (as the title implied),
>> but it seems like the patch content is something else (not related).
>> Totally wrong patch submitted here.

Please learn to trim your quotes.

> Oops, I don't see that diff above. Sorry for that.
>
> What about this patch title below?:
>
> `Make (sub)command options conform to TD of option parsing`

"Make X conform" has low information contents (especially when
nobody knows what the TD is), because nobody would try to make the
code worse by making things nonconforming.

    Subject: [PATCH] column, range-diff: downcase option description

    It is customary not to begin the help text for each option given to
    the parse-options API with a capital letter.

    Downcase the first word of some option descriptions for "column"
    and "range-diff".

or something like that?

Even though the guideline for the documentation talks about two
things (i.e. not starting with capital and omitting full-stop at the
end), the help strings being touched by the patch only have problem
with the former, so quoting the guideline in full would not help
people understand what is changed and why.
