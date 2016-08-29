Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D26EB1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbcH2TxC (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 15:53:02 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36157 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753436AbcH2TxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 15:53:01 -0400
Received: by mail-yw0-f179.google.com with SMTP id u134so92649882ywg.3
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T244k0KKQbBwPbqoSuusOXFW4wVl3prZJva+8fIJltg=;
        b=imUGSh07nGtUJX4N42GDUYcAFcAn6/cYZ0kKNsB31Q/xKNQTS6Hqic/sFCUNUvw9CV
         1DlflS8wPcvsTWsKgBnL12sbF5iA8y2j6Z3ilQkCS043Zga5LgYjjFQo+yENSmL4J33t
         gM2I8dnhhy873k8rJ+rXG6raA/GY7gHGDRiPWCwkcjTEYZvm6B7jIT+66BfccxI9xjgQ
         YofswLBSzouqj4jCZcMWkpPlj324ssIy0RpzURV6wBbiHqPDnhO5gsVL8nmIJptqlvj5
         L/ldW6N2w1vW/Kw+3Yy2GXXzB6r78eVfOoiChHwbBWGZik8vLgjrTUdNGccRVNtYcIRF
         TnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T244k0KKQbBwPbqoSuusOXFW4wVl3prZJva+8fIJltg=;
        b=cI3aixBWERXMxGZx7DhsYjFM/IMYqeYr3TR+FtWUmJ56U6rSMdZF05ur9FNuo7U6xW
         HH9JbIinTubbAl7Ub+YEceTEzJygOaWyitk2+hTHDxHACMKCuP5A/3Q2KVrwmzhHwvOH
         rMBj6xT8l1lDQQHawqw9WFKXz7th9nE23Fgjg25ijtiXAelEyKp/3zWnDgLYf1x4n0Rl
         ZbVVSzPFxLqiicVaoYO11P/XtEAN5QOeWbN+BgNw2jgTEJlqpTF5LNXSkM70HBWEqAit
         B9yA56Mlx14DPkLyFfHpUDwgBqE+LxmIVCeLSlxcVTdF+WuQmg3mlTZTBdGDMPVG+RTq
         tdYw==
X-Gm-Message-State: AE9vXwN7YgKczZeily+bFcJ9/T1YS8rdNAuJERTjLE0nI5mwj9cWHCzUxg5wSD8nkms5KGwTcMEUNyCsItzVVw==
X-Received: by 10.13.228.196 with SMTP id n187mr17735178ywe.83.1472500380846;
 Mon, 29 Aug 2016 12:53:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 29 Aug 2016 12:52:40 -0700 (PDT)
In-Reply-To: <xmqqy43f9wzh.fsf@gitster.mtv.corp.google.com>
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
 <20160828105159.GA5477@ikke.info> <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
 <CA+P7+xrGh687cYHJmYyXiWfjg_8i2-31FZOvk4bEMsO1FU22WA@mail.gmail.com> <xmqqy43f9wzh.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 29 Aug 2016 12:52:40 -0700
Message-ID: <CA+P7+xpz8UNt6bBgrJvsHdFE+MQ4J80K1ed+b41XH_CG6HYYTA@mail.gmail.com>
Subject: Re: Notation for current branch?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Kevin Daudt <me@ikke.info>, ryenus <ryenus@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 29, 2016 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>> What's wrong with simply using 'HEAD' for scripting?
>>
>> When you want to display the current branch to the user, e.g. when
>> scripting a shell prompt or similar use
>
> Wait.  Even if a hypothetical version of Git understood @@ as "the
> current branch", how would you use that notation, instead of HEAD,
> to decide what to "display the current branch to the user"?
>
> You obviously will not be doing
>
>         echo @@
>
> You would be doing something around "git symbolic-ref" at the very
> least, and wouldn't you be feeding HEAD to that symbolic-ref anyway
> while doing so?
>

Hmm. You are right, I mis-understood the original question. Use of
"git symbolic-ref" seems like the right thing if you need to obtain
the current branch name, and there's no reason to not just use HEAD
there.

Thanks,
Jake
