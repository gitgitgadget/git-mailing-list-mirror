Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4746B1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIKUrs (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 16:47:48 -0400
Received: from mail-ua1-f50.google.com ([209.85.222.50]:40066 "EHLO
        mail-ua1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeIKUrr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 16:47:47 -0400
Received: by mail-ua1-f50.google.com with SMTP id 101-v6so21043581uav.7
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOsHFlnmyME120bogI1CUS06asFfgnPsaAke5IN+/VA=;
        b=LrZsakpvIAcjoOlTIYuKQSYoH3d1uJ6WrNHdSIFUlW9Yo2mOLcAl0EJvm3mSDOLS9G
         Foja0hWC+7uOqwsjoAHQwK+xr8viqCN46G944w0y1KKFhvTAx/NCbmSU5BO+Uxclw1od
         v9sCU/6RcVpBhH3LQj0XCvLfE3AVNr+T2W1KThFNzTSyC8+xEKy0rh29B2V0DQQNt0hI
         mDT0DehgLWApfXQpIPZ+wbTlIc2h62n1VFk+T3r/PxYzHHAFb+VWa9+oWm28u0A70+L+
         CC4FzH403ueIDaJ0dE1isoHtYn/jXgMiOZWUc92ury1ud9ET5fQUS3y/oXffWphjSNax
         IoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOsHFlnmyME120bogI1CUS06asFfgnPsaAke5IN+/VA=;
        b=arU68m7cUqq4MzbEowq2MVdWYYS/kCfFLs+2BuKcCyVWSfQp4tfQwy78hk7ONt1Gvt
         c7+0iWTXrq0qsLSDXx2qKBpbka2OK1WfGNI3xoeudYHa4m8hnEGft+1vRvW/JMBum97g
         fJ17qmf3fIQ7ZgwFzY2A2ZhVvUBfLnQk8oNxR20KVGMjGrYXjsUI34maQC4lJu7414KA
         Q/M10zGfya4fB+yc3xg/kz359zvh65rqExwgOMal2IsTg8ZyKyEdfiSfvuJF1I20JRjF
         zDvsyIFzI1nKNgQ4+3lQsHrK0yqSZNHSQVLV9VmNpjltzgl2o8i0RREv7O4/1cLQ3ahs
         aSfw==
X-Gm-Message-State: APzg51BHhfuEvqG6+1UZ0tjhVHHD6fP9QWG2Zda0Imd4NJkHPTChdOIM
        66BU+YN+JxbfcU/BAsddClInnhMrAPYV/utCHfc=
X-Google-Smtp-Source: ANB0VdbNduRBgELdTVaAoMEccJwYaMstpoHVHEOVsHKEbbf8ihgjibXlxcRwI1jpI2BFwEOcAoh+ifq5rJVx0UqOFEA=
X-Received: by 2002:a67:3d5c:: with SMTP id k89-v6mr9408166vsa.34.1536680872840;
 Tue, 11 Sep 2018 08:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
In-Reply-To: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 11 Sep 2018 08:47:40 -0700
Message-ID: <CABPp-BFUoTYSuTrtJt7girB50CGaEwg=Hgbuii45juBbTx0w0A@mail.gmail.com>
Subject: Re: Git 2.19 Segmentation fault 11 on macOS
To:     ryenus@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 8:27 AM ryenus <ryenus@gmail.com> wrote:
>
> I just updated to 2.19 via Homebrew, git range-diff seems cool, but I
> only got a Segmentation fault: 11
>
>     $ git version; git range-diff origin/master  HEAD@{2} HEAD
>     git version 2.19.0
>     Segmentation fault: 11
>
> Both origin/master and my local branch each got two new commits of their own,
> please correct me if this is not the expected way to use git range-diff.
>
> FYI, I've created a sample repo here:
> https://github.com/ryenus/range-diff-segfault/

Thanks for the report and coming up with a sample repo.  However,
reflogs don't transfer with clones, and your origin/master may well
point somewhere different than ours.  Could you run
   git rev-parse origin/master HEAD@{2} HEAD
in the range-diff-segfault repo where you can reproduce so we know
what commits to pass to trigger the bug?
