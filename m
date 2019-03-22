Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66D4B20248
	for <e@80x24.org>; Fri, 22 Mar 2019 17:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfCVRU2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 13:20:28 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:49410 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfCVRU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 13:20:28 -0400
Received: by mail-qk1-f202.google.com with SMTP id 23so2506827qkl.16
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cissq3CZd94tb4DevNwBEVgzoEXCCRfFdBXuOtv/h1U=;
        b=KZoKRFUysF746C9mDOKsiqsYxavc50qGlxZajolo3HSPsIuN8mdlODH5m0aixXwgfF
         VwkeNzvnn+JUq47HXH35HJxqvGQBj4LAdHg8evynkHYTY1FUHWgQeWlV/2gPwpVeyv5w
         865ql1fk4sO8HmuqS51jFOb3iBWwd+bRC2NzzGZM5Rbz4zXLb1i3WjzXesM7sR0eDyMQ
         xjSKMAlVO9WTmqRN+Wt4jxGSvGPcF/vIp449oij700qMBllhk/8vscN0rhUAAL9tzaVs
         /vPXa9SkzvKCrM74dG5cT0kSvgF/6HhAK36+asrl1toEOyfoFEXMjfCuhjA9xebdIKxs
         pACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cissq3CZd94tb4DevNwBEVgzoEXCCRfFdBXuOtv/h1U=;
        b=MY6/uzcNN9YnAdVQrMF0TjPiOzBLtch7hzcukZAOLxQrsmC2psYpAc+J+L7qcJlTi0
         H/PIETRucXr9vYqEK79LYfD0Tdc2cxeWrECqBPPYGnOG2VyYtbikoCqEwbOouApiHT8P
         A6IvoHzd0p4Npx4dbMJ2Lcpqf9kRbWKneU6wHIefsRrFoPJJ1QjLAPYHOBhs2SKh/4i5
         x7hQTVCJ4/Rbci4WuMYqB59piiJb6JUUZuaelCVW+X3pXVWEu8VFkW17YVWgpJlIPAC5
         EwHPks+H0aPLt/yG2SsKWwCQyhtsYxQr8VknA/MOo75AUfBhGAib0+VPbt4+q4gJPSDt
         S9hQ==
X-Gm-Message-State: APjAAAXNeKcmymtgktWmCHTf4pT9iRgdvap3JCtZ9jWpBbsORwIqr6Tn
        AFjjtPuFDu2jI6PaKhNgaIu+hNbFi5IFVBCl2T3C
X-Google-Smtp-Source: APXvYqzy4++o4FW6j5+GMceMzl9p05omOxgT8lKKHz+jEWyq2yt6ROWXOcwtl1VPv/1EK4RFatZ7jlwVKXPqKlVhAJNX
X-Received: by 2002:a37:9682:: with SMTP id y124mr7950056qkd.288.1553275227189;
 Fri, 22 Mar 2019 10:20:27 -0700 (PDT)
Date:   Fri, 22 Mar 2019 10:20:23 -0700
In-Reply-To: <xmqq36nfsl8t.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190322172023.238242-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq36nfsl8t.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
Subject: Re: [RFC PATCH] t5551: delete auth-for-pack-but-not-refs test
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Because this configuration is not supported by all protocol versions,
> > and because this configuration seems to be of limited usefulness (only
> > useful for people who use manual credential entry and on servers that
> > are OK with exposing refs but not objects, and even in this case, helps
> > only in a no-op fetch), delete the test that verifies that this
> > configuration works.
> 
> A possible and different conclusion that naturally follow your first
> "because" could be "fix protocol versions whose support of this
> configuration is broken", and your second "because" is with "seems
> to be", that makes it quite weak.
> 
> Quite honestly, I hate to see a proposed log message that downplays
> its potential negative effects without sufficient justification.

That is true, and that's fair.

> Isn't this feature primarily for those who want to poll from an
> automated job (and naturally you want to assign as little privilege
> as possible to such an automated job) with ls-remote and only run an
> authenticated fetch, perhaps manually, with or without cred helper,
> when the automated polling job finds there is something worthwhile
> to fetch?  What this test is checking seems to be a quite effective
> way to achieve that useful workflow, at least to me, and offhand I
> do not think of other ways to easily achieve the same.
> 
> The "ls-remote" communication may not even touch any outside network
> but may be happening all within a single organization, in which case
> "are OK with exposing refs" is making a security mountain out of a
> molehill.  If it were a truly problematic hole that makes it a
> security issue, wouldn't we deleting this test and at the same time
> plugging the hole for earlier protocol versions?

Thanks - that's a reasonable use case.

> Having said all that, I do not care too deeply.  Would a much better
> longer-term solution for those who want to poll and fetch only when
> there is something new be to allow clients to subscribe to a feed
> that hangs while there is nothing new, and lets the upstream side
> continuously feed incremental updates to the receiving client, as
> its refs are updated, or something?  As long as such a thing is in
> our vision (it is OK if nobody is currently working on it) to become
> replacement, I do not think it is a huge loss to lose the ability for
> unauthenticated ls-remote with authenticated fetch.

I just remembered that one way we can support the existing use case is
to inline the ls-refs call that we make as an Extra Parameter [1]. This
would restore the ability to obtain refs through only the info/refs
path.

Perhaps this is the component in our vision that we need - I'll write
another patch that merely forces GIT_TEST_PROTOCOL_VERSION=0 and has a
NEEDSWORK comment that explains this. 

[1] https://github.com/git/git/blob/master/Documentation/technical/pack-protocol.txt
