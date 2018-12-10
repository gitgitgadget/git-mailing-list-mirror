Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3995020A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 21:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbeLJVu0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 16:50:26 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:45801 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJVu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 16:50:26 -0500
Received: by mail-ed1-f45.google.com with SMTP id d39so10786182edb.12
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 13:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=IVPFCqPj0SzCpYhBUHLISAzrCxc3N0unySc5dwN6z8g=;
        b=iuo4mu5P8kNAmhyUO924H0U4GQOmoyQwF+Iog3KhfRHI1Y6XLi8mtNHsZN8k2+TzaB
         w6US5J4Rfoi6LkdoM08KgcoGQvgdW5wgJbkP2xeEyyD6Tmr+q7S2I7SxqaLoBRHTkVC8
         e09vSMalZiN57wZuAS3XSSrMPGruMCuXsqqgozKOrHbmofuXSd1Qsj2P8udr9X8GTZLN
         3eBuhj6XenW9pTqYwPD2lnUqUqwC5amTr/VxUO2E8MdWLEPALL12mrW1GSgHH95o5lj6
         URn8VlVY6yxpY/rM+r/oB8qLALKtX6cKw39BLEPUxGOa62culZNsAcMWoxArE99XZaDH
         Qkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=IVPFCqPj0SzCpYhBUHLISAzrCxc3N0unySc5dwN6z8g=;
        b=E+ETLaOA+cNr+OTliT2ygQh+Ib5TaSYVb2V0SN5ymHdvCDRKUEgOiaVjqnb/KpYqTk
         y+PClRhBo8APd1UF9UywXs5UaJ2M4HfBer81Y46kkOEvx72OEyHm4+XEs5Xow6JKf8PJ
         yGs+C9cOXBd8pYQdneJKkrp6K8e8MfMoXsEWG/1jPe5pwLDdRTiBkBi6YZTRULYAqjrx
         zIbglKElp4l/4jsR/en9jxkgDV2mFWXHoVXc1gxXWUAcylgbAeR1a4g1nYFLXPQxytGJ
         BfGFvGUFSxI/bQ441oJhuPRsFQ5dRRMoFsP6c9LExC7gpei0z2I4fc2zAzLDYQ/2s2P6
         8Y6w==
X-Gm-Message-State: AA+aEWajQSacjl5h0ibNYbDqW8X+CpImfhQrcFLw5tFqmyKOD+FBfR4I
        pZX1kiJnVDRMqKcHUthvQEY=
X-Google-Smtp-Source: AFSGD/WhpNJc40DnnHunjfxWIWCHDCrCTtI942dx0LcrbsVfP1QeuSJAf9jebcp8pyey3yszyATLew==
X-Received: by 2002:a50:f014:: with SMTP id r20mr12885903edl.144.1544478624787;
        Mon, 10 Dec 2018 13:50:24 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id 97sm3555716edq.45.2018.12.10.13.50.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 13:50:24 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com> <CABPp-BGVHnaZLg4fuptVmNa=jRHg0cMDTWjv1NdLQJXPe=+ahw@mail.gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CABPp-BGVHnaZLg4fuptVmNa=jRHg0cMDTWjv1NdLQJXPe=+ahw@mail.gmail.com>
Date:   Mon, 10 Dec 2018 22:50:23 +0100
Message-ID: <875zw1aw68.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 10 2018, Elijah Newren wrote:

> On Sun, Dec 9, 2018 at 12:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> Git 2.20 has been tagged.  I'd expect that we would slow down to see
>> how stable it is and queue only the brown-paper-bag fixes for a week
>> or so, before opening the tree for the next cycle, rewinding the tip
>> of 'next', etc.
>
> Does this mean you'd prefer we continue to wait a little longer before
> sending in new series and re-rolls, or just that you are managing
> expectations about when they might be queued?
>
> (Just curious whether I should submit my rebase-merge-on-sequencer
> re-roll or continue waiting.  I'm happy to do whatever is more
> convenient for others.)

Related; Junio: I've submitted a few things in the last 2-3 weeks which
I knew weren't making it into 2.20, but I just wanted to kick out the
door as I had them ready. Things which are not noted in this "What's
Cooking".

I'm fine with re-submitting those once 2.21 picks up, but don't want to
needlessly spam if your plan is to circle around and pick up those
things you were (rightly) ignoring during the RC period.
