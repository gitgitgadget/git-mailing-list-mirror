Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48661F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 17:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbcIIRqR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 13:46:17 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:36203 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbcIIRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 13:46:17 -0400
Received: by mail-yb0-f182.google.com with SMTP id u125so31069308ybg.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wZM1TitSR7ik5bgnyxQaN2cA8CNQd5badg5mNy/pyHg=;
        b=eqL3PjHakObmdtShHpUpV3BNjepUFRopxnbHSNy+9fNQ1BMyMbolD1f+AAutpYqd0S
         nlTo1ITUj6jWXgTF2xpiNjCe7mw6WcZW7WbCBh19V8fN/GBu+SCg6irhDmEcI3clvRhX
         wCA+DA21kX/RhjNmBT1sP10iF1tQ3upCvfR943mxp5wkbIruV4hm5Sj/IimdOrZ4nurR
         +jqrveg00o6sz4ZEQFSQjB1veK6F7XQHwdxFRtOV5mtV76p43R8IBNJrEeio/TnpTJZ1
         BXZXQi7y/Rf5ALQLhCz3qQbOhscgdduVGjRXHbVqGhCfdzoeq6WDx8fT7GGZmvDDwZtZ
         1mkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wZM1TitSR7ik5bgnyxQaN2cA8CNQd5badg5mNy/pyHg=;
        b=ieNQB8LgwU86phdh9yEvBjHuts+kf0NIFmlrF8BWdTKEpkdFGr13wyYm0v/C9RJ+N5
         HI2h7lFWzm1TzXoJZa2FlvBx/GGJ+H+DqPEa5sZvJM3+bhAE/oHZq2LV7zpRtgvYT5Rc
         NljUGfXSElv9ORpZtnG/UDxzMGXWN54gyB4D6ZV2SwiI0OWl+1/YG6nlUKprmcxeLNo0
         F2rvYAVlrcWZgwQeOMe+b9VW3Pg7sVYZy2kfLpTnkAymkIyR22czOkxGysg5BXccr6q2
         UmFgmL/V+7vjn/C7QjJF184C/FDXjrV+23vg7SfPHPEOZ2h8S8YwbBMxvzo3ZujA0Lv4
         FnOw==
X-Gm-Message-State: AE9vXwOmhLbVGR/P7mpC51QJ7o9kqo9Dv1Jfw5pPmYpNArFvKvvujIsMs5ZyqYj4Toqq1sQ7sh83eyawsCf1fg==
X-Received: by 10.37.200.132 with SMTP id y126mr5694313ybf.5.1473443176157;
 Fri, 09 Sep 2016 10:46:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Fri, 9 Sep 2016 10:45:55 -0700 (PDT)
In-Reply-To: <20160909112217.gfalcbtiy2tzzhm5@sigill.intra.peff.net>
References: <CACsJy8CZf0O+uyQaeJ4gcx4XN8ivfFyni+3586WX_R2QM4XgVw@mail.gmail.com>
 <20160908134719.27955-1-pclouds@gmail.com> <20160908134719.27955-3-pclouds@gmail.com>
 <20160908200202.gmvpqrwwjavxmojb@sigill.intra.peff.net> <CACsJy8DmbdGODY+qT38OSkaegSpdO7yAt6e67sHB=_BT8Y7=_Q@mail.gmail.com>
 <20160909112217.gfalcbtiy2tzzhm5@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 9 Sep 2016 10:45:55 -0700
Message-ID: <CA+P7+xqDGjmSNdRjsMtBdZrXLeA2OfntgEELxgG5eSd6G2uwJA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t0001: work around the bug that reads config file
 before repo setup
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Max Nordlund <max.nordlund@sqore.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2016 at 4:22 AM, Jeff King <peff@peff.net> wrote:
> If you're curious what the fix looks like, it's in:
>
>   https://github.com/peff/git jk/config-repo-setup
>
> The actual fix is in the final patch, but it needed a lot of preparatory
> work to avoid breaking various programs that made bad assumptions (and
> in the process, I uncovered a ton of other minor bugs).
>
> This is just a preview in case you're interested, for two reasons:
>
>   1. I literally _just_ put the finishing touches on it, and it's
>      extensive and tricky enough that I really should give it one more
>      proofread.
>
>   2. There may be other related fallouts from the bug related to running
>      "git init /path/to/foo" when "/path/to/foo" already exists (and in
>      that case we _do_ want to read its config, but not the config from
>      an existing repository). This may all just work fine, but I need to
>      think about some tests.
>
> -Peff

I looked over the series and it all seems like solid improvements to
me, and I agree with the reasoning and logic. It's nice to also read
very descriptive commit messages that clearly explain each
improvement.

Regards,
Jake
