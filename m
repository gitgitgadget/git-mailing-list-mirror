Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ECF820193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942155AbcJ0VkF (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:40:05 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35989 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933724AbcJ0VkE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:40:04 -0400
Received: by mail-yw0-f180.google.com with SMTP id u124so62720908ywg.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 14:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3Dw86T7JmKIdvyifpD8zE+mktZLWHgQxpFMHrHl3Rz4=;
        b=L0X9aphbiTuR1x+anck9Qvvg1Dpb97zolS4EKNK+QvreE3wCq7ucDNGi+EAa7cJ5dI
         GocNx5W2JWvylCv1UppaJymzHQ/JT1ffCJg3iLzi2sS4T/g5R6acTnZwmHKrQII5/8BT
         CY/VYS9sVlVftRlT6KOXQPoJkr2JHMOPhtJPybsXysL5MeFtemKSmOug9NLtXALuanRU
         NpgiwjC06j0CoN53onkyxvtKydP0skJV9qMVPYuNnYXv2cg/9feKFK5Pe+YRa4Af+IWM
         +AcoArH8DGUgCoWol+qtvqOh9aDbmaj8AD9fTWycStoA8VDfBGpdlhVLuorMeRAJ/KOl
         5veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3Dw86T7JmKIdvyifpD8zE+mktZLWHgQxpFMHrHl3Rz4=;
        b=ECVetQX5KPrq6FYyl1p0O2uPa2+2KqMni4MfWiVx5ncE7v6R371sS04WbTX6tD8LSG
         tKFGkYtRlR0AKWu8L+/Q7yHhbaQFwBc9/y9DqdmJZTYLskzabe5mdzN63B+TAjwb20cj
         8+RSD9BSvy6PZLgBrojTn2eOaABE+KNONEX4japuIqTwpF/JshcVax2cdiPFLvKYpmsV
         qp4qokYIFCiM+m0pdHolVOepFKHti710qIVEmXsdsmDpuEWMIe5V5rz7uZJ5qVm8ll9H
         Lairy5luNgIO6AG3+Oa7H44R+194vwtROysQcQzsj3mRNy+ZA1hGfhUZlYyUX+9HgFoV
         wo3g==
X-Gm-Message-State: ABUngvfeealkiplXFlAhU9erWsc2iIeWed5eWB0DJGlIDSJkN5A1Z3Af9kny/+VR/pE8zJEfKicfBCXvI7OGfQ==
X-Received: by 10.129.102.85 with SMTP id a82mr9306646ywc.160.1477604404006;
 Thu, 27 Oct 2016 14:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Thu, 27 Oct 2016 14:39:43 -0700 (PDT)
In-Reply-To: <20161027210458.ptzh4y75dkfaixeo@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net> <CA+P7+xqmVM-bEc7sZcn+p3qhFUUJvC+rko7CYu+KgyTAeiOifw@mail.gmail.com>
 <20161027210458.ptzh4y75dkfaixeo@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 27 Oct 2016 14:39:43 -0700
Message-ID: <CA+P7+xrEz7XhZ4fHYUA7gjJtbW8WUEWQhtpAQ+zMC9nVE135iw@mail.gmail.com>
Subject: Re: Expanding Includes in .gitignore
To:     Jeff King <peff@peff.net>
Cc:     Aaron Pelly <aaron@pelly.co>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 2:04 PM, Jeff King <peff@peff.net> wrote:
> I'm not convinced this is needed for in-repo .gitignore files. The point
> is that you are pulling together separate files that may be administered
> independently. But git repositories inherently have a whole-project
> view. I'm not sure that separate files buy you a lot there. And the
> compatibility issues are more complicated.
>

I had just assumed it would be used everywhere, so I hadn't really
considered whether that was any reason not to. I personally like the
idea of splitting my git ignores into separate files just so each file
can be about one thing, but I guess it's not really a problem either
way.

> I do agree that:
>
>   cd .git/info
>   git clone /my/exclude/repo exclude ;# or exclude.d
>
> should work; ignoring dotfiles when reading the directory solves that,
> and is a pretty standard solution.
>
> -Peff
