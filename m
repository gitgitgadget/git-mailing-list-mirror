Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8DC0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 23:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjG1XAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 19:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbjG1XAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 19:00:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2964D3AB4
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 16:00:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D4012C14F;
        Fri, 28 Jul 2023 19:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+ymDqxoBrLV8
        cdTTRNJE060/vNjgGuTgQ0jtOjLMblc=; b=pTcOnYgpqBW7OhS+4ilvAg0K53gv
        ilvdBjhrCxKrDeaBKGLp3aBai4r6dSiZgB2GYYP3H7rkhYwNq8DoAGF05HCnPYca
        ARQiwZuD78Fp0kgz2whV/EpWTpTcPvSuZUOcwaU1a6ENOPQvvexju2972ZmoXiOv
        tG5Bnxc4RGs/aAk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9550D2C14E;
        Fri, 28 Jul 2023 19:00:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 411982C145;
        Fri, 28 Jul 2023 19:00:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>,
        jacobabel@nullpo.dev
Subject: Re: [PATCH v4] MyFirstContribution: refrain from self-iterating too
 much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
        <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g>
        <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
        <xmqq8rbbbzp2.fsf_-_@gitster.g> <owlycz0deykz.fsf@fine.c.googlers.com>
        <xmqq7cqkanm9.fsf@gitster.g> <xmqqmszg987u.fsf_-_@gitster.g>
        <20230728212144.dpcbp6gfhfuiabia@tb-raspi4>
Date:   Fri, 28 Jul 2023 16:00:05 -0700
In-Reply-To: <20230728212144.dpcbp6gfhfuiabia@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 28 Jul 2023 23:21:44
 +0200")
Message-ID: <xmqqsf973ami.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E55DF08-2D9A-11EE-BFD1-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +While waiting for review comments, you may find mistakes in your init=
ial
>> +patch, or perhaps realize a different and better way to achieve the g=
oal
>> +of the patch. In this case you may communicate your findings to other
>> +reviewers as follows:
>> +
>> + - If the mistakes you found are minor, send a reply to your patch as=
 if
>> +   you were a reviewer and mention that you will fix them in an
>> +   updated version.
>> +
>> + - On the other hand, if you think you want to change the course so
>> +   drastically that reviews on the initial patch would be a waste of
>> +   time (for everyone involved), retract the patch immediately with
>> +   a reply like "I am working on a much better approach, so please
>> +   ignore this patch and wait for the updated version."
>> +
> (That's all good)
>
>
>> +Now, the above is a good practice if you sent your initial patch
>> +prematurely without polish.  But a better approach of course is to av=
oid
>> +sending your patch prematurely in the first place.
>
> That is of course a good suggestion.
> I wonder, how much a first time contributor knows about "polishing",
> in the Git sense ?

I do not know if "without polish" has any strong "Git sense" to
begin with.  The actions the contributor would have done, referred
to as "the above", are the result of re-reading their own patches
and re-thinking their own approaches, which led them to discover
fixes and alternative solutions, and I was hoping that "without
polish" would be understood by anybody to mean "a version that did
not go through such proofreading" without knowing much about how we
develop our patches.

I am OK to just say "sent your initial patch prematurely" and
without "without polish".  I do think it would make the resulting
text encourage less strongly to proofread their own patches before
sending them, but if you think "polish" may not be understood, I am
fine with such a copyediting.  Or using some alternative phrases is
also fine, if it improves our chances to be understood better.

> From my experience, the polishing is or could be a learning process,
> which needs interaction with the reviewers.

Yes, once they see what valuable insight reviewers offer, in their
next topic, they will learn to stop and think before sending the
fresh-off-the-press version without sleeping on it a bit.

> Would it make sense to remove the sentences above and ask people
> to mark their patch with RFC ?

I doubt it.  Nobody will stay newbie forever.  If they do not know
what kind of flaws to look for and how to find them themselves in
their work, that is perfectly OK and they can just send a regular
PATCH.  A reviewer hopefully will notice and point out that it is
not yet beyond RFC quality if that is the case, but this document
should not be suggesting that before seeing their work ;-)

> Or is this all too much bikeshedding, IOW I am happy with V4 as is.

Thanks.
