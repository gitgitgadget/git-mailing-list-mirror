Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE941F403
	for <e@80x24.org>; Tue, 19 Jun 2018 23:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeFSXi3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 19:38:29 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:37139 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbeFSXiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 19:38:22 -0400
Received: by mail-ua0-f201.google.com with SMTP id z33-v6so470607uah.4
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 16:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=p3nS0li4cya7dXse2TgqhbUZCasGEKxSTUWPzNd9V5w=;
        b=PJcDHKgooVRyTKWvVGZCX6wUbQOqg47vBPf0sYk/fEmFoWkF4K0piYujJ1X/ns7NBq
         cDwgif4H0eIGHWfiLzr+M1xKkhKf7z0Ovea/94qBWwCTf5wEf80f7B/eUdYm6PG9YDKn
         pID2JiG0lsLVTsXQjpoV3qNJDBP9yrVHyduDpjnMZURh/3bYDKkuMB+JXF7ofV2rcayZ
         0MQreO7qt2PUh9XgblW5Sly9g/xfKPQF9IVIVoMpgBFVweLnZYUBnY9Pfek7WX451E1j
         zofV6Bt5xA87cwFsadI1OO99PJ2ZG4mzzNs0YRuEPnTX0ieHUPFXsibI//8hkU2tRhi/
         BuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=p3nS0li4cya7dXse2TgqhbUZCasGEKxSTUWPzNd9V5w=;
        b=kdqBn0/v8ZFYfN3baYbG7MRvwHjnhJ3PFxAyUMzF9RJlSXaOuOmep6Hq46/6heaRrq
         T+OC4n/eJZO8lipo8+r5jBt4r1Ph7rfVnJ8EDYK5srDsuzKi2a1yilNvbKA6TWqRDmCS
         S1gFKQ6Pys/HxfIWQIfHk1flefedsp3DhI5wj18OdhTmyiroM2MuqY4r0uuomc2+M2+C
         mKgY0d7Hl9ZgrJjitbCjVmG7cANPOFqlxSvxNqX4RUkR/OKnQTAU5TSC5MJge/OUh3qv
         z14l7iUmGwncCcCTR55qpjcLe9Ej3C+4q0pYH0XyMTiuAajW1FEyy9jgFc9rp1zcgonQ
         6CIQ==
X-Gm-Message-State: APt69E0ah2gtQS7CVPvQGFSyTonLd1wHjrVG4Y4+7w/GOauWNwivyYeK
        HAf2GcVtCiyVd0tlDyN1E/Ev7dRlUy3DuD6iPJjF
X-Google-Smtp-Source: ADUXVKILJAQUAMBbl0i0MaEL2BK1vc7ej7QIerrqX8PY739PdysVgbfK/uElPwt3/sy+w8Yyqb+4MtGywrxtVtQu/whU
MIME-Version: 1.0
X-Received: by 2002:a9f:3342:: with SMTP id a2-v6mr8518664uac.51.1529451501161;
 Tue, 19 Jun 2018 16:38:21 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:38:17 -0700
In-Reply-To: <20180619231644.GB232723@google.com>
Message-Id: <20180619233817.140031-1-jonathantanmy@google.com>
References: <20180619231644.GB232723@google.com>
X-Mailer: git-send-email 2.18.0.rc2.347.g0da03f3a46.dirty
Subject: Re: [PATCH 0/8] ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 06/15, Jonathan Tan wrote:
> > 
> > Supporting patterns would mean that we would possibly be able to
> > eliminate the ls-refs step, thus saving at least a RTT. (Originally I
> > thought that supporting patterns would also allow us to tolerate refs
> > being removed during the fetch process, but I see that this is already
> > handled by the server ignoring "want-ref <ref>" wherein <ref> doesn't
> > exist on the server.)
> 
> What's your opinion on this?  Should we keep it how it is in v2 of the
> series where the server ignores refs it doesn't know about or revert to
> what v1 of the series did and have it be a hard error?

I think it should be like in v2 - the server should ignore "want-ref
<ref>" lines for refs it doesn't know about. And, after more thought, I
think that the client should die if "fetch <exact-ref-name>" was not
fulfilled, and ignore if a ref in "fetch <ref-with-wildcard>" was not
fulfilled.

The advantage of doing that is that we make the protocol a bit more
tolerant to adverse conditions (e.g. a rapidly changing repository or an
eventually consistent load-balancing setup), while having little-to-no
effect on regular conditions.

The disadvantage is that there is now one additional place where a
failure can silently occur, but I think that this is a minor
disadvantage. A naive script using "git fetch", in my mind, would assume
that refs/heads/exact exists if "fetch
refs/heads/exact:refs/heads/exact" succeeds, but would not assume that
refs/heads/wildcard-something exists if "fetch
refs/heads/wildcard*:refs/heads/wildcard*" succeeds, which fits in
nicely with the die/ignore behavior I outlined above.
