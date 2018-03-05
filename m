Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13BAA1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeCES1C (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:27:02 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39185 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCES1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:27:01 -0500
Received: by mail-pf0-f195.google.com with SMTP id u5so7562834pfh.6
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aY55Ok7XFg+KnjCeEb8uNNNnBZFInMujcnfVuVIyDok=;
        b=oue9f/YdA0YfGVasToWoJwSEJH/v7/354MxuJ/9EDsssoNeaturO84XurTBUAucIgI
         DbllHBIA2sLx3koLdhbH7mg5zW/l0DcN2yWF+NIioY/GYVPqQCadp1ovvmv7ItHyu6gh
         J0wLkEXnLuMnJI2MHnkNORPoLhGtdn545jNMb2hnzL5mLq7SuCJnoIPbmMB3AOSU1/kU
         LBKhF8hoVwoGWB5EA0by+UHPpcefXs1CMtQ0jEcEEwjqGL0sL2Rat36ZywPugka57nT8
         IKG9wLp4bxumx+b0jJuYpGxLoJD9wXsCH9auLnaUqbDgxhj0yFHb+Gp7RCjxVVVL1SOy
         clKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aY55Ok7XFg+KnjCeEb8uNNNnBZFInMujcnfVuVIyDok=;
        b=d/psp8YG8TFabrcyXQrEzSBjgJ+5w3ZPM1N6Q0J8u479vEIQgOqpmNW9U7yZP/Y2Uw
         xKR6qgKHDr4Yyr8XgJS1fGSg8hkBDoxKe3JbADb3hm8WQp8DIALwFq+lEiUaPTr4QkDJ
         obnNWmuoQVo5DQjA5UGHV01gYmCYYzcGrs/VmmgFf8ct9RgistuSWiuNveX/TkJG6AYR
         HPauw2WtKGSIJePKWSIjBIuzyXkUVrw6W/civj+BAWiJN8t5qlc+fFJR68wV1n7ynGwc
         63lfr3Yz5XevcvP7KEVP9TPDVoM1a+RmZUvrkQfnYxnPEyBriIuQnQH0wUB6vYRBJcFi
         C3mQ==
X-Gm-Message-State: APf1xPDkerglZ/NXVXDCI6O5FMni1ojfmJDdFhwVdRhTqEuRh0DA8xnm
        XRVEqKl/UC0NaHU5o1uJO1g=
X-Google-Smtp-Source: AG47ELsLsM6yNXlNRQchqkmV0pxSex5kFTvkjy9D3+Wk2RnnmLplBJMnURVd3mmbVUTGB8lzZXj30A==
X-Received: by 10.98.102.155 with SMTP id s27mr16384707pfj.198.1520274420616;
        Mon, 05 Mar 2018 10:27:00 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f11sm1334847pfa.112.2018.03.05.10.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:26:59 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:26:58 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
Message-ID: <20180305182658.GC28067@aiede.svl.corp.google.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
 <20180302044409.GC238112@aiede.svl.corp.google.com>
 <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180303182723.GA76934@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803051711210.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

Back on topic, some quick clarifications to tie up loose ends.

Also I want to thank you for continuing to push the project to work
better (especially to work better for newcomers).  We don't seem to
have a habit of saying often enough how important that goal is.  Of
course we'll disagree from time to time in minor ways about particular
aspects of how to change the development workflow, but the progress
you've already made (e.g. via tools like SubmitGit) is a huge deal.

[...]
Johannes Schindelin wrote:
> On Sat, 3 Mar 2018, Jonathan Nieder wrote:

>>  1. Approximately 1/2 of the differences you describe apply to Mac as
>>     well as Windows.
>
> No. The executable bit, the native line endings, most of the issues I
> listed do not catch macOS-based developers off guard.

Yeah, my wording was really sloppy.

I meant that one of the differences you described half-applies to Mac
and the rest don't apply to Mac.  I should have proofread.

[...]
> Stolee agreed in the PR to mention alternatives to Hyper-V, such as
> VirtualBox, which would help macOS-based developers here.

I have no opinion about that (maybe it will make the text too long and
overwhelming, or maybe it will help people on balance).

[...]
> The Google gang (you & Junio included) uses Linux. Peff uses Linux. From
> what I can see Duy, Eric and Jake use Linux. That covers already the most
> active reviewers right there.

We are not as uniform as it may seem.  The Google gang all uses Linux
on workstations but some use Mac laptops as well.  We deal with user
reports all the time from all three popular platforms.

IIRC then Junio has a test setup that tests on Linux, FreeBSD, and
some other platforms.  IIRC Microsoft provides a way to run a Windows
VM for development purposes that he could use for testing in the same
way as he tests on FreeBSD if there are clear enough instructions for
doing it (hint, hint). :)

Of course it's even better if there is some public shared build/test
dashboard that we can all work together to at least keep green.

[...]
> So where is that formatter call that fixes your code?

There's "make style", and people still continue to work on improving
its configuration (thanks!).

[...]
> However, VSTS is free for teams up to five, meaning that any developer can
> register a project, and once I manage to get build definitions in shape, I
> can make them public and anybody can test their code on the major three
> platforms, in their personal VSTS account.

Thanks.  That sounds potentially useful.  (Though a shared dashboard
that we all keep green might be even more so.)

[...]
> So everything is a legal text.

Yeah.  In this context I should have instead said something like
"lawyer-reviewed text".

[...]
> Put another way: I indulged in veering off on a tangent. You know, like we
> do for fun here ;-)

Feel free to call me on it when my tangents are hurting, or when
they're helping for that matter.  That way I have training data to
improve my model of how to make a good tangent. :)

Sincerely,
Jonathan
