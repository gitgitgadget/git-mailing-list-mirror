Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FBD81F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeJCFSH (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:18:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63024 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFSH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:18:07 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2018 01:18:05 EDT
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F94B35F15;
        Tue,  2 Oct 2018 18:25:57 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rPblc7tXxwBQ
        mLnVdiRulgPjjUo=; b=Zc+All8n40+KkShd6762esrDuMlMHcUffMKPg0RipYxW
        fgEPL0cRRdTlEOIz/lSJe4ECvSAOZVifwoiL6Ta04x5Bfmg/fK/nKkzz9/jxzHTi
        ot58lIlV0puqDH9jfTz+pVcAhd21kbp7dOO0MvD/T54LWtH0AyvmaYUrVMlHWBM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4844035F14;
        Tue,  2 Oct 2018 18:25:57 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type:content-transfer-encoding; s=mesmtp; bh=OBywHyqcCE0QWH3vH9m3zJOPV7Hygr3L+aSdHYPdeKc=; b=lQ33oJ/8D00yFEl7ppR/Tp8d/W4u1XfO7X57MyHBnXICiSQBuS2f12Fgy20xE6fSFFKLo7aZ9TLZGVk30YqWZ4YIkP2L2UnEM1H2OEB6aBpgZNQL1dChFTRENwzEFpbC5jiho8d2Ud3eaGF6zhdfCfAJkTq+A8ZsuArCjmefp9E=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D76035F13;
        Tue,  2 Oct 2018 18:25:54 -0400 (EDT)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Stefan Xenos <sxenos@google.com>,
        git@vger.kernel.org, Jordan Torbiak <torbiak@gmail.com>
Subject: Re: Git Evolve
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
        <20181002012326.GA96979@syl> <877ej0iuhc.fsf@evledraar.gmail.com>
Date:   Tue, 02 Oct 2018 18:25:52 -0400
In-Reply-To: <877ej0iuhc.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 02 Oct 2018 11:11:11 +0200")
Message-ID: <87r2h8c7f3.fsf@kyleam.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Pobox-Relay-ID: 20668830-C692-11E8-B31B-F5C31241B9FE-24757444!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Oct 02 2018, Taylor Blau wrote:

[...]

>> Specifically, I've wanted the 'hg absorb' command. My understanding of
>> the commands functionality is that it builds a sort of flamegraph-esque
>> view of the blame, and then cascades downwards parts of a change. I am
>> sure that I'm not doing the command justice, so I'll defer to [1] where
>> it is explained in more detail.
>>
>> The benefit of this command is that it gives you a way to--without
>> ambiguity--absorb changes into earlier commits, and in fact, the
>> earliest commit that they make sense to belong to.
>>
>> This would simplify my workflow greatly when re-rolling patches, as I
>> often want to rewrite a part of an earlier commit. This is certainly
>> possible by a number of different `git rebase` invocations (e.g., (1)
>> create fixup commits, and then re-order them, or (2) mark points in your
>> history as 'edit', and rewrite them in a detached state, and I'm sure
>> many more).
>>
>> I'm curious if you or anyone else has thought about how this might work
>> in Git.
>
> I've wanted a "git absorb" for a while, but have done no actual work on
> it, I just found out about it.

It may be worth looking into git-autofixup [0] (author cc'd).  I learned
about it when Magit used it in its magit-commit-absorb command, but I
haven't used it yet myself.

[0] https://github.com/torbiak/git-autofixup

--=20
Kyle
