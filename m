Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD25D202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 07:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757752AbdJQHaG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 03:30:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53876 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756325AbdJQHaE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 03:30:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id q132so1861055wmd.2
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 00:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AX/uAd8SAD5EN0QI/VToH+atuyFmHMIV1oHrQVoBKIw=;
        b=Qi1TsS0IJD7LnUWXfeu0W9lZgoBqjH4fdRMvV1PJxFwVKz1d821s++aX3tCVVw9DXW
         DudTV/DQAlZLDHaDmYY3pFHA+be3dfBuBiWZnamrFOjtTcRq3PKVflMutzfPfpdubeUD
         Gep/Hz51wK3VFjq/qfE8+bRkaeOaMgijM2iO8dX4ntEmYZtbGMJ4M5q4N2XXDUelWPgR
         cB3XRFKy3pNxU3bT1WZ5eHC2vipYKxL4oswipFdIePdygQ8yiUzAQ40cVCp4AmKpBhl1
         +R3p8l/SGsc3n77yo7AIdlnn9FTg6jwCU6plc8OaNCx0h/b9doXS0lJkBoQds3tG0O/Y
         UN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AX/uAd8SAD5EN0QI/VToH+atuyFmHMIV1oHrQVoBKIw=;
        b=Vq1Dhsmr2kmzXgxD3goHSFoqwXt8WOY69JD9T7m23uSn9TS7UEjYbazWozUASiFB5O
         TdYsC0GaR986l7iJi6ImGZOo4ewgznxzvq03DGTRKk97mFTjoKbXCHKoaNgg/DUH4U1w
         sW1qhZ/MDk4/68K4PO+jpLSlf+2VxdgVb+GixWVsX8joBm7zOaN2o4Qwqj6a8IDBCefm
         02Rg9+MvM2sp+wcgu2JT42KO5CWn7s6LA4kHVhkOZvT9W7KQD4Ex1lqNOAfIyaB5oSFH
         42zcw0FjzxkxEpO5aa2m1R4Cpi+nZDtdQWRjHg9D4gZ76c9NHsZ34cQ+rmG349jBnMQ8
         7oig==
X-Gm-Message-State: AMCzsaX2v3XyRl6FAz0uqGyEm3DnMIMjw81bwRa6RFUQUZVk6YtmakwC
        6Csbper3ImH0FqeUX+7wAIkBxQGjVJ1RJzs0VwQ=
X-Google-Smtp-Source: AOwi7QDvPnCHZaOhHtXsng2t7CZIMiatWqXxucwsuKz8XRCpSMFFTylrtkH4BdS3OcElvViMtld67DkE5VNsV1OmuE4=
X-Received: by 10.80.177.202 with SMTP id n10mr16655000edd.30.1508225403350;
 Tue, 17 Oct 2017 00:30:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.172.225 with HTTP; Tue, 17 Oct 2017 00:30:02 -0700 (PDT)
In-Reply-To: <xmqqr2u2nu37.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbEojz6P5BmN4bmQ-VuwsVf7RX1sDqiwnEsXN+M4-PXZtg@mail.gmail.com>
 <xmqqr2u2nu37.fsf@gitster.mtv.corp.google.com>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Tue, 17 Oct 2017 09:30:02 +0200
Message-ID: <CAN0XMOKFsHhCSbsWKGg3a84euqkfHA+0dt=snTejqcMQYnAK_A@mail.gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.15.0 round 2
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-10-17 8:53 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Git v2.15.0-rc1 released with a typo fix from commit dfab1eac23
>> ("i18n: add a missing space in message", Sun Oct 8 14:18:39 2017 +0200).
>> This time there are 2 updated messages need to be translated since last
>> update.  Let's start new round of translation for Git 2.15.0.
>
> Today's pushout included 3247edbb ("sequencer.c: fix and unify error
> messages in rearrange_squash()", 2017-10-15), which unfortunately
> added this to the mix:
>
>     error_errno(_("could not write '%s'"), todo_file);
>
> There is another one "could not truncate '%s'" added by the same
> commit, but the codebase already had another instance of the same
> string, so it won't cause trouble.
>
> Regarding the "could not write" thing, there are quite a few
> instances of "coulld not write to '%s'" with %s set to the filename,
> and I strongly suspect that this new one should be further updated
> to match them (Ralf promoted from Cc: to To: for this).  That would
> have a nice side effect of making today's last-minute merges a
> non-event from translators' point of view ;-)
>
>
>

I didn't expect this message to be a new one for translation. I'll send
a patch later to update the message to match the other instances.
