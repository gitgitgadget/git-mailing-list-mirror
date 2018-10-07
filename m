Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85F421F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 19:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJHCOd (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 22:14:33 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:43096 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727284AbeJHCOc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 22:14:32 -0400
Received: by mail-ed1-f41.google.com with SMTP id y20-v6so9095484eds.10
        for <git@vger.kernel.org>; Sun, 07 Oct 2018 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=obB67NoX5pH98Pmg7oLr+ucj+52cejVEfSeN7FWX5JQ=;
        b=nBwvHPRkyFDtxoCntgZeUtV6wzYiR3VBY/qab4tfqHe+FHgPGtLfku4cDp8Z+rWJc3
         Eq8sxp3G40f1Uld4xM/ClvtYwqcH1OhMLkYOiRjPOTgH5Zr/WYZL5Rt2HJKmoszYA/mX
         2+AwKKgX6FgyNPxFmIDVRvxWfoxwYc1Ihf4aYwQAGIan9oxRHARNvsfD64m2lzcvUbfp
         7pmm5c2htt7q0bFXV1wqYpEBYr0JVIXcOjl/4OTbUzWxb7/fntBxprM+f81ft0eNv7bd
         p6fydFHTnj2wUQfQonaSIsyJQWSyK4NcFQlZXOHPtXyVe/CvzZsXhW4LVj5kT8Asy8wq
         NQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=obB67NoX5pH98Pmg7oLr+ucj+52cejVEfSeN7FWX5JQ=;
        b=uerPSPfXhZnnlPExGjTX5QCrMw1gNyU6+QVNikLYDQbb/Cz1cHZJ86sBgDmQEpLHDL
         9p12BTeAM3MvGRKrO0u65Jz9nUtevv9zMVBeOVn8+jIlzJn8clkbDEEo7No2BNwlSW33
         ZwtKu7MZm3KQAuVauBWCqiRl+YZQSChWHqsYeruxOU3FQ+zyMu2m3L/MAleIrtb5XYAL
         4TND87J1CrJqwTaEJeR7x2UGQESpI8WsSzmKwNQRbvcOi3tl6skB3VzYpcXgLh+DU9mf
         +VKdG59EnBv4O8SxGppIwstilkdu9OsIuRCteC2FnQ32tArGsmdlWayc1GTT/gkvM9gL
         xMFQ==
X-Gm-Message-State: ABuFfoi6P057Cs8HGN6T01A3On6V9/Rp27KwrEuOtfqvXCwC6CWyWgSc
        UmtfoP1BefGyIMOXLWw8fsU=
X-Google-Smtp-Source: ACcGV60H7cMyQMP9pqB1DTj/BeXzGY7HGvBUL5v66zyLRFkpzu/A+E6f6aSOfoxyYhXbnt+pGwMYYQ==
X-Received: by 2002:a50:a2a6:: with SMTP id 35-v6mr25408927edm.276.1538939175604;
        Sun, 07 Oct 2018 12:06:15 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b26-v6sm4213256edw.0.2018.10.07.12.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 12:06:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
        Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's so special about objects/17/ ?
References: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
        <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
        <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
        <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
        <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
        <87k1mta9x5.fsf@evledraar.gmail.com>
        <f64b5c5d-ef72-a347-bd0f-7b1669a8c10d@kdbg.org>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <f64b5c5d-ef72-a347-bd0f-7b1669a8c10d@kdbg.org>
Date:   Sun, 07 Oct 2018 21:06:13 +0200
Message-ID: <87in2da862.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Oct 07 2018, Johannes Sixt wrote:

> Am 07.10.18 um 20:28 schrieb Ævar Arnfjörð Bjarmason:
>> In 2007 Junio wrote
>> (https://public-inbox.org/git/7vr6lcj2zi.fsf@gitster.siamese.dyndns.org/):
>>
>>      +static int need_to_gc(void)
>>      +{
>>      +	/*
>>      +	 * Quickly check if a "gc" is needed, by estimating how
>>      +	 * many loose objects there are.  Because SHA-1 is evenly
>>      +	 * distributed, we can check only one and get a reasonable
>>      +	 * estimate.
>>      +	 */
>
>> 1. We still have this check of objects/17/ in builtin/gc.c today. Why
>>     objects/17/ and not e.g. objects/00/ to go with other 000* magic such
>>     as the 0000000000000000000000000000000000000000 SHA-1?  Statistically
>>     it doesn't matter, but 17 seems like an odd thing to pick at random
>>     out of 00..ff, does it have any significance?
>
> The reason is explained in the comment. And, BTW, you do know about
> this one: https://xkcd.com/221/ don't you? (TLDR: the title is "Random
> Number")

Picking any one number is explained in the comment. I'm asking why 17 in
particular not for correctness reasons but as a bit of historical lore,
and because my ulterior is to improve the GC docs.

The number in that comic is 4 (and no datestamp on when it was
published). Are you saying Junio's patch is somehow a reference to that
xkcd in particular, or that it's just a funny reference in this context?

>> 2. It seems overly paranoid to be checking that the files in
>>    .git/objects/17/ look like a SHA-1. If we have stuff not generated by
>>    git in .git/objects/??/ we probably have bigger problems than
>>    prematurely triggering auto gc, can this just be removed as
>>    redundant. Was this some check e.g. expecting that this would need to
>>    deal with tempfiles in these directories that we created at the time
>>    (but no longer do?)?
>
> It's not about that there are SHA-1s in there, it's about how many
> there are.

Right, I'm wondering if it couldn't be replaced by some general path.c
"number_of_files_in_dir" helper. I.e. why this code is being paranoid
about ignoring the likes of
.git/objects/17/{foo,bar,some-other-garbage}. A number_of_files_in_dir()
would obviously need to ignore "." and "..".
