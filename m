Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC51C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 03:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiBRDC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 22:02:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiBRDCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 22:02:54 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE693F8B8
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 19:02:39 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89EA6188F09;
        Thu, 17 Feb 2022 22:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=6vvLMDCozAlBwqT6G4W1R3QnL
        ahpDmbWu8GIjSxNN7E=; b=JgChEQYsQZbLxU5MUj8KJan4Ixt7RIOTwgNQ2+a96
        4hoyFkdqCIwS2meDYblWVjMyXDYLFK/HpFoAQZFhI1vIJQ6xi1G1WVe8cYumGiiJ
        QjpEjWUhv4Si3FedmgfNH7EpMIZvqmQlH/cpNKsinAexojyddBGLHpKpD32tPQSQ
        wE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81321188F08;
        Thu, 17 Feb 2022 22:02:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F06E5188F07;
        Thu, 17 Feb 2022 22:02:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Merlin (they/them) via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "Merlin (they/them)" <merlinpatt+githubgit@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] docs: update coding guidelines to be more inclusive
References: <pull.1070.git.git.1645029267415.gitgitgadget@gmail.com>
        <xmqq4k4ycvgb.fsf@gitster.g>
        <220217.86a6epiyii.gmgdl@evledraar.gmail.com>
Date:   Thu, 17 Feb 2022 19:02:34 -0800
Message-ID: <xmqqfsog512t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 395C1C2C-9067-11EC-944D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Maybe the motivation behind this change is a misunderstanding that
>> somehow the original of what this patch touches says that "male" and
>> "female" are the only two possible values of "gender", but I cannot
>> read it that way even when I squint my eyes.
>
> Isn't that exactly what it's saying? I.e. for the purposes of the
> English used in our documentation there's two grammatical genders "he
> ran the program", "she ran the program" and gender-neutral "it/they ran
> the program".

Yes, for the purpose of the language, there are only two grammatical
genders, "male", "female" (and "thing").  But my point was that the
documentation was not making any non-technical value judgement like
"genders outside these two are forbidden".

What I found problematic with the rewrite is that by moving from
more concrete examples ("avoid 'he' and do not assume 'male'") to a
more abstract wording ("avoid gendered pronouns"), it would burden
non-natives disproportionally more, and I do not see a clear benefit
to offset the downside.

I do not think it adds anything to discussion to repeat what was
already said, so I'll refrain from commenting on the other two
changes in the patch, but they posed the same problem to me.  I
cannot convincingly answer with "yes" to the question "does it
overall help inclusiveness? really? how?"





