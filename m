Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081E820401
	for <e@80x24.org>; Thu, 15 Jun 2017 21:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750849AbdFOVSy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 17:18:54 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35978 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdFOVSx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 17:18:53 -0400
Received: by mail-pf0-f171.google.com with SMTP id x63so12847300pff.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 14:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8gwLgICbKHnRL5/D5ekpNs/LGOjUI5fBr6DUOgjlKWM=;
        b=ll7FTspB7nLNy8qJrnUezTFMDTXurZ19qYpwldy3KuSozfQGnaTZxYCT2ykZdSm4KR
         jzeISa7kxx2Luz9pxNV6RklQ7LYc08D5Tjya39QxtHYzehT2Aj7CTxbDo5w/C/Pud3V9
         3edwXCjemUFwoTZjHp2boUInQRfw/cJpb2F6Ly6SweiqOTPNKgp+C1+FX8YVJnpnzlBU
         WX3uWt3JD2CXVyQveKE610AoI7z31sg+8Kak4D20W/E2gJwUaMy0ekc8hA7nKrg1IhXN
         uyagGbLcyfxGafTS4ZsAwqNjGJgfPJQN7VlcHh1X2UioB+YRxeRrefq83o57ssuI/lMT
         9/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8gwLgICbKHnRL5/D5ekpNs/LGOjUI5fBr6DUOgjlKWM=;
        b=P8xQtmwGFVQbIw8eMekS3bVudrE+j4vYDsWrmx2L1NS4RqeqhmxFP5dALGK7UZEes0
         qiN/6X2lwQ0gRSnPTisSSfL5wpY3KgErXMmFL2gLwrUZUurqN6CS425mZZjXrqpW9WPD
         d2fTIAvGiNmvhQ2Nxwumy5U4CWVEUC4yccEAJkXDAy8bdvSthNYvxaKNeSE7kGRlgO93
         hBsZWECUuZCdhqIDE0dKnWnd5ILIzaIO8vUrlgQraAW3z53CXElSC2vQODqWDrVs6uXz
         s/EQL+Ey88lQ7oluKVx6nLDdkYSeXEi91D8PS/HhFF5fO1Q3Ym2Ryjd+RM4BTEipi6mG
         dWXw==
X-Gm-Message-State: AKS2vOyaywTZAjWCk7jOnytIV7Q5ZMgz46l5yGRS7gqh3DN0hre1BsMq
        hYQroUqIe57OuZEz
X-Received: by 10.84.199.194 with SMTP id d2mr8560265plh.221.1497561532611;
        Thu, 15 Jun 2017 14:18:52 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:2d7f:7526:8947:80f4])
        by smtp.gmail.com with ESMTPSA id p186sm349000pga.32.2017.06.15.14.18.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 14:18:51 -0700 (PDT)
Date:   Thu, 15 Jun 2017 14:18:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 0/6] config.h
Message-ID: <20170615211850.GC176947@google.com>
References: <20170613210321.152978-1-bmwill@google.com>
 <20170614180739.72193-1-bmwill@google.com>
 <xmqq8tkt10pt.fsf@gitster.mtv.corp.google.com>
 <20170615203332.GB176947@google.com>
 <xmqqzid9yn4a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzid9yn4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > On 06/15, Junio C Hamano wrote:
> >
> >> ... so please eyeball the resulting 12 patches carefully when
> >> they are pushed out.
> >
> > Ugh, I'm terribly sorry.  Completely my bad as I didn't consider what
> > you would need to do on your end.  When I built my patches on top of his
> > I naively just applied his v4 to what ever the current origin/master was
> > at that point in time.  I'll be sure to be more careful with this
> > next time.
> 
> It's no big deal (otherwise I would have insisted you to rebase so
> that the end result can be merged to 'maint', instead of doing it
> myself).
> 
> But quite honestly, I do not understand why you rebased this on top
> of the alias thing.  Help me make sure that I correctly undertand
> what these two topics want to do:
> 
>  - The primary point of js/alias-early-config is to fix reading of
>    pager config from a wrong place when alias expansion is involved,
>    and its solution has a nice property that it simplifies the alias
>    lookup and avoids the unpleasant save/restore-env dance by
>    switching to use the early-config mechanism.
> 
>  - Unfortunately, the early-config mechanism is broken with respect
>    to multi-worktree configuration because it does not pay attention
>    to the common-dir stuff.
> 
>  - The primary objective of bw/config-h was to separate out the
>    configuration related things out of the kitchen-sink cache.h, but
>    as a nice side effect, it also fixes the early-config mechanism.
> 
> Assuming that the above reading of mine of these two topics are
> correct, we can conclude that even if we merge js/alias-early-config
> that forks from v2.13.0 to 'maint', the result by itself would
> regress the use of alias in multi-worktree configuration.  For it to
> be useful, it must be merged after bw/config-h gets merged.
> 
> So it looks to me that it would make more sense to build bw/config-h
> on v2.13.0 and then base js/alias-early-config on top of the result.
> If Dscho is too busy to rebase and you are volunteering to help,
> perhaps the right way to help would be for you to do that rebasing,
> not rebase bw/config-h on top of js/alias-early-config, which is
> backwards and does not buy us very much.  Of course, we could make
> the result of such rebasing into a single topic, but even in that
> case, the order of changes feel backwards if bw/config-h comes
> later.
> 
> Anyway, I think I have to tend to many more patches before I can
> push out today's integration result, so ...
> 
> 

Yeah I see that the order is probably backwards.  I think I just heard
Dscho say "I'm too busy" and went along with just rebasing on top of his
series.  If you do end up feeling like this should be done differently
(like if another reroll is needed etc) then I wouldn't mind taking
ownership and making the order more sane.

-- 
Brandon Williams
