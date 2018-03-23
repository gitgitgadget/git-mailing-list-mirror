Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2431F404
	for <e@80x24.org>; Fri, 23 Mar 2018 19:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751960AbeCWTGj (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 15:06:39 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:45926 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWTGi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 15:06:38 -0400
Received: by mail-lf0-f50.google.com with SMTP id l4-v6so15454147lfg.12
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bBG3eFRdokoawnKcyuaiglwWFjZrdF+vQqgizCcAu14=;
        b=EuroPHVNx+XZuf63r8duMVJyiJslttNigdOObgh5DcjM7MGLCAjqY16yrXvLxk8HAi
         N7RRbsn5+qvJ774m58ewn2OqI42iQvruqUdydkY/xGKqQbuJ675Js9Y/XyGtekVh9ei/
         HhfClcXZTzgMt/bkv63NlOw5rpCuFcfdASXrXYk7IDtdUX6abVuekpYTYJLtHiXVZFYV
         SnqMEwRAkPb3xGGxHzrjswU4Kss2EkQ/gAwM+SG2FdqW3b+kra+f0r3fcRbGSbh0yZx4
         MNhXTcfwCPRaiC9oV7wo6A5CJuLYPWFVRaeJWK81BkSlKcsHR9T4G2mSifE1hwDbM8UH
         zJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bBG3eFRdokoawnKcyuaiglwWFjZrdF+vQqgizCcAu14=;
        b=XXi8I0rro/2HAeUEzCo8yWIKQeTeNRv5C+1rQPYgvXzaWmcy25JE+AxCTHybQ23KBi
         qzJE4WGiXFwuNntO0jvLhV0cq1I8HULNgTYZO/C9J2WsZHSBK3TyRRN9eJdOw6ZJBPYp
         F117Yft4w6GzBPSEiR4QJmKA22UJ7nAMZ3Xtf0FVqqjm7po2WZhH1m9Na5I4qoaKMTDl
         rLC2nCPK1obxIiq5IYNS3ehrL2hM3T0e7eh2MrU8OR63lip9P9J6bjleKnXrux1CbRXS
         aKYSl3q2C3oLzY+vAS4YgiK2zSArBPJdobu0/yMwSsI9VZTw+2mks1RqepS58gfgE9l5
         voFg==
X-Gm-Message-State: AElRT7FMzCVI4Poxu1F469fltCHatrDjMLHhvh/8INi5UCtrcdyGDwa9
        vqemQm/k5QZAOqF+WkiOU/wDZnf1ZVIJB7gzxFrqHg==
X-Google-Smtp-Source: AG47ELuD1d1vpDMrAlVhFjlaEtwPi1tfj+AeGAlGsKIZSHBbDbFkX+/EZ1ddUe82OydeaqVb+pOZkjSHR0g0UP/jOUA=
X-Received: by 2002:a19:9502:: with SMTP id x2-v6mr21347840lfd.119.1521831996784;
 Fri, 23 Mar 2018 12:06:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 12:06:16
 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803231811530.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1521779249.git.wink@saville.com> <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
 <nycvar.QRO.7.76.6.1803231811530.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 12:06:16 -0700
Message-ID: <CAKk8isrxTmryumw5EFVcPxx9wUKA=pB3VxvH9VaHPLRraa=4=g@mail.gmail.com>
Subject: Re: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced scripts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 10:12 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Wink,
>
> On Thu, 22 Mar 2018, Wink Saville wrote:
>
>> The backend scriptlets for "git rebase" were structured in a
>> bit unusual way for historical reasons.  Originally, it was
>> designed in such a way that dot-sourcing them from "git
>> rebase" would be sufficient to invoke the specific backend.
>>
>> When it was discovered that some shell implementations
>> (e.g. FreeBSD 9.x) misbehaved when exiting with a "return"
>> is executed at the top level of a dot-sourced script (the
>> original was expecting that the control returns to the next
>> command in "git rebase" after dot-sourcing the scriptlet).
>>
>> To fix this issue the whole body of git-rebase--$backend.sh
>> was made into a shell function git_rebase__$backend and then
>> the last statement of the scriptlet would invoke the function.
>>
>> Here the call is moved to "git rebase" side, instead of at the
>> end of each scriptlet.  This give us a more normal arrangement
>> where the scriptlet function library and allows multiple functions
>> to be implemented in a scriptlet.
>>
>> Signed-off-by: Wink Saville <wink@saville.com>
>> Reviewed-by: Junio C Hamano <gitster@pobox.com>
>> Reviewed-by: Eric Sunsine <sunsine@sunshineco.com>
>> ---
>>  git-rebase--am.sh          | 11 -----------
>>  git-rebase--interactive.sh | 11 -----------
>>  git-rebase--merge.sh       | 11 -----------
>>  git-rebase.sh              |  2 ++
>
> The patch makes sense to me.
>
> Thanks,
> Johannes

Junio, Eric and Johannes, thanks for the help!!!

I've created v5 with the two patches, what is the suggested
format-patch/send-email command(s)?

Here is one possibility:

git format-patch --cover-letter --rfc --thread -v 5
--to=git@vger.kernel.org --cc=sunshine@sunshineco.com
--cc=Johannes.Schindelin@gmx.de -o patches/v5 master..v5-2

If this was the first version then the above would seem to be a
reasonable choice.
But this is version 5 and maybe I don't need --cover-letter which, I
think means I
don't want to use --thread. If that's the case should I add --in-reply-to? But
that leads to the question. from which message should I get the Message-Id?

More likely I'm totally wrong and should do something completely different,
advice appreciated.

-- Wink
