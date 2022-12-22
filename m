Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C975C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 05:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiLVFTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 00:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiLVFTn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 00:19:43 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A9FD3
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 21:19:42 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id jn22so948558plb.13
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 21:19:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Or/5r80p7VmfA1ghbHVktz58Q44y3Ps3CsjWpS6cSeM=;
        b=BdP7w23emJMCxKZ8sb+TzN4p+RQyDjHwnVr+Jqm4SWEtuTnGa/IjdhmfIBetlg6ih0
         yIFBqbvDKo/0d473398B9mWj1vzWF6Zqws6LrXBb84k1sLRO0eZle8NfdoOuovwKA+FC
         kAtZD8oaFi3rM2YARWGM9lxjBTFaoXZSQENG20g5TLXKA+fj2bBzIFBBfBtMN7YgcX9i
         U3vcIPzG+9VPbFjD86N/KCb7VO3kdCrmBiMhyhWeRUc2lk9QwWtXe0e+zFAlQEbGq4Cy
         FhN0aDkRnc+95zfAyj/7G6Qfys1L/rMq1KPfqOYe6b62NPkRyXqXpHyp6fGlYrR+F2zx
         HZDw==
X-Gm-Message-State: AFqh2krG58eHuJeeGovJB4xA1TQdeVPdg+GuMFK4mtKsjyLEhc35+ZV3
        w5go42zIW99Z7imUe7RrA3WfpqzNatdqv6BQpPH1Xdwh
X-Google-Smtp-Source: AMrXdXu7uxGaEy1RCggy45HwsMkAsEKJGExH7keB4Y8mG5k3XnhksyorzxFeD5FH1Bmyb3Y8jMSHMnkEBFKHnHMlTds=
X-Received: by 2002:a17:902:ccc5:b0:191:271f:47a0 with SMTP id
 z5-20020a170902ccc500b00191271f47a0mr274731ple.120.1671686382246; Wed, 21 Dec
 2022 21:19:42 -0800 (PST)
MIME-Version: 1.0
References: <CAOLx1BgQinzZBkHvvmDrGUedEyQa_7ZVsyVGmWjF4gYhxc3P+w@mail.gmail.com>
 <Y5u/E04V0QWQTDhu@tapette.crustytoothpaste.net> <CAOLx1Biwd9KzqipoEPaw0M2AecW7XfuyvNeVW4F59e696gMt-Q@mail.gmail.com>
 <CAOLx1Bi189tdo1Yn7njv9BjMzjuVOT8MSZH-bx8o-nS6gQpQTg@mail.gmail.com> <CAOLx1BibKcxrPp3fyUbGXM-d_JZKot_MLznB9EXF3CkVKkHtZA@mail.gmail.com>
In-Reply-To: <CAOLx1BibKcxrPp3fyUbGXM-d_JZKot_MLznB9EXF3CkVKkHtZA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Dec 2022 00:19:31 -0500
Message-ID: <CAPig+cT=emSXkHhH8XkfiKF3yKQy4px2jkfq1pPsNFkw5N_N-g@mail.gmail.com>
Subject: Re: feature-request: silently stops ssh-agent.exe when upgrading (windows)
To:     Jean-Michel MERCIER <jeanmichel.mercier@newsbridge.io>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 21, 2022 at 11:01 AM Jean-Michel MERCIER
<jeanmichel.mercier@newsbridge.io> wrote:
> Just for the record in the archive if anyone is finding this thread:
> It has been handled :
> https://github.com/git-for-windows/git/issues/4172
> https://github.com/git-for-windows/build-extra/pull/453

Thanks for taking the "health" on the mailing list into account. Such
follow-ups are appreciated.
