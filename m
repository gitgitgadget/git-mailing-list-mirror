Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85881F453
	for <e@80x24.org>; Sun,  3 Feb 2019 10:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBCKhT (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Feb 2019 05:37:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44962 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfBCKhT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Feb 2019 05:37:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so8175313lfe.11
        for <git@vger.kernel.org>; Sun, 03 Feb 2019 02:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZrlUvQDu/Oupke5U+0kkxnX3uivk5A4VIbiRVnufCw=;
        b=fqZfY5I30057wW6LJ5Ic3RPCVHwYZ5BM007usnkh18nDZDuC2li5jHrQ7M+1r9D0cu
         5WQlt5A0Zd8b5iAxS4SCedCDlApeTZBQTL62xnZEaqWjj4ImHDB2H9h/mQBsRn98ZhGi
         lZ6TVPRTZLqpkzGC5k5Ltq7rLohE80j0aSoXZkQPM0Cc3PODS8LJuGVFmbBUcgYBOVQe
         weMl8X7XhA3DaAD4HZAryOWDUaQXB21CvRJgOAYiXSvZxfhgOe0oQTv7YbTtznMheep6
         JFp6DelPxOGJLTq7+es5PEq0sYqdU62WZPw1hUdgE1eQWKYEelsR0gz6sxLnQwaNApqZ
         AfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZrlUvQDu/Oupke5U+0kkxnX3uivk5A4VIbiRVnufCw=;
        b=WFG8B05YcBXEo0wTc70zDcqu07+SZbAZ97FzOLFabyQB16wbwnHQWlFOqDK1B8la6P
         K+NYb/lQw996Lrgn6Qo3Luc2ufoPADVtIy0cEZ2oqD6VpDXLsv8MAc5MfC6kM3cfl9Ff
         Yr8ksTMdk9h790l730yE+SQixIzHrLQeqygyPFwM2UUoIgTI8RoMZROeVziAzA0OOyXh
         htF+Z7t99VfJOA4pUImKkT01FLhOXiEo4pUv2emDhdZ8CWu7cTmnnFEnk2BuPHJil02e
         iuCI8rfp3uePJvu56hW0HSTGWSvaSlg8jWC2/q1CNt7z8DGfmaV1pa0z6vuEAY9/X/+i
         xzfw==
X-Gm-Message-State: AJcUukeRqy3+mmFwZeb7DTQKz0swJKhLvxvhbY0bZIRGS0S8GXzqsYyA
        T18M007lP1aj1Y7WKuf7MhLR+9IJa3CMU6rDe2jFTXwDBvg=
X-Google-Smtp-Source: ALg8bN44tjNsH+zaEtOtVo5v8KhjADlmzCclW28mGqouryX//aydpzER4+u92TJmhO1S3LrbfCEDVMEPGkx5DPTBkWA=
X-Received: by 2002:a19:920a:: with SMTP id u10mr29823461lfd.122.1549190237107;
 Sun, 03 Feb 2019 02:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20190203083545.5877-1-martin.agren@gmail.com> <CAPig+cRN_Jw_vj5=RWZJWp-Wn6-=Vd9oZKQieMWJ02TjAHWwWg@mail.gmail.com>
 <CAPig+cQYuwMmyw8_p863BeSU5RP-xdB=HFMa7EM4G3YALQj3_g@mail.gmail.com>
In-Reply-To: <CAPig+cQYuwMmyw8_p863BeSU5RP-xdB=HFMa7EM4G3YALQj3_g@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 3 Feb 2019 11:35:43 +0100
Message-ID: <CAN0heSohuL=TBOLR+Q9=zrGhZrrjSgfvA=VeT-aA0gr57onAsg@mail.gmail.com>
Subject: Re: [PATCH] doc-diff: don't `cd_to_toplevel` before calling `usage`
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 3 Feb 2019 at 10:12, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Feb 3, 2019 at 4:08 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I wonder if a more fruitful, longer-term fix which would save us from
> > having to worry about this in the future, would be to make
> > git-sh-setup.sh remember the original $0 before cd_to_toplevel() and
> > then employ the original value when usage() re-execs with the -h
> > option. That would also avoid the slightly ugly repeated
> > cd_to_top_level() and 'tmp' assignment in this patch.
>
> By "original $0", I meant a path which would be suitable for
> re-exec'ing (which wouldn't be the literal original $0). Sorry for the
> confusion.

I thought about this, and I probably should have said something about it
in the commit message. My uneducated guess was that "all" other users are
in $PATH and aren't being called like `./foobar`, but just `foobar`. Or,
they're internal helpers where the caller has already done the grunt
setup work, so their cd-ing is a no-op. I could be very wrong.

To be honest, I wasn't very tempted to risk breaking git-sh-setup
only(?) to help a development helper script like this. But let's see if
I can spend some more time on this...

The only way I'd know how to do something like this would be with
readlink or realpath. Judging by d2addc3b96 ("t7800: readlink may not be
available", 2016-05-31), we can't count on readlink. And I'd expect that
commit to have switched to realpath if THAT were available everywhere.
That commit instead goes for "ls | sed" and notes that "[t]his is no
universal readlink replacement but works in the controlled test
environment well enough."

Ok, so I am not too eager to try and tackle this with fallback
strategies and what-not. What would you say if I punted on this? I could
add something like this to the commit message:

  A more general fix would be to teach git-sh-setup to save away the
  absolute path for $0 and then use that, instead. I'm not aware of any
  portable way of doing that, see, e.g., d2addc3b96 ("t7800: readlink
  may not be available", 2016-05-31), so let's just fix this user
  instead.

What do you think? Thanks for your comments.

Martin
