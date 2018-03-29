Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAA11F404
	for <e@80x24.org>; Thu, 29 Mar 2018 05:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeC2FyB (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 01:54:01 -0400
Received: from mail.javad.com ([54.86.164.124]:40922 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbeC2Fx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 01:53:59 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 5F14F3E898;
        Thu, 29 Mar 2018 05:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522302838;
        bh=JfvphpbOONoWH7KlUrJK/AjiQuV7439kADRLgzakQOA=; l=3954;
        h=Received:From:To:Subject;
        b=fhMM073iaSWSd2Nd7sUCuJJxcRbPidOySIkDH3DgbfNvVjMcrouwQK7kc374Ys3UY
         dDgTyM7HglIjhjunoQirBPRMi6pc9fRDdN2fa1fqJdZ91xLGWehvzc5Sr8A3ukbETR
         +p/v5W39613d5QkatVJKKUsAEdNhyHzX++Wb4PnI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522302838;
        bh=JfvphpbOONoWH7KlUrJK/AjiQuV7439kADRLgzakQOA=; l=3954;
        h=Received:From:To:Subject;
        b=fhMM073iaSWSd2Nd7sUCuJJxcRbPidOySIkDH3DgbfNvVjMcrouwQK7kc374Ys3UY
         dDgTyM7HglIjhjunoQirBPRMi6pc9fRDdN2fa1fqJdZ91xLGWehvzc5Sr8A3ukbETR
         +p/v5W39613d5QkatVJKKUsAEdNhyHzX++Wb4PnI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522302837;
        bh=JfvphpbOONoWH7KlUrJK/AjiQuV7439kADRLgzakQOA=; l=3954;
        h=Received:From:To:Subject;
        b=fnpvfD2AWgRB4GlIAK1gm4YZvAdCHMd3pxz+vVVhN/QT0KjLx+RLqHqsUmd6ZjFU0
         lgzknSZy1QW8G5K66Er0oA8stacZ9L62lkm9MsNg+lI6/cTfnBOrMOqBaQdFBlVkgQ
         TgbxmBJk9WLXfKNm/+M7BqLJFXHsE85hTwwaIvxo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522302837;
        bh=JfvphpbOONoWH7KlUrJK/AjiQuV7439kADRLgzakQOA=; l=3954;
        h=Received:From:To:Subject;
        b=fnpvfD2AWgRB4GlIAK1gm4YZvAdCHMd3pxz+vVVhN/QT0KjLx+RLqHqsUmd6ZjFU0
         lgzknSZy1QW8G5K66Er0oA8stacZ9L62lkm9MsNg+lI6/cTfnBOrMOqBaQdFBlVkgQ
         TgbxmBJk9WLXfKNm/+M7BqLJFXHsE85hTwwaIvxo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522302837;
        bh=JfvphpbOONoWH7KlUrJK/AjiQuV7439kADRLgzakQOA=; l=3954;
        h=Received:From:To:Subject;
        b=fnpvfD2AWgRB4GlIAK1gm4YZvAdCHMd3pxz+vVVhN/QT0KjLx+RLqHqsUmd6ZjFU0
         lgzknSZy1QW8G5K66Er0oA8stacZ9L62lkm9MsNg+lI6/cTfnBOrMOqBaQdFBlVkgQ
         TgbxmBJk9WLXfKNm/+M7BqLJFXHsE85hTwwaIvxo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522302837;
        bh=JfvphpbOONoWH7KlUrJK/AjiQuV7439kADRLgzakQOA=; l=3954;
        h=Received:From:To:Subject;
        b=fnpvfD2AWgRB4GlIAK1gm4YZvAdCHMd3pxz+vVVhN/QT0KjLx+RLqHqsUmd6ZjFU0
         lgzknSZy1QW8G5K66Er0oA8stacZ9L62lkm9MsNg+lI6/cTfnBOrMOqBaQdFBlVkgQ
         TgbxmBJk9WLXfKNm/+M7BqLJFXHsE85hTwwaIvxo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522302837;
        bh=JfvphpbOONoWH7KlUrJK/AjiQuV7439kADRLgzakQOA=; l=3954;
        h=Received:From:To:Subject;
        b=fnpvfD2AWgRB4GlIAK1gm4YZvAdCHMd3pxz+vVVhN/QT0KjLx+RLqHqsUmd6ZjFU0
         lgzknSZy1QW8G5K66Er0oA8stacZ9L62lkm9MsNg+lI6/cTfnBOrMOqBaQdFBlVkgQ
         TgbxmBJk9WLXfKNm/+M7BqLJFXHsE85hTwwaIvxo=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f1QVX-0004oW-Mc; Thu, 29 Mar 2018 08:53:55 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
        <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
        <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
        <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
        <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
        <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
        <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
        <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com>
        <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
        <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87woxyf4lk.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <874ll0d9nt.fsf@javad.com>
        <CA+P7+xoDQ2mzhxeZPFhaY+TaSoKkQm=5AtoduHH06-VggOJ2jg@mail.gmail.com>
        <87r2o48mm2.fsf@javad.com>
        <CA+P7+xo19mHrWz9Fy-ifgCcVJM2xwzcLj7F2NvFe2LwGbaJiDQ@mail.gmail.com>
Date:   Thu, 29 Mar 2018 08:53:55 +0300
In-Reply-To: <CA+P7+xo19mHrWz9Fy-ifgCcVJM2xwzcLj7F2NvFe2LwGbaJiDQ@mail.gmail.com>
        (Jacob Keller's message of "Wed, 28 Mar 2018 17:32:25 -0700")
Message-ID: <87zi2r5swc.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Wed, Mar 28, 2018 at 4:29 AM, Sergey Organov <sorganov@gmail.com> wrote:
>
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>> > On Tue, Mar 27, 2018 at 10:57 PM, Sergey Organov <sorganov@gmail.com>
>> wrote:
>> >>
>> >> Hi Johannes,
>> >>
>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >> > Hi Sergey,
>> >> >
>> >>
>> >> [...]
>> >>
>> >> >> >> Reusing existing concepts where possible doesn`t have this
>> problem.
>> >> >> >
>> >> >> > Existing concepts are great. As long as they fit the requirements
>> of
>> >> >> > the new scenarios. In this case, `pick` does *not* fit the
>> > requirement
>> >> >> > of "rebase a merge commit".
>> >> >>
>> >> >> It does, provided you use suitable syntax.
>> >> >
>> >> > You know what `pick` would also do, provided you use suitable syntax?
>> > Pick
>> >> > your nose.
>> >> >
>> >> > Don't blame me for this ridiculous turn the discussion took.
>> >> >
>> >> > Of course, using the suitable syntax you can do anything. Unless there
>> > is
>> >> > *already* a syntax and you cannot break it for backwards-compatibility
>> >> > reasons, as is the case here.
>> >>
>> >> Backward compatibility to what? To a broken '--preserve-merges'? I had a
>> >> feel you've invented '--recreate-merges' exactly to break that
>> >> compatibility. No?
>> >>
>> >> Or is it "Backwards compatibility of a feature that existed only as a
>> >> topic branch in `next` before being worked on more?", as you say
>> >> yourself below?
>> >>
>> >
>> > I'm pretty sure he meant that changing the meaning and behavior of "pick"
>> > is incompatible, as people use scripts which check the edit lists, and
>> > these scripts would expect pick to behave in a certain way.
>>
>> Are we still speaking about that new --recreate-merges feature? You
>> already care for compatibility for it? You expect there are already
>> scripts that use it?
>>
>> Once again, it seems like you care and don't care about backward
>> compatibility at the same time, here is your phrase below:
>>
>> "He absolutely cares about compatibility, but in this case, the feature
>> has not yet been merged into an official release."
>>
>> Are we still speaking about that new --recreate-merges feature?
>>
>> Do you guys care for compatibility for this particular --recreate-merges
>> feature or not? I'm lost. "Yes" or "No" answer, if you please!
>>
>> -- Sergey
>>
>
> I care about the general compatibility of the rebase todo list regardless
> of which options you enabled on the command line to generate it.

It's a good thing in general, yes. However, I recall I was told by the
author that --recreate-merges was introduced exactly to break backward
compatibility of the todo list. If so, could we please agree to stop
using backward compatibility as an objection in the discussion of this
particular feature?

> Yes this has a bit of problem because *any* new todo command will
> break the todo list, but it's better to only add new commands rather
> than change semantics of existing ones.

I'm not against new commands in general. I'm against inventing new
entities without necessity, so, provided we did agree not to care about
compatibility, there should be some other necessity to invent yet
another command. I don't see such a necessity. Do you?

The main principle I stand for in this discussion though is that all the
commits should be treated equally as much as possible, new command or no
new command. Doing otherwise will lead to all kinds of troubles and
confusion, both in implementation and in user experience.

Overall, what I think is needed is extending the syntax of existing todo
commands to handle merge commits. This will give a provision to get it
right this time. Otherwise it will likely end up being yet another
subject of deprecation in the future.

-- Sergey
