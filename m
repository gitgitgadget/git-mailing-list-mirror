Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73D961F424
	for <e@80x24.org>; Sun, 22 Apr 2018 20:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753650AbeDVUSA (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 16:18:00 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36731 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753611AbeDVUR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 16:17:59 -0400
Received: by mail-pf0-f170.google.com with SMTP id g14so7483828pfh.3
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ijdYAS3D506tIBmPPZuAWxfJgcWU0M/V+5SGUPJ2fCE=;
        b=fmRj5st7dwo6TAjeZWixBVeiZwTp4OMuMyw0BB/+0ZVfScsSLHOH1fWe7lWZLc2n6K
         aNCfGX8Q/iGBT1xdP61WU18HDjJ7G4TUJZDtMptzI9bQtvARh1iFqCjuPBW9XQc8ng55
         0DV4fdt0gMfsYv9pSnB9o9AqAsRtPi2elxToCWrwip63MRTN4Uwl/Khq2vkFZ3rZtDmC
         XV5bHw+HcHRxenANUT58vmhX8s2tNwWQiJHdbrVJksST0cLAcF2x2X4vRdeGPPS1bW5k
         qoKKqAwkMo5KZGkVKGICQ+kMupRTas8UqzQwgSCM6My+4sgH0SSNxirDLML5/+rlQ76q
         C82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijdYAS3D506tIBmPPZuAWxfJgcWU0M/V+5SGUPJ2fCE=;
        b=btWeTOn0iyfNiL8mopX91Rvsw0ClHUwLd9l03IgS4KKmWg+MHeSzpRIj9VghzVTUu8
         2V6lBwZ2fqzSUgCEGmOdf6Jh4qU7EZStywEpsheMER1Thq1puSzIOjJ76pWH+L0G+Qem
         nnijjEgC7ZOVcGz9VQBL5vQFxubh/SArks+g9v3dVGdvo+hBNDPM+US/2QLYO3p/KHz3
         WUcn8ggdEL48/OfOm3f0SviI7n4tJvfIWinIgPt5GOY3jc2hn81J2VlVx36wOHRkwv57
         Gpzeg7vvKm7Rx1bjKuGXwew+R8oFOnfXcueMK1GaoVLKURwaq4CxmyM/pPNE00c6flPc
         5HWQ==
X-Gm-Message-State: ALQs6tCihf139Iw1TJfBBiD2alggXjOqW+miVPskeu42wri8xPYfyume
        iHR7OrQJQqj9t3dsLrsHpwCWaw==
X-Google-Smtp-Source: AIpwx4/1xPXxR2ShJjQER603siePoQYWy7wRbFQ4P7uiA961+6lk3rMA+Wt3MBmj1UD6QdiuhjjJtQ==
X-Received: by 2002:a17:902:42a5:: with SMTP id h34-v6mr18199517pld.65.1524428278452;
        Sun, 22 Apr 2018 13:17:58 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:e8b3:eaad:c134:baec])
        by smtp.gmail.com with ESMTPSA id r20sm6768457pgv.0.2018.04.22.13.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Apr 2018 13:17:56 -0700 (PDT)
Date:   Sun, 22 Apr 2018 13:17:55 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
Message-ID: <20180422201755.GA92212@syl.local>
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 03:07:46PM +0900, Junio C Hamano wrote:
> * tb/config-type (2018-04-10) 2 commits
>  - builtin/config.c: support `--type=<type>` as preferred alias for `--<type>`
>  - builtin/config.c: treat type specifiers singularly
>  (this branch is used by tb/config-default.)
>
>  The "git config" command uses separate options e.g. "--int",
>  "--bool", etc. to specify what type the caller wants the value to
>  be interpreted as.  A new "--type=<typename>" option has been
>  introduced, which would make it cleaner to define new types.
>
>  Expecting a final reroll.
>  cf. <20180411034941.GA63158@syl.local>
>  This looked more or less ready, IIRC
>
>
> * tb/config-default (2018-04-10) 3 commits
>  - builtin/config: introduce `color` type specifier
>  - config.c: introduce 'git_config_color' to parse ANSI colors
>  - builtin/config: introduce `--default`
>  (this branch uses tb/config-type.)
>
>  "git config --get" learned the "--default" option, to help the
>  calling script.  Building on top of the tb/config-type topic, the
>  "git config" learns "--type=color" type.  Taken together, you can
>  do things like "git config --get foo.color --default blue" and get
>  the ANSI color sequence for the color given to foo.color variable,
>  or "blue" if the variable does not exist.
>
>  Will wait on the tb/config-type topic.

Hi Junio,

Thank you for picking up both of these topics. I sent a final reroll to
tb/config-type, which I see has made it successfully to 'pu'.

I noticed that tb/config-default, however, only landed two commits:

  - builtin/config: introduce `color` type specifier
  - config.c: introduce 'git_config_color' to parse ANSI colors

but not:

  - builtin/config: introduce `--default`

As such, I am able to build on 'pu', but the `--default` option is
missing:

  ~/g/git (pu) $ ./git-config --type=color --default red core.doesntexist
  error: unknown option `default'

Please advise.


Thanks,
Taylor
