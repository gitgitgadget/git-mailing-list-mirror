Return-Path: <SRS0=wQ61=DL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C921C4363C
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 17:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FC1206B6
	for <git@archiver.kernel.org>; Sun,  4 Oct 2020 17:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgJDRwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Oct 2020 13:52:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43764 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgJDRwa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Oct 2020 13:52:30 -0400
Received: by mail-io1-f68.google.com with SMTP id d20so1892973iop.10
        for <git@vger.kernel.org>; Sun, 04 Oct 2020 10:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lhHQIdNU3tHs9YjTNuKiUoK98E+CWDw/G7tkLZfFCE=;
        b=CMWfU8k6mzOqI2nBXTk+2TlDp2TW0YywXoCP3Xl2BkIgEv5BWrEKi2lhKmcw2NVzhK
         nuO5/dJMfImJbxiAWt4btwxGctar+HWCk2IMqWmioNMHJS3Dr3jeNro8yFh3qB2OuE6o
         pxZmHURdE1N4rPyYSYHo5WrXSPyU1T9A4s56HGDwa0zYIb/Iax2FEtoxFgKFjy6jJFLA
         hkM8HWfRE8mwjyddwHbYMvLZo+0aoawXb1dj8nxMIB1f9yJEdeizQTdoJkSxlyckFO9i
         PlEo4A3b7xgza9WoTNrPzD9QMFmE2qV2OmercWEpYttbDXXz3OPd0GL3ve4yqqWuPzmU
         ntbQ==
X-Gm-Message-State: AOAM531kwMW2JcoKnuthdYXV6s06oE/B0pYdTM0/v4kt8uo2rU8wUKem
        8WQqlr5826zm4uuEylLcFjeC3fnMnq0Vr76G5ZHyoLfc
X-Google-Smtp-Source: ABdhPJzPP+mtezvkbPSMTDRu6eKmbVxWjUY6cgOM538xuDjDzgE2Io7gLtD/S+3SS+ogTmtK9FUiAD8uEEu1HMcz3ig=
X-Received: by 2002:a6b:d80d:: with SMTP id y13mr5064262iob.15.1601833949153;
 Sun, 04 Oct 2020 10:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.493.git.1589176201.gitgitgadget@gmail.com>
In-Reply-To: <pull.493.git.1589176201.gitgitgadget@gmail.com>
From:   Ed Maste <emaste@freebsd.org>
Date:   Sun, 4 Oct 2020 13:52:16 -0400
Message-ID: <CAPyFy2BsFLZZeEY=54evEJwed9q+Dc3TX3s1O+cr-nqwjCRHvg@mail.gmail.com>
Subject: Re: [PATCH 0/7] subtree: Fix handling of complex history
To:     Tom Clarkson via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git mailing list <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Tom Clarkson <tom@tqclarkson.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 May 2020 at 01:50, Tom Clarkson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Fixes several issues that could occur when running subtree split on large
> repos with more complex history.

I've been using this patch set locally and would very much like to see it land.
