Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 473EB1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 16:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeIKVDp (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 17:03:45 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37606 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeIKVDo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 17:03:44 -0400
Received: by mail-ua1-f66.google.com with SMTP id y10-v6so21108015uao.4
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KuJxw53wfBXNxwz2Bz2YkeMYEiTjXi9rSneyOf0y53c=;
        b=YGpouI/cCG7H4jZAhn+Nx6zsLgFVZy5A4yDPB6nOkc/uvEfLLBUNncJoFiFpZXMSFZ
         s4ced95P1jUF+aYiCIv489aio3TsQ2YYHo8/FTVjbGTAafSkvxi5g9Ko6gxkSdHpjlOj
         XK8zZlPGEkYqkKvMHXJFAAgIWPlKAnAn/2OjBuIu75pdPKVFdOabMno3V+aB8cK8p90A
         X67sNbY7a4C7Mqd7qNf4aXYUqdDlEAx5b0+u/68GV4r0R+N/v+URObIQ2jE+jxrjLajw
         aZkb67ScpcmgeXKcrMdDyvoQSl6PVe1u7g2k8hSNFp+l/XvczdUiHW95bo/UOEDmcB2S
         pHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KuJxw53wfBXNxwz2Bz2YkeMYEiTjXi9rSneyOf0y53c=;
        b=K4GgncQFVXwYLzdY/D+G4h9cjpY9lZrP+d6u9hBfTQTLMtr5zTWto4cXEbQDnlUj0r
         Xs0PigvtgUWt8uoz+R0qMZnDmoYQni2FfNG8rYmiQXH4OAkw4jQA0pcHpYbd3wjEqG53
         BDtIcjUqlBrmldDk8U5XJGxUStHfBnmNXdGwwDQgCc08wfsvCSJXepZdEih1Jgw7ZiW0
         VltR6PiRNRE4JTHxOJ+mV/ZWz8w5JnSirmHaGZSJv2DGrsKbMQSM2xkGJqH/u59d2ojH
         cyAHEuIe9ouOpo8YGrYF10FBb1W6P736z26kOMvfcTk0sNeb92WMkdvgudn0xsB/V1wI
         h/rA==
X-Gm-Message-State: APzg51AmTDy8NCyPbSp7j/Km3hXRhI/UwrpQQBJdkfP0TjteaLek9JZW
        VGszFUadwJQAlIkCfCbQSN/rZCZ5XGM2j96j5V3c72Dp7QY=
X-Google-Smtp-Source: ANB0VdZJGb7XvH++HG34hnfYxPVZ1e67INBkzYg1CXgFCPO2tIwhrW+fexkBEtlKtVopljvQ5mshYGkf2efzKRNdLns=
X-Received: by 2002:a67:460b:: with SMTP id t11-v6mr9492909vsa.68.1536681826731;
 Tue, 11 Sep 2018 09:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <20180911154906.GA4865@hank.intra.tgummerer.com>
In-Reply-To: <20180911154906.GA4865@hank.intra.tgummerer.com>
From:   ryenus <ryenus@gmail.com>
Date:   Wed, 12 Sep 2018 00:03:35 +0800
Message-ID: <CAKkAvaw4QTMzKXpkpAaMhZaz68=OdS_AmrMXyu6C9td2P+XmTg@mail.gmail.com>
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
To:     t.gummerer@gmail.com
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 Sep 2018 at 23:49, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Hi,
>
> thanks for your bug report!
>
> On 09/11, ryenus wrote:
> > I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
> > only got a Segmentation fault: 11
> >
> >     $ git version; git range-diff origin/master  HEAD@{2} HEAD
>
> Unfortunately the HEAD@{2} syntax needs your reflog, which is not
> available when just cloning the repository (the reflog is only local
> and not pushed to the remote repository).  Would it be possible to
> create a short script to create the repository where you're
> experiencing the behaviour, or replacing 'origin/master', 'HEAD@{2}'
> and 'HEAD' with the actual commit ids?

so `HEAD~2` should be used instead of `HEAD@{2}`, right?
I just tried the following and got same error:

    $ git range-diff master patch~2 patch
    Segmentation fault: 11

>
> I tried with various values, but unfortunately failed to reproduce
> this so far (although admittedly I tried it on linux, not Mac OS).
>
> >     git version 2.19.0
> >     Segmentation fault: 11
> >
> > Both origin/master and my local branch each got two new commits of their own,
> > please correct me if this is not the expected way to use git range-diff.
> >
> > FYI, I've created a sample repo here:
> > https://github.com/ryenus/range-diff-segfault/
