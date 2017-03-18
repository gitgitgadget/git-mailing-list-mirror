Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152D72095B
	for <e@80x24.org>; Sat, 18 Mar 2017 14:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdCROs4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 10:48:56 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:35295 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdCROsz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 10:48:55 -0400
Received: by mail-it0-f50.google.com with SMTP id m27so49728359iti.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1f23w3oyK2C9tlK/9U0jt593+h+FXzDHtIRZI+iK08A=;
        b=h6bSBCFbWlIgpHX0TTGDCxoWC1UjF0mbg1V6uWseOOUzIwaWbyGdCvEP8w8COqYcWR
         coanHanM69ACX6U5zD6U1puJghSfY9I7MDNxO2XGWdKxW9Zzriz31PMKqat1TpSSfFdK
         9Huve8gs4aZbVSPpPyQPJDglyurjXmNMxPgH9LEWL+f9GsX77KpeSnglfW3U/zt8TVjN
         NGVaqUwX48PtWGBBzad04tXn1bXpx90kYa4/yJNA0bqAKRrWQpeZxL/lwzwbVTDtoEnk
         RXxh7WAbi1bERlZgDDw9v3LODLzjbaqy8pUPG91Q40vST0XCwKMRwrMjioUPCjyDuFxw
         KHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1f23w3oyK2C9tlK/9U0jt593+h+FXzDHtIRZI+iK08A=;
        b=Y5IVm6hB604y0d6seGpKfF8TQIpUR0kcGm3SVZJ5wZzYXE56SN5tXL0+Q9LIQM7pPX
         MDnzzce43BzEHfrwecGizXwujdAVGPoii1MoNA23/niDKSJB7J7g1FJfeSQ9IsQfnTl/
         VDteqgrevVGuX4nt9GPIqqSnhj1RYuCwB7f+/Yc8121nv9aMj0fmd43MhRzFyWEAOzFs
         s9wO5mIjpIgKTnI1SchaIr+2OqOybl8XxDKD/jhU6BCFrlH/Kydx9q+78d3Jt1DYaoqU
         yce1al+fvitx8ic76wooSQiYsEQ87ZSFGr8458GGz8omZG6ayGUiFp6TB69NsC3avXv6
         0h7Q==
X-Gm-Message-State: AFeK/H29V4qkjgJWsu8JSp6jY5SaWtvUR/+0pi06Fw3KQCpacxi1g3/ks+SuXbPP01s5dVBBOXWDOBfnIiL2Rg==
X-Received: by 10.107.57.2 with SMTP id g2mr22099012ioa.117.1489848526351;
 Sat, 18 Mar 2017 07:48:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 07:48:25 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
References: <nycvar.QRO.7.75.62.1703180724490.3797@qynat-yncgbc>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 15:48:25 +0100
Message-ID: <CACBZZX5FMdjuxxNru+XfTQdSXEQ_b0OP2rngGZLf1sSHR_D8Ng@mail.gmail.com>
Subject: Re: Is there a way to have a local version of a header file?
To:     David Lang <david@lang.hm>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 3:29 PM, David Lang <david@lang.hm> wrote:
> for an embedded project built inside the Arduino IDE, (alternate firmware
> for a home automation project) there is a need to set a number of parameters
> that we really don't want in the main repo (wifi network IDs/passwords)
>
> right now, we have these things set as #defines in a header file.
>
> We need to distribute a base version of this file for new people to get
> started.
>
> Is there any way to have git define a file in such a way that if it doesn't
> exist in the worktree it gets populated, but if it does exist it doesn't get
> overwritten? (as I type this, I'm thinking a trigger may work, but we need
> it to work on Linux, Windows and OSX)
>
> Any thoughts on a sane way to handle this situation?

There's no sane way to do what you're describing without renaming the file.

But the sanest way to do this is to have a config.h.example

Then you have "/config.h" in the .gitignore file.

And you tell the users to copy the *.example file to *.h, and your
program then includes the *.h file.

If you wanted to provide defaults you could just #include the
config.h.example first, so #defines in the *.h file would clobber
those in the *.example.
