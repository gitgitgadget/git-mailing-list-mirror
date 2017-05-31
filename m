Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E0111FD09
	for <e@80x24.org>; Wed, 31 May 2017 21:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdEaVKs (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 17:10:48 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34981 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdEaVKr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 17:10:47 -0400
Received: by mail-qk0-f173.google.com with SMTP id 19so22387198qke.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edmodo.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zIXbu6vGgBCQYRF6e7XFfhUCwkigKC+UwxBcGAeo+IQ=;
        b=jp4Rl/Roe1mtoOv93UPoPY0Auq/d7Tl6UjH8Ag2FqWdOVDSjSChpt1DAKm8jtZbEKg
         orSttZUIkVFoHVGAL+n0s6IcShEdN2nExtw3sRB5Jd4t7ERu1oTjadyFJIEIO6vRHsH9
         e8Qt6Lhh3Xnc3McbFvWXCfUUvWBGPHN8lAdCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zIXbu6vGgBCQYRF6e7XFfhUCwkigKC+UwxBcGAeo+IQ=;
        b=Gj5MmGL2Tp47VytbutuhohPTvuRmXWJPFkSuOEPsQsIxR53fErowybE6xxbQ86Ba8T
         JgApmJWP+qmXL0IajK3Eqp2dj7/vF1HGQ/feXJ27tToKIsut4iNdgs2lBeiVoHC7Hx2G
         gd14Xlf+tLOHp1bR3evWHWfFJ8DEtZVRUEtaR4CxS5gzotLjw2vTAs2my8ZVc/Zx62Dc
         ZGHZ7fEfiV1zS/7yqVC7Al/p+Kz/pdofBbb9damT5LZoitEtPvLKMr3W4shxgs30s+jQ
         5UzE1xK//qHMdZZc9IU5XyCXc51PliIkpHhQ+8zWhNkb4cyCbxeVgrAlRwfvL1AwNSF3
         p7cA==
X-Gm-Message-State: AODbwcD7aAcf5XgnHXbA1GCb8sUczI9hJQ232tWOWDekzpg2jazBjgOM
        I/Qftvt64ZJis+oOe856mfgqJsUhT7i4wp4=
X-Received: by 10.55.99.131 with SMTP id x125mr4724838qkb.17.1496265046794;
 Wed, 31 May 2017 14:10:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.147.44 with HTTP; Wed, 31 May 2017 14:10:45 -0700 (PDT)
In-Reply-To: <20170531210448.6kolid5umzyasxnc@sigill.intra.peff.net>
References: <CAD1ypiWOcKaLJJzZC=gw75EDFnw_1ZqC94B5p9i722T-sijN1Q@mail.gmail.com>
 <20170531210448.6kolid5umzyasxnc@sigill.intra.peff.net>
From:   Irving Rabin <irving@edmodo.com>
Date:   Wed, 31 May 2017 14:10:45 -0700
Message-ID: <CAD1ypiUDOtnKwctNQCHmxviPzkDPeP8FT_W2XEXrpHsfgC5Bhg@mail.gmail.com>
Subject: Re: Coloring
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Jeff, my problem has been resolved by Samuel Lijin.
My terminal settings didn't set bold which remained white. I fixed it
and my problem was gone!
This issue is closed. Is there any way to retire it?
Irving Rabin
Software Developer @Edmodo
408-242-1299





On Wed, May 31, 2017 at 2:04 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 31, 2017 at 11:33:31AM -0700, Irving Rabin wrote:
>
>> Specifically, if the field is supposed to be white, it doesn't mean it
>> should be literally 0xFFFFFF. It should be the color that I have
>> configured as White color for my console emulator.
>>
>> I like light-screen terminals, and I configure my ANSI colors in the
>> way that they are clearly visible on the background and clearly
>> distinct between themselves. In my terminal settings background is
>> light-yellow, Black is black, Yellow is brown, Red is dark red,
>> Magenta is purple and White is dark gray. I set it once and I can use
>> it everywhere - all Unix commands work correctly, I can edit
>> highlighted source code in Vim, and all my color settings are
>> respected.
>
> Git outputs ANSI color codes, which are interpreted by your terminal.
> You _can_ configure Git to send 24-bit color codes if your terminal
> supports it, but by default it uses the traditional set of limited color
> and attribute codes.
>
> What does running the following snippet in your shell look like?
>
> -- >8 --
>
> while read name code; do
>         printf '\033[%sm%s\033[m\n' "$code" "$name"
> done <<-\EOF
> normal
> bold 1
> red 31
> green 32
> yellow 33
> blue 34
> magenta 35
> cyan 36
> bold-red 1;31
> bold-green 1;32
> bold-yellow 1;33
> bold-blue 1;34
> bold-magenta 1;35
> bold-cyan 1;36
> EOF
>
> -- 8< --
>
> If any of the colors are not what you expect, is there a pattern? E.g.,
> I wouldn't be surprised if "bold" shows up as bright white. In many
> modern terminal emulators, the bold variants need to be configured
> separately from the non-bold ones, and default to lighter variants of
> their non-bold counterparts. The solution there would be to check your
> terminal emulator config.
>
> If it does all look as you'd expect, try adding "| less -R" to the end of
> the "done <<-\EOF" line. Most of Git's output goes through that pager
> (though I _think_ it's mostly just passing through the ANSI codes, so it
> wouldn't have any effect).
>
> -Peff
