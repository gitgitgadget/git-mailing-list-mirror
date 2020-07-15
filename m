Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E76C433E4
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 02:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A5B20663
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 02:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R0OaQi52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgGOCpv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:45:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65312 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgGOCpu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 22:45:50 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E204E69EB4;
        Tue, 14 Jul 2020 22:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RylVMK7OI6r9
        QXrPzwBVlo0x/UU=; b=R0OaQi52vCwHV7Qgz9v4YqbbHknjA4oEN7zvkW7zHID/
        fEXrpxKq2tjGFzp0BsXmrUioOmflDZCOKN/M+OkXwGPoOQoAJWcWhFohCosNcNFF
        AIygJFj6O9Mm0kaW62AkbTBbARYV15i2UmyaJ+Ch03ePCfTqt00G+en9mprPD64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=c1T1YP
        XrBmg3LlKWDAn/8mVFC99/qDrDnD+aGnzawgs25XVBPukVHJlunASgjBeTWNX3M9
        o0K4e9mg9mWS4+bL/wJ+rRc3sLvR6+WdKMxWkvPPs0zZq+mgczCNhhzRbU+NPhGm
        5+Exc4lQ8Qe6JYchERVmYhSZEpcsuVZT/HcbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D227569EB3;
        Tue, 14 Jul 2020 22:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F92A69EB2;
        Tue, 14 Jul 2020 22:45:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] git-diff.txt: reorder possible usages
References: <cover.1594666410.git.martin.agren@gmail.com>
        <280943ef56a2a777ab0162b8ec4ba0166cc2095c.1594666410.git.martin.agren@gmail.com>
        <CAPx1Gve7Sy5BUdRztVoVNVZgdqm14dvD=36eYzLPed5YMQeMEQ@mail.gmail.com>
Date:   Tue, 14 Jul 2020 19:45:45 -0700
In-Reply-To: <CAPx1Gve7Sy5BUdRztVoVNVZgdqm14dvD=36eYzLPed5YMQeMEQ@mail.gmail.com>
        (Chris Torek's message of "Mon, 13 Jul 2020 15:04:23 -0700")
Message-ID: <xmqqeepdlcme.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48BA2314-C645-11EA-92CD-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> On Mon, Jul 13, 2020 at 12:10 PM Martin =C3=85gren <martin.agren@gmail.=
com> wrote:
>> It then goes on to say that "all of the <commit> in the above
>> description, except in the last two forms that use '..' notations, can
>> be any <tree>". The "last two" actually refers to 6 and 8. This got ou=
t
>> of sync in commit b7e10b2ca2 ("Documentation: usage for diff combined
>> commits", 2020-06-12) which added item 7 to the mix.
>
> Moving this down (as you do in this patch) is the right thing to do,
> but I'll note that formally, the word "that" in "forms that use ..." is
> part of a restrictive clause, so it means "find the last two examples
> that use dots".  (In American English at least, the unrestrictive versi=
on
> would be set off with commas, and use "which" instead of "that".)

Yes, the proposed patch is an improvement, but I agree that "find
the last two that use dots" was indeed what I meant when I wrote
0c783f66 (Documentation/git-diff: A..B and A...B cannot take
tree-ishes, 2007-08-28).

But upon reading it again now, I am not sure it makes sense in the
first place.

    git diff seen^^{tree}..seen^{tree}

uses <tree> (not commit) in the form that uses '..' notation, and it
just works fine.  What does require commit because it depends on
having a history to compute merge base between two objects given
from the command line is the form that uses '...' notation.

    git diff seen^1...seen^2

would be "what did the side branch merged at the tip of seen do
since it forked?" and should look similar to "git diff seen^ seen",
but it cannot use tree objects for obvious reasons

    git diff seen^1^{tree}...seen^2^{tree}

>> An added bonus of this commit is that we're trying to steer users away
>> from `git diff <commit>..<commit>` and moving it further down probably
>> doesn't hurt.
>
> Q: Just how hard should we try?  In particular, would it be good to mar=
k
> the two-dot form as deprecated in the documentation?  I anticipate
> objections because it's not possible to omit `HEAD` without using
> the two-dot form.

I am not sure why it is so important to be able to omit HEAD in the
first place.  I do not think using two-dot form is an offence severe
enough to deserve an extra warning or deprecation notice, but using
the "range" notation when you meant two endpoints is a notation that
confuses uninitiated needlessly and showing it to new people is a
disservice.  "This notation does not make logical sense, but we keep
using it as users, and we keep accepting it as tool makers, purely
for convenience" has been and will be the attitude I'd take towards
the "git diff A..B" syntax---it was a mistake we made when we were
still young ;-)

cf. https://bit.ly/3eBcyZa
