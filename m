Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81EBD20282
	for <e@80x24.org>; Tue, 20 Jun 2017 14:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbdFTOlv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 10:41:51 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34739 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdFTOlu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 10:41:50 -0400
Received: by mail-lf0-f47.google.com with SMTP id l13so15579979lfl.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MfXnZTkDDlg806JNz99cbMHXKoIUkMmCcda1sqDf0Ns=;
        b=G3uLn4eNSz0KGkKeN/+Xs6sw/D2/6CpjaZYGOMZw31OHqXOGV/0/ir6IOlT9HTK3kc
         mVFnm+nXINraJNyzxtr5FL060xLHzUlB6xqbByVoH4T6ipQzeMImBHCPRyEegc2PDMmx
         kwTgeYxPguHw+iN/wBHy9T7sfy/BXxUgRtgYiFh2OfdryxAKpgz92uaMfN2cTqGxAJ4z
         6eUVoHaHNht6N1OYiJT14Dka16nUNytviTEuajUExQWsPfdFkhweDVIieki1gtv7kY9Z
         Xli6sRse8ip6mjYheJCI284RqKBPpomQ4CrwWoLgrLxYtiDFTP+gnqMH4T3L827LjKbw
         oJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MfXnZTkDDlg806JNz99cbMHXKoIUkMmCcda1sqDf0Ns=;
        b=V1Cc8mb6B6shHo+nB1LRP26AOvIE1HF0pPNZ/30zjwor6lnORzSCvZWI15RzWLbCVs
         atF9/jAdQk3WXzv626gMdKGaEozwymV9rKprfMZizyWlhdnVN6QMeeW0aoBzz2hIV14+
         KdyKM09ge6bydhwYIKDoP4vlfdanAMOWJ2UQmcbL1xXoFDC+PIr4FlA2G40ejTSRAe98
         597kBpCGYlQkk5LHsoaf3Ncx+VDS1/s29rRileQUFY4nE/iuTaw75F5oUvGG774tIotl
         OcyJVffRANzxrJFP5aY3Cn81nbSOIp0uZJGpimBqYm+yw7jn3ocg5jx4Zk4JFoXQfpfL
         MHKA==
X-Gm-Message-State: AKS2vOwLDZ+sRxeN+f38vf2DDGQ3fP76phxCnS5fHdwiWUYUkhAji0pJ
        fQsmvd9w2KAWgQ==
X-Received: by 10.80.154.129 with SMTP id p1mr21708087edb.131.1497969708629;
        Tue, 20 Jun 2017 07:41:48 -0700 (PDT)
Received: from snth ([92.109.130.42])
        by smtp.gmail.com with ESMTPSA id z44sm7775468edz.57.2017.06.20.07.41.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 07:41:47 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dNKLi-0007TW-FB; Tue, 20 Jun 2017 16:41:46 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     gitster@pobox.com, peff@peff.net, git@vger.kernel.org
Subject: Re: [PATCH 1/3] Contextually notify user about an initial commit
References: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com> <20170620030220.7323-1-kaarticsivaraam91196@gmail.com> <87o9tj86hs.fsf@gmail.com> <1497965839.2792.2.camel@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1497965839.2792.2.camel@gmail.com>
Date:   Tue, 20 Jun 2017 16:41:46 +0200
Message-ID: <87mv9290wl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 20 2017, Kaartic Sivaraam jotted:

> Thanks for trying to help. A few comments regarding your suggestions.
>
>> * Let's do that spacing fix (unrelated fix) in its own commit.
>>
> Ok. That's a good point.
>
>> * You should add tests along with the code being changed, and
>> especially change tests that would fail with your new code,
>>     otherwise you break bisection.
>>
> I'm not sure if the convention here is to keep tests along with change
> it tests. I thought it would be better to separate them as they are
> "separate" changes. They're separate because in case of any issues with
> the test it should be possible to identify them separately. This isn't
> possible when they are added along with the change.
>
> Further, adding them as a separate change change (commit) immediately
> after the change it tests would ease the task of finding the change it
> tests.
>
> If the convention here, really, is to add tests along with the
> change,I can't do anything but to follow it. I guess it should be
> mentioned somewhere in the Documentation/SubmittingPatches. AFAIK, I
> don't think it's mentioned there.

Right now 1/3 breaks the test suite. That's a big no-no, any given
commit should not break the test suite to not break bisecting.

But aside from that the general pattern we follow is that if code
behavior changes, tests for that new behavior go in the same commit.

>> * I think the commit message here could be shorter & clearer at the
>> same time.
> I don't think it's unclear. It's longer for the reason that follows.
> The commit message was crafted based on the following guideline found
> in Documentation/SubmittingPatches
>
>> The body should provide a meaningful commit message, which:
>>
>>  . explains the problem the change tries to solve, i.e. what is
>>     wrong with the current code without the change.
>>
>>  . justifies the way the change solves the problem, i.e. why the
>> result with the change is better.
>>
>>  . alternate solutions considered but discarded, if any.
>>
> I don't think the new commit message follows this. Both the commit
> messages are found below for comparison.
>
> Old one
> -------
>> On Tue, Jun 20 2017, Kaartic Sivaraam jotted:
>>
>>  "git status" indicated "Initial commit" when HEAD points at
>>  an unborn branch.This message is shared with the commit
>>  log template "git commit" prepares for the user when
>>  creating a commit (i.e. "You are about to create the initial
>>  commit"), and is OK as long as the reader is aware of the
>>  nature of the message (i.e. it guides the user working
>>  toward the next commit), but was confusing to new users,
>>  especially the ones who do "git commit -m message" without
>>  having a chance to pay attention to the commit log template.
>>
>>  The "Initial commit" indication wasn't an issue in the commit
>>  template. Taking that into consideration, a good solution would
>>  be to contextually use different messages to indicate the user
>>  that there were no commits in this branch.
>>
>>  A few alternatives considered were,
>>
>>  * Waiting for initial commit
>>  * Your current branch does not have any commits
>>  * Current branch waiting for initial commit
>>
>>  The most succint one, "No commits yet", among the alternatives
>>  was chosen.
>>
>>  Helped-by: Junio C Hamano <gitster@pobox.com>
>>  Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>>
>
> New one
> -------
>>  status: contextually notify user about an initial commit
>>
>> Change the output of "status" to say "No commits yet" when "git
>>  retaining the current "Initial commit" message displayed in the
>>  template that's displayed in the editor when the initial commit is
>>  being authored.
>>
>> The existing "Initial commit" message makes sense for the commit
>> template where we're making the initial commit, but is confusing
>>  when merely checking the status of a fresh repository without
>>  having any commits yet.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>
>
>> * The commit message doesn't follow our usual format.
> Could you be more specific about where it's not following the format?

Regarding the format: I was referring to the 'prefix the first line with
"area: "' part of SubmittingPatches, sorry for the brevity. I.e. your
--oneline output just yields "Contextually notify user about an initial
commit" but should be "status: <short summary>".

For the rest of the changes I made: I just found the current version
hard to read, most of the first paragraph is one big 8-line sentence,
after reading it over a few times and understanding what it was doing I
thought I'd rewrite it as a shorter version that was (hopefully) easier
to understand.

I dropped the "alternatives considered" because while it follows the
SubmittingPatches guidelines as-is, given other patches I've seen what
we eventually ended up picking for some trivial wording in a UI message
is probably better left to a mailing list search for anyone's that
curious rather than summarizing all the proposed alternatives in the
commit message.
