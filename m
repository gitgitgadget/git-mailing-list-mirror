Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25CAC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 07:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237097AbiA0HGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiA0HGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 02:06:16 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D240BC061714
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:06:16 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e9so1514807pgb.3
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 23:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/qg6/bJ/Gtm8o26duCTLdQRgFY9P0BtWj3rn+ZGE8pI=;
        b=alfXWiVHrS9SU1SUARuTBO5ElEIy6ZpbQCY8UQGNeSHR9HKvbJtAbGxIDZOnf4AGVe
         19SCLVAetbIYTo4um0jkCPlEiKibBU2aMcubV8Uw7rh5cGBv9hEBPcEKcKV8F08My1ky
         TgYnD7EOaM+t1VULrSvDY5UY/VH86EvMUCEa6b6EPoXIy18W4wjY+DICCJNs6rjdXeZV
         cHB2zSmc+mwzkeYB3gvQLsTNrG316e/sgFXAufiP/Fq7+Igv8HJLFJFPZZAWfu6trTVL
         w4v3+phBDUjSkd34/P51L9ffMONM7To7KdYXz4hsuDp3m9KZWLFfmGVRkOnDa0EAUutV
         2Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/qg6/bJ/Gtm8o26duCTLdQRgFY9P0BtWj3rn+ZGE8pI=;
        b=MwJIMR6yHeNIG+cG853TPQERfQ2fwZ800+i/zsfBPXbsXIgq7saSNuEdnUUJdbqUVv
         e+YwSbjKWFg6QiDE51mKJNBK+BySJddNtsAf6foLIJ9c19R2ujTbvrDDo7B8G69INMHi
         HmRLdCIAhs1PlSfYDXgA3JInefn7p3goZxJCE34DXrjA7klq/5oSRVPCZlUveT9emAxa
         cA3KUcH4JG0WV2k+anigPRZ0opGGE5GRG+JAEhEN5UiZLlVFaput7U6+ZJkHw/wtIyA0
         8//IdETZySWpXo5v2JtIPh6DhRSGB5Cs1yBlYGs5cu56C3RpkcwOb0wQ4F9XQT37eSuF
         ln4w==
X-Gm-Message-State: AOAM5337YuK6j4d3W9rd7Hm6IhzUGByhR2U5aXQM2gRJcYshR25KCIWw
        Oz/000SZsZk6QKvk+8XQEsiJXnji++W+KKpMIQ1o/wND
X-Google-Smtp-Source: ABdhPJwjRbd8j9/FK7vDpLecCHuCJA9e91U2QNNe31M5EulbSKghxCMRaUOghSPYtdNiA9mO+PFnh+5tmC7qv8vgC2s=
X-Received: by 2002:a63:461c:: with SMTP id t28mr1807049pga.567.1643267176129;
 Wed, 26 Jan 2022 23:06:16 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8kYP2Sth+vUZMzHujKQZC6r1kFf+Lz=6_WRs4GFR65B9g@mail.gmail.com>
 <xmqqr18t4sc0.fsf@gitster.g>
In-Reply-To: <xmqqr18t4sc0.fsf@gitster.g>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 27 Jan 2022 02:05:18 -0500
Message-ID: <CAH8yC8k53a4xcDh34XqoA0VCcxG+Y+mE-rb1MKMd_Z+r-t=_Bw@mail.gmail.com>
Subject: Re: WARNING: terminal is not fully functional
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 27, 2022 at 1:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jeffrey Walton <noloader@gmail.com> writes:
>
> > I needed to install Git on Ubuntu 8. Git seems to work Ok for most
> > task, but this is unusual:
> >
> >     $ git diff
> >     WARNING: terminal is not fully functional
> >     -  (press RETURN)
> >
> > Here's the terminal:
> >
> >     $ echo $TERM
> >     xterm-256color
>
> A short answer.  You are using "less" as the pager, but it is not
> working with your terminal.  Likely reason is perhaps you are
> missing terminfo/termcap database entry for that terminal.
>
> I have working xterm-256color, so
>
>         $ TERM=xterm-256color less README.md
>
> works as expected, but using a (bogus) terminal that no system would
> have ever heard of, e.g.
>
>         $ TERM=no-such-terminal-exists less README.md
>
> results in exactly the symptom you are observing.
>
> Something to try quickly would be:
>
> $ export TERM=vt100; less README.md
>
> As the termcap/terminfo entry for vt100 is usually more widely
> available, this may unblock you.
>
> > It seems like loss of colors on an old platform is not that important.
> > However, the message being printed creates an actionable item that
> > needs attention. I think no message would be a better option.
>
> You would want to redirect it to folks who work on "less" ;-)

Oh, sorry about that.

Jeff
