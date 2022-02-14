Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5DBC433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 21:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiBNVGf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:06:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiBNVG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 16:06:27 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386D8133197
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 13:06:07 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 95262187472;
        Mon, 14 Feb 2022 14:50:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4wIRFsjfCasl
        Bvcjx9PcVrq6X3VAjF2ZzfagzISnSu4=; b=HnsdD6iOtv23a0XcZHDk30B+CChE
        yfuiVP519LRV+OeuO+ZK19brgxhkagihe8BFTXvcGbkfG9XihXUPkzxKco914BDn
        w0kmBa4NDCKbR0OggBk5HaFQpxE8oZ2HCFf06lExfsuWDJpW1phrdw5fqT/6TfIO
        N/JLJtwJked9QH4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C8D5187471;
        Mon, 14 Feb 2022 14:50:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5C7E187470;
        Mon, 14 Feb 2022 14:50:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] mailmap: change primary address for Derrick Stolee
References: <pull.1142.git.1644857153590.gitgitgadget@gmail.com>
        <220214.86leydxt77.gmgdl@evledraar.gmail.com>
Date:   Mon, 14 Feb 2022 11:50:30 -0800
In-Reply-To: <220214.86leydxt77.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 14 Feb 2022 18:17:19 +0100")
Message-ID: <xmqqczjp2po9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5E258696-8DCF-11EC-BFCE-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Feb 14 2022, Derrick Stolee via GitGitGadget wrote:
>
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> Stolee transitioned from Microsoft to GitHub in July 2020, but continu=
ed
>> to use <dstolee@microsoft.com> because it was a valid address. He also
>> used <stolee@gmail.com> to communicate with the mailing list since
>> writing plaintext emails is difficult in Outlook. However, recent issu=
es
>> with GMail delaying mailing list messages created a need to change his
>> primary email address.

"I prefer this address to be the one shown" is a good enough
justification for these entries ;-).

> Yeah that sucks. You might be interested in the tips I had for working
> around it in
> https://lore.kernel.org/git/220202.86leyt8uly.gmgdl@evledraar.gmail.com=
/;
> and others have suggested subscribing an alias address for the GMail
> address.
>
>> diff --git a/.mailmap b/.mailmap
>> index 9c6a446bdfb..07db36a9bb9 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -59,8 +59,9 @@ David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmw=
are.(none)>
>>  David S. Miller <davem@davemloft.net>
>>  David Turner <novalis@novalis.org> <dturner@twopensource.com>
>>  David Turner <novalis@novalis.org> <dturner@twosigma.com>
>> -Derrick Stolee <dstolee@microsoft.com> <stolee@gmail.com>
>> -Derrick Stolee <dstolee@microsoft.com> Derrick Stolee via GitGitGadge=
t <gitgitgadget@gmail.com>
>> +Derrick Stolee <derrickstolee@github.com> <stolee@gmail.com>
>> +Derrick Stolee <derrickstolee@github.com> Derrick Stolee via GitGitGa=
dget <gitgitgadget@gmail.com>
>> +Derrick Stolee <derrickstolee@github.com> <dstolee@microsoft.com>
>
> FWIW I think only the addition of that last line is needed since the
> .mailmap syntax supports mapping A->B, followed by B->C.

I suspect that another reason of retiring the two entries that may
not be captured in the log message is so that people does not have
to know the person is reachable both at microsoft and github.

It is somewhat sad that we need to carry these "via GitGitGadget"
entries in the file, but we are fortunate that the mailmap supports
the "differentiate two authors with the same e-mail with the human
readable name" feature so that we can label v2.25.0~3^2 and
v2.25.1~20^2~1 with the rigth authors.  If my counting is correct,
these two are the only ones that we mistakenly made GGG as the
author of a change.






