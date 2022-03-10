Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A4C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241004AbiCJS4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiCJS4s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:56:48 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FE619D75E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:55:47 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF3361820AC;
        Thu, 10 Mar 2022 13:55:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AZUo8fPmo8Sm
        RDsOclkaefv/AdyZfKpCN8O7lgaKkXg=; b=BqR6oxtNaOGNh8uis0dmLcG9REZQ
        Kx9yREmZbL0gi2mA4c6OGeI8C21EkrNJxtj6Yxt2CWpBvq/jstkIZEvWvOEFwihs
        AFqjbPe7JGlGaiPsuwczlstYCfNVtLRd8CzNWZb0FohnYHfTeo/UOmeWOEXpNEwL
        SsQ3HkDbnTZdbe0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B86111820AB;
        Thu, 10 Mar 2022 13:55:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 48F871820AA;
        Thu, 10 Mar 2022 13:55:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] trace2 docs: a couple of grammar fixes
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
        <07f7ee46232b4ccc53787fa2e08887b436ee11c3.1646919331.git.gitgitgadget@gmail.com>
        <220310.86ilslkh6n.gmgdl@evledraar.gmail.com>
Date:   Thu, 10 Mar 2022 10:55:43 -0800
In-Reply-To: <220310.86ilslkh6n.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 10 Mar 2022 15:35:43 +0100")
Message-ID: <xmqqk0d1eixc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B08302B0-A0A3-11EC-AE14-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Mar 10 2022, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  Documentation/technical/api-trace2.txt | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/te=
chnical/api-trace2.txt
>> index bb13ca3db8b..77216eff622 100644
>> --- a/Documentation/technical/api-trace2.txt
>> +++ b/Documentation/technical/api-trace2.txt
>> @@ -24,7 +24,7 @@ for example.
>> =20
>>  Trace2 is controlled using `trace2.*` config values in the system and
>>  global config files and `GIT_TRACE2*` environment variables.  Trace2 =
does
>> -not read from repo local or worktree config files or respect `-c`
>> +not read from repo local or worktree config files nor does it respect=
 `-c`
>
> Perhaps adding a comma before "nor" would also be a good addition.

Yup, that sounds sensible.  All other hunks looked good, too.

Thanks, both.
