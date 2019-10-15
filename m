Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B791F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 02:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfJOCHO (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 22:07:14 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58456 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfJOCHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 22:07:14 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FC599E54C;
        Mon, 14 Oct 2019 22:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JK2frSjua8UA
        GlgAiFqNeHaBIXY=; b=kX2qh3PBOpHBvVBnLmC1q5bUskUMFjpoi6KOI3nWSFCt
        61zJ4vS2FCTdOYxivlw0+NbWOg1RALAaonx8tLSsaV+X+WSLbUiY7bJCaloXUa4X
        zB08WZkqL97XyyrtEQoi13nccV4Sgz7MApiICA6sxij3q/mqgJSJquq2DkFM7N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S/EYm5
        di+5MjvPI7xWjYn2uJdQ/5BRYNeycLOOi1MNoI9GSRyJX5BS0lzagXcQ34mlVIaQ
        zghc3nczIOi8Vuu4LVy/mv40eRJe7aHNOXLh1qMXfxtVnaQIDzM5A/N6GAhkxpDa
        mYBjxTyPkYKYweJ9GFfkmx1Wi6Spjk11EGVII=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 076A59E54B;
        Mon, 14 Oct 2019 22:07:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 374669E547;
        Mon, 14 Oct 2019 22:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Maxim Belsky via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Max Belsky <public.belsky@gmail.com>
Subject: Re: [PATCH v2 1/1] doc: Change zsh git completion file name
References: <pull.367.git.gitgitgadget@gmail.com>
        <pull.367.v2.git.gitgitgadget@gmail.com>
        <3f994f3b9a49c42bb8b605459817e54479327dc7.1570816467.git.gitgitgadget@gmail.com>
        <20191014234439.GT29845@szeder.dev>
Date:   Tue, 15 Oct 2019 11:07:08 +0900
In-Reply-To: <20191014234439.GT29845@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Tue, 15 Oct 2019 01:44:39 +0200")
Message-ID: <xmqqimoqdann.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7FA25B1C-EEF0-11E9-8883-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> -# The recommended way to install this script is to copy to '~/.zsh/_g=
it', and
>> -# then add the following to your ~/.zshrc file:
>> +# The recommended way to install this script is to make a copy of it =
in
>> +# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the fol=
lowing
>
> These updated instructions don't work for me, following them gives me
> zsh's git completion instead of ours:
> ...
> Instructing users to copy our completion script to
> '~/.zsh/git-completion.zsh' goes against this convention.
> More importantly, it appears that this is more than a mere convention,
> maybe a requirement even; at least renaming our zsh completion script
> to follow the convention (IOW following the current install
> instructions) makes it work all of a sudden:

Thanks for a dose of sanity.  My "Helped-by" was about phrasing and
had nothing with the name of the file, so it should be fixable
without invalidating it ;-)

> -# The recommended way to install this script is to copy to '~/.zsh/_gi=
t', and
> -# then add the following to your ~/.zshrc file:
> +# The recommended way to install this script is to make a copy of it i=
n
> +# ~/.zsh/ directory as ~/.zsh/git-completion.zsh and then add the foll=
owing

    # The recommended way to install this script is to make a copy of it =
in
    # '~/.zsh/' directory as '~/.zsh/_git' and then add the following

