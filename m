Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C98C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0537E2151B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 19:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJ0eGXJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgLATLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 14:11:21 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57575 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLATLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 14:11:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEC2A10D89B;
        Tue,  1 Dec 2020 14:10:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8GnRdppBFxhI
        2UuLO3HbrYKOv/g=; b=lJ0eGXJ0TPHjdcdrsKXmVkXZfJfEt2QCAIWJI6cMj++Q
        JxqE/lQ4Y/y2gQ0omURsBF0SjE+JMjqI9nyMLGIIEmNR5hs7tE80jdrF8JVLnv36
        3TzclmRC8xB8wEXGj4iGICkYzGZNZTYpM9qi524yixce9Yp2EkVqvjPoV88aqi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=r3Q1Zg
        jOHvcLnPGDFob9zeU8m/eH/rKmE1V4aFz50TTDLcxfdqM4r0JiIex5jlgngKx+40
        CixhTSsBzEIdhEeA7f1GW18Xba50FUwkdRfxQJgY7lBgejU9ngFW5wY+Oz/iPSfq
        /bjDKBgP1rXWwxwWuF2TaZsxMKBXPxbA3UoHU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C78AE10D89A;
        Tue,  1 Dec 2020 14:10:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED71D10D898;
        Tue,  1 Dec 2020 14:10:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cook: add github.com/git-vcs/git as a URL
References: <xmqqtut6qf7q.fsf@gitster.c.googlers.com>
        <20201201094623.4290-1-avarab@gmail.com>
        <X8Ytbbvp7SjrN2g5@coredump.intra.peff.net>
Date:   Tue, 01 Dec 2020 11:10:32 -0800
In-Reply-To: <X8Ytbbvp7SjrN2g5@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 1 Dec 2020 06:47:57 -0500")
Message-ID: <xmqqy2ihpck7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E320A0FA-3408-11EB-BAC4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 01, 2020 at 10:46:23AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> Subject: Re: [PATCH] cook: add github.com/git-vcs/git as a URL
>>
>> I maintain this mirror, but hopefully we can make it semi-official.
>
> I scratched my head for a moment at why you would main another mirror o=
n
> github.com. But I think it is just a typo in the subject. You are
> maintaining a mirror on gitlab.com, which seems perfectly reasonable.
>
>> It
>> has the same refs as the GitHub one except for the GitHub "pull" refs:
>>=20
>>     $ diff -u \
>>         <(git ls-remote https://gitlab.com/git-vcs/git.git/) \
>>         <(git ls-remote https://github.com/git/git/|grep -v refs/pull)
>>     $
>
> I.e., here it is gitlab.com/git-vcs/git, although...
>
>> As an aside there are also https://gitlab.com/gitlab-org/git and
>> https://gitlab.com/git-vcs/git which mostly mirror but also carry some
>> GitLab Employee topic branches.
>
> The mention of git-vcs/git here again confused me. Is it an "also", or
> is it the thing we are talking about?

Ah, thanks for good eyes. =20

If https://gitlab.com/git-vcs/git is mirror-plus-something-else,
then that is a bad fit for the purpose of the list there.

>> diff --git a/MaintNotes b/MaintNotes
>> index 0dc03080de..bb3064e9ac 100644
>> --- a/MaintNotes
>> +++ b/MaintNotes
>> @@ -136,6 +136,7 @@ My public git.git repositories are (mirrored) at:
>>    https://kernel.googlesource.com/pub/scm/git/git
>>    git://repo.or.cz/alt-git.git/
>>    https://github.com/git/git/
>> +  https://gitlab.com/git-vcs/git/
>
> This part make sense to me at least. :)
>
> Would you want to get the maintainer to also push to it as part of the
> regular push-out, so there is never any mirror lag?

The maintainer does not want to push to more repositories than he
currently does.  I think the one at googlesource.com is a mere
mirror out of k.org and not something I push directly into.
