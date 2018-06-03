Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB251F403
	for <e@80x24.org>; Sun,  3 Jun 2018 19:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeFCTsU (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 15:48:20 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:50437 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeFCTsT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 15:48:19 -0400
Received: by mail-wm0-f41.google.com with SMTP id e16-v6so207118wmd.0
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 12:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cfTQJ5F9HndCudium8Kl5/bXEHpdjXzWbZnGCXHQVCI=;
        b=nLeK4x/S+kydW5ttqLH1ZKaUN7alnGCWXKB3QZBr3RRYg5L+XKTiwWCH2Dob+qrjKq
         gQYp2kLPUQN+xS8yDIjZBZjDt79vDiKurEzkYxoDsGu9OOd2Bjmhjf7r1e05z3Vf96U/
         WNgTKBwIN/D9Pt7sikvRt46p21LnAtV6KivpeyO66v08xVxRVbuouoCV/lxGpqi3WT7V
         eUe42pO00rLYGzWEaCAUCCdUFau5cuNQB+sG3Ops21g6nP5kvB+AfkkwndYoB//Cfu7J
         ysNaNEfrby2DFZEwer8CmucVVMEiG19vJrzObQCqv/WHpTza5M/AENB9EJ7XQ6mIjNsN
         Wx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=cfTQJ5F9HndCudium8Kl5/bXEHpdjXzWbZnGCXHQVCI=;
        b=dbVLS/Wl4Zdbxn2wuVEOrqcxmYK4Y3M2dQhW6h2vAzdaKsIZNgj5KylsrMZMiwxKai
         iuRdXuaNGRaiwWS+eM7VbFaHopKymgQfys9i5ajsXlbn1x1swJ0cMsIhLU3zIK+WzfzI
         JbKvFx9NbzAh75wAqEr0tjZ/aI8InuCQMaGq1UdpGkjI9ttTeHI/IQWwAM+0GCSROx/d
         YQsFChcYoO+J3KXXWt+Swirt1rcQXVmmKLou2bsQGijO23KjgTXrOV2vPialwwjNNdcG
         5TEurqdByGzHBEVe/haIokuWR+HV46pmHbtzI8WTYAOF6fg+MGim+SQUeEnXksQbHeia
         DgyQ==
X-Gm-Message-State: ALKqPwdg3bo0LUqnCl8Oirn9chj2mywNujtjH8Ob+RgIhNJPwOOkeKHG
        FdY4sQX4W95UUEMm39sGV9U=
X-Google-Smtp-Source: ADUXVKKtOK1+NuG13m5XWVRKKtio0klE7YuyThVsgRlW9s1/JgBQXpHwvEhWYACVY+BMKpzkU/OAzA==
X-Received: by 2002:aa7:d5d1:: with SMTP id d17-v6mr20822326eds.312.1528055298139;
        Sun, 03 Jun 2018 12:48:18 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v37-v6sm11119069edm.0.2018.06.03.12.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 12:48:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
        <87y3hlecod.fsf@evledraar.gmail.com>
        <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
        <87vab087y2.fsf@evledraar.gmail.com>
        <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
        <87tvqk81qp.fsf@evledraar.gmail.com>
        <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
Date:   Sun, 03 Jun 2018 21:48:16 +0200
Message-ID: <87sh638xdr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 03 2018, Peter Backes wrote:

> On Sun, Jun 03, 2018 at 02:59:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> I'm not trying to be selfish, I'm just trying to counter your literal
>> reading of the law with a comment of "it'll depend".
>>
>> Just like there's a law against public urination in many places, but
>> this is applied very differently to someone taking a piss in front of
>> parliament v.s. someone taking a piss in the forest on a hike, even
>> though the law itself usually makes no distinction about the two.
>
> We have huge companies using git now. This is not the tool used by a
> few kernel hackers anymore.

Sure, but what I'm pointing out is a) you can't focus on git as the
technology because it tells you nothing about what's being done with it
(e.g. the log file case I mentioned b) nobody who came up with the GDPR
was concerned with some free software projects or the SCM used by
companies, so this is very unlikely to be enforced.

>> In this example once you'd delete the UUID ref you don't have the UUID
>> -> author mapping anymore (and b.t.w. that could be a many to one
>> mapping).
>
> It is not relevant whether you have that mapping or not, it is enough
> that with additional information you could obtain it. For example, say,
> you have 5000 commits with the same UUID. Now your delete the mapping.
> But your friend still has it on his local copy. Now your friendly
> merely needs to tell you who is behind that UUID and instantly you can
> associate all 5000 commits with that person again.

So nobody can be GDPR compliant in the face of archive.org and the like?
If the law says that you need to delete information you published in the
past, and you do so, how is it your problem that someone mirrored &
re-published it? That's their compliance problem at that point.

> The GDPR is very explict about this, see recital 26. It says that
> pseudonymization is not enough, you need anonymization if you want to
> be free from regulation.
>
> In addition, and in contrast to my proposal, your solution doesn't
> allow verification of the author field.

It does if you've got the ref. Maybe I just don't get your proposal,
quote:

    Do not hash anything directly to obtain the commit ID. Instead, hash a
    list of hashes of [$random_number, $information] pairs. $information
    could be an author id, a commit date, a comment, or anything else. Then
    store the commit id, the list of hashes, and the list of pairs to form
    the commit.

You're just proposing (if I've read this correctly) that the commit
object should have some list of headers pointing to other SHA1s, and
that fsck and the like be OK with these going away. Right?

How is this intrinsically different from referring to something in the
ref namespace that may be deleted in the future?

In both cases you're just trying to solve the problem of trying to
somehow encode data into a git repository today, that may go away
tomorrow. Similar to how a reference to some LFS object today going away
doesn't fail "git fsck".

>> I think again that this is taking too much of a literalist view. The
>> intent of that policy is to ensure that companies like Google can't just
>> close down their EU offices weasel out of compliance be saying "we're
>> just doing business from the US, it doesn't apply to us".
>>
>> It will not be used against anyone who's taking every reasonable
>> precaution from doing business with EU customers.
>
> I think you are underestimating the political intention behind the
> GDPR. It has kind of an imperialist goal, to set international
> standards, to enforce them against foreign companies and to pressure
> other nations to establish the same standards.
>
> If I would read the GPDR in a literal sense, I would in fact come to
> the same conclusion as you: It's about companies doing substantial
> business in the EU. But the GDPR is carefully constructed in such a way
> that it is hard not to be affected by the GDPR in one way or another,
> and the obvious way to cope with that risk is to more or less obey the
> GDPR rules even if one does not have substantial business interests in
> the EU.

Okey, so you're not reading the GDPR in some literal sense, but you're
coming to a conclusion that's supported by ... what? To echo Theodore
Y. Ts'o E-Mail have you consulted with someone who's an actual lawyer on
this subject?

I haven't but, I'm not suggesting that the git data format needs to
change because of some new EU law. You are, what's your basis for that
opinion?

It seems to me that the git project doesn't need to do anything about
this. There's plenty of things that are illegal to publish, and some of
which may be made illegal after the fact (e.g. national security related
information). If those things are incidentally saved in git repositories
the parties involved may need to run git-filter-branch.

Of course if they need to do that on a weekly basis because of some
overzealous law we may need to have some "native" support for that, but
I see zero signs of that so far.
