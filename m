Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3394F207BE
	for <e@80x24.org>; Fri, 21 Apr 2017 12:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1038281AbdDUM3M (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 08:29:12 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:32965 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1038248AbdDUM3L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 08:29:11 -0400
Received: by mail-lf0-f41.google.com with SMTP id 88so44086517lfr.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t4BjKZE2LGQzbbkBTwm96/BglOjLtl/qiBjXLkjOSh4=;
        b=gbTXtxIFwTzA83C3aMZ1d1ikIhVlYeec9CXLHQeB6KFdqGZvHvLrLodg14msQAcvSH
         boNlyvv3ztS2Zr4cgnv0gJqyDHGDEDblcyixKcp10+Zd3GaAn2h71dEas1ZgmJQwXj+F
         rWydIZE9RZLkb+D80/BcFtlAIovTGTYMZ9brnnDB/FvqMSXhR6AvHvbiNWSh/3KGO/0/
         uLED8anlDRaNadK63RR1cRJvkHevAuiatgFKKGuQ893IbZEzrhpM0CbdoTzCF+l8WV3t
         RRQEHHqEEcVHVRO92pNeStV+bWUonUCaSPHy5CP6qZEOKm/wKnEBvN/hXkjTXf/xI3Yc
         9rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t4BjKZE2LGQzbbkBTwm96/BglOjLtl/qiBjXLkjOSh4=;
        b=dO4QX9ikkdC0djAmJGenXhFIOrXweOUo7SJCOTqLTHjvmaNl8wArcRrwzMKeAiAgYl
         CPJKtRDp7CfqMD5/XN+Nf/Ak3wtnbKSC6vvulLL+MKLqsnMYy1Not4d/xe+fhVFDhsgz
         g/UOTy6Eyyepuh3TfbqWi+fi5kGX6PEjE+olW37vQ/aTLwN+s/Ryka4mfrvGprrqxihZ
         NfjhMECo8rmVdu2JCCwkEgAhKMLghMV2CwBlNnwaBpUSW+l9p43uTRi4ZXXTIpgol1G5
         GLVxLA1xAfFdDkd0H23rQsEl/mkUSh7N3YOcJXgvR4uxT8P2B6gAt5YQ0Lfn342OegWa
         ZRoA==
X-Gm-Message-State: AN3rC/52e+XfybCgEySfmCL+XwloW7sZWf1GrphhAeM5xAZMWAns4yTJ
        LdRXgBN1/trCSOwCT8FPkqagKBDCCQ==
X-Received: by 10.25.152.74 with SMTP id a71mr4753475lfe.164.1492777749515;
 Fri, 21 Apr 2017 05:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.67.78 with HTTP; Fri, 21 Apr 2017 05:29:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704211135430.3480@virtualbox>
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com> <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
 <xmqqbmrq8z4j.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704211135430.3480@virtualbox>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 21 Apr 2017 14:29:08 +0200
Message-ID: <CAP8UFD19DVqQLHBta74uLcFPwJaRUKF8Ppmnhct5ub=OkKSqCQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 11:50 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Since that "let's aggregate everything and only push out the final result
> at the end of the day" approach does not really allow the Continuous
> Testing to identify problems associated with individual topic branches, I
> have another job that bisects the breakages

Great!

> (with all associated problems
> I reported earlier, as you apply some patches on top of really ancient
> commits and bisect wants to test all merge bases first)

First bisect should ask you to test merge bases only if there are
"good" commits that are not ancestors of the "bad" commit.
So I don't know how you want to bisect, but it seems to me that you
could just go back to a previous know "good" commit when the one you
have is not an ancestor of the "bad" commit.
This would get rid of the whole merge base problem.

Second yeah there is probably an old bug in bisect there. In theory in
most cases bisect should ask you to test only one merge base, as:

- if the merge base is "bad", it means that the bug has been fixed
between the merge base and your "good" commit, and bisecting will
stop,
- if the merge base is "good", it means that all the merge bases that
are ancestor of this merge base are also good, so there is no need to
test them

But that theory can work only if bisect is asking you to test a merge
base that is a descendant of many (if not all the other merge bases),
but unfortunately I don't think bisect is smart enough for that yet.

> because the
> required time *definitely* would let Travis time out all the time. Those
> bisect results are even less visible than the Travis results, see e.g.
> https://github.com/git/git/commit/2e3a8b9035a#commitcomment-21836854.

Nice that they exists though!
