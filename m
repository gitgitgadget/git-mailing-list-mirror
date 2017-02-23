Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2E052022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdBWTNf (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:13:35 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36981 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbdBWTNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:13:34 -0500
Received: by mail-wm0-f46.google.com with SMTP id v77so7972882wmv.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 11:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XokYMLIfg9OXTlgugVgQPzI7VAIkrFD77mzwpcoNc2E=;
        b=JG9HT7I6MekvnMLcQ907ijR5tezKnSVX5RX/r5/a4K6FLboVGuo6enmYHdpXr0jGTz
         kTyql7ey+07QZONGsJhVBp+LVrpGRyH9Fii0N6b+NpbfW/FBEnt4iwtCsutVAwVBZthE
         SwlsGAPHiuXXPrq6Fu6XzlOa/FFrf6xsKMvRPdzFjcOx21EhP71PTMtc0LpYtoY59Czy
         K+8gwACaBFa11ccpT8lC7NoLXjFXIkKev5CkAEdgDCn9aIakdy/LGGwLeDkc+WzEjR8C
         8bAytnjaka3dp/u3KJybLLcEHa6oRBPq5fybMiheQZUObv2hJnMN/8OOc6Vf7zZo/1OM
         PlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XokYMLIfg9OXTlgugVgQPzI7VAIkrFD77mzwpcoNc2E=;
        b=Y1kQWXbt5rOcO1Z7eIAxQ5ECbY30vxf4xqToZ4MslYK1sRhpxKG510tPgi6RDnSia9
         DP/8iuV7DqAfq0qY7xyZE5y3zLeBCLKpvhI5nNVVtPSaF6pMcd3oSS0mhOCMc2rdaCjD
         EBGbkDL7bAGe9LIJ+atzBJp++WBAShjmDqIkEAdB0RJMSPMfDjehnP5MRx6IwsYH+lmv
         ulh+l1MIS4DNxBNGJ5X9dOSfk3l2TRjfiNdPSPRu6b8znItBttvTxy/hoV18VQsOW8rO
         n7wOtdd9GCWjsaG5d/gDYb3/k62qSovMmVb7BzWfenqQhFyT+T0SfUjR+wt2Ll/8pUqB
         yVpQ==
X-Gm-Message-State: AMke39lYX27rNueLoLTRoAWq2M+5iki/psbsyw8V+7GOsXuKMcubwi82GrFSO5+kdyt5ArJPtwvSCcGjMhHhLA==
X-Received: by 10.28.65.132 with SMTP id o126mr3768666wma.14.1487877212309;
 Thu, 23 Feb 2017 11:13:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.209.139 with HTTP; Thu, 23 Feb 2017 11:13:31 -0800 (PST)
In-Reply-To: <20170223183105.joxtpbut4wcqfbtu@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net> <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net> <20170223183105.joxtpbut4wcqfbtu@kitenet.net>
From:   Morten Welinder <mwelinder@gmail.com>
Date:   Thu, 23 Feb 2017 14:13:31 -0500
Message-ID: <CANv4PNmSjJUhFgC7GhpuBjiSQhwfAhrP8WxiP_siP2AjjXnrnw@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The attack seems to generate two 64-bytes blocks, one quarter of which
is repeated data.  (Table-1 in the paper.)

Assuming the result of that is evenly distributed and that bytes are
independent, we can estimate the chances that the result is NUL-free
as (255/256)^192 = 47% and the probability that the result is NUL and
newline free as (254/256)^192 = 22%.  Clearly one should not rely of
NULs or newlines to save the day.  On  the other hand, the chances of
an ascii result is something like (95/256)^192 = 10^-83.

The actual collision in the paper has no newline, but it does have a NUL.

M.




On Thu, Feb 23, 2017 at 1:31 PM, Joey Hess <id@joeyh.name> wrote:
> Joey Hess wrote:
>> Linus Torvalds wrote:
>> > What you describe pretty much already requires a pre-image attack,
>> > which the new attack is _not_.
>> >
>> > It's not clear that the "good" object can be anything sane.
>>
>> Generate a regular commit object; use the entire commit object + NUL as the
>> chosen prefix, and use the identical-prefix collision attack to generate
>> the colliding good/bad objects.
>>
>> (The size in git's object header is a minor complication. Set the size
>> field to something sufficiently large, and then pad out the colliding
>> objects to that size once they're generated.)
>
> Sorry! While that would work, it's a useless attack because the good and bad
> commit objects still point to the same tree.
>
> It would be interesting to have such colliding objects, to see what beaks,
> but probably not worth $75k to generate them.
>
> --
> see shy jo
