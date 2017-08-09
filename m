Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02216208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 22:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbdHIWmO (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 18:42:14 -0400
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34612 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdHIWmO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 18:42:14 -0400
Received: by mail-lf0-f48.google.com with SMTP id g25so34015153lfh.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L/JuTAfbZBV3CTHa2X58R3Ry1oD4Z0ABPSTr3raC46o=;
        b=RPyVrJTBu1/7GCdiup/K8khr8CbYMkC8uaa8Y1WfmY8lwmgxtCFMrDtNCGX43dJDNf
         5akU72/5Gzxk8m/rdRbM+Owyx6KN7wIMf+2c+x7hVORei0+G5mpC0oklH9/bLOdT56pT
         J9ozF93z8OBAtRe+o7Mz34WwrnQHtfrLXZz2ZeegoBv1PXbxcgKT2Z8Ci9UtvM9C202Y
         ZyO74bh3eTwfMNhxAdEBjNyq7f4nrcD42YFCH3HH9O9i6M6ORLQ6wVO2omMViSxEkxyG
         Kl0vcw1gZq4w37/tiGeAIyGpN0QzG8EDqAaV7IgNX2DVcfTNYwNu59kyYx9cMwJTTA7K
         ajQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L/JuTAfbZBV3CTHa2X58R3Ry1oD4Z0ABPSTr3raC46o=;
        b=Xt81Ay1sqlaWJYXYAAZS6TKCyyHph//qVhtanMXTSxhhRwSCPrK6exCzS/qdgZBZcy
         ui6lu+RC9EqnLOo+VttuyTw9HieI7+BGD70W12cbG9r8yIVUJE3Z6cpb6kbJUTMqmp0X
         HlFAM0csWkVHr7Xntf9AWn1VLpF20zPIFYPdVbqxNH4QCRufUHVEo4lgCnJiP4iEwM98
         SIB/SvktnFYvfVOr3KIFOPVp7dpn8g9qFpE+7VUWplnEtr5PassFLKG8vRL4zb+AnfdI
         wgu8iGdNxToTVfLemdzxdNcdmEVFyAYJ1X67PVbiwUOb46IKlxGfmDejE3tew3glWi0S
         euyQ==
X-Gm-Message-State: AHYfb5iVfzwo2CamtKk4Wdyw1Z/FzOaZqH3ksl0+Rufld/WnPq7LPqEn
        0PF79LjMfQ1ys1iGqwFKdHGo/dMyXSPt
X-Received: by 10.25.20.68 with SMTP id k65mr4276776lfi.260.1502318532464;
 Wed, 09 Aug 2017 15:42:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 15:42:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
References: <20170808012554.186051-1-bmwill@google.com> <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
 <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
 <20170808182324.GB73298@google.com> <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 15:42:11 -0700
Message-ID: <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
Subject: Re: [RFC] clang-format: outline the git project's coding style
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>
>> I'm sure both of these things will probably happen if we decide to make
>> use of a code-formatter.  This RFC is really just trying to ask the
>> question: "Is this something we want to entertain doing?"
>> My response would be 'Yes' but there's many other opinions to consider
>> first :)

Mine would be 'Yes', too.

>
> I am sure that something even better will be possible: a Continuous
> "Integration" that fixes the coding style automatically by using
> `filter-branch` (avoiding the merge conflicts that would arise if `rebase
> -i` was used).

I do not quite follow. Is that to be used by Junio while integrating branches?

By the wording it doesn't sound like you think of a one-time shot to be
used in the transition phase from now to a clean future, but the "CI" would
run continually on all new patches?
