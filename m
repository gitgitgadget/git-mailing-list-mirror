Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 966A8201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 12:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755485AbdCKMez (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 07:34:55 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:34638 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdCKMey (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 07:34:54 -0500
Received: by mail-it0-f51.google.com with SMTP id m27so2325007iti.1
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gdHuQHbKePUOu3SxVX7mSWvRx+nGev1DJoSgECQ72hY=;
        b=vIJLiPqLB18TuRI7drrg0W+MnEOVMcQUgEtKT6Acg+yK5hdQ+Tic7TdLnBCGFrA04X
         ohRvVm+PDanSiqMtuFVt0oujaWMl+MUlYWLYAc1B305h3GIkI0yng8yE2KaueUNvfZA8
         aXmlAmYsI3WX9Sc9V8MZheGK0JLEoQs9Ew04O3edNceJSo7zpCT7jBUo15l+KQtUvmnQ
         dGQgBTwbVPaWEyhhWBy3+B2qiEpOIT88l3xyAci1kOdztw1HTzO3QHrnZyijxknETxFG
         fmAwYykMCv6h3Of9UxIvuCdR69DHKbHneyDQ81qjGQ+OABdOKkYzhybak8oM+d7Vi/Wn
         pFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gdHuQHbKePUOu3SxVX7mSWvRx+nGev1DJoSgECQ72hY=;
        b=cu4qBf2mm1LoyyzM9gGgP7mAbknoCXQpT6JxAI0Q1KhNwJ4O4VYRqj/lBNuYEWRscG
         vGseXDCiJ3ezl3bb6Zr9RenYask8hRrQLyUExEBv2Kaco7yMk1L5RiBznt0i5Rf7sY67
         LIStIMLIXrbQxXRcJSrCgt8fs6NtNyh5L5xwISoXE4d7rj1/uSyg5/U01F+6e8uufaND
         3DJNUawAt1A1btVr8SBPPqOjgVqxjruOcz8muigI6X53MDon+NLz8FLhGqzaYKE1q+uf
         TaDknDmLDuqnQYGo5D9VcdXH9epLbGUtO+aK4RHXYS8B0Kzj10mzfLM2e9aVeN65VMmr
         A9Ig==
X-Gm-Message-State: AFeK/H2fvDYFuNfVy4lghtW06ZGfLjCue//4zzYnboB70LTacir+ZbLZr2QM19R+IXCrrZOzqogJ5fftvq+ztw==
X-Received: by 10.36.103.9 with SMTP id u9mr3094460itc.91.1489235692760; Sat,
 11 Mar 2017 04:34:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 11 Mar 2017 04:34:32 -0800 (PST)
In-Reply-To: <05e6903d-336d-23df-a4be-13c4030c6c82@gmail.com>
References: <05e6903d-336d-23df-a4be-13c4030c6c82@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 11 Mar 2017 13:34:32 +0100
Message-ID: <CACBZZX5ZNpidDpuHgvLZ0XVj=0Xm7OavNO-wMo4wXzdN=WOcVQ@mail.gmail.com>
Subject: Re: How to find the cause of 'git push' stopping on 'Writing objects'?
To:     Luuk <luuk34@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 12:55 PM, Luuk <luuk34@gmail.com> wrote:
> I am new to GIT, so i'm playing around with a repository and git is hanging
> on 'git push',
> How can i find out what i'm doing wrong here?
>
> D:\TEMP\test\test>git remote -v
> origin  git://mini/test.git (fetch)
> origin  git://mini/test.git (push)
>
> D:\TEMP\test\test>git status
> On branch master
> Your branch is ahead of 'origin/master' by 3 commits.
>   (use "git push" to publish your local commits)
> nothing to commit, working tree clean
>
> D:\TEMP\test\test>git push -v
> Pushing to git://mini/test.git
> Looking up mini ... done.
> Connecting to mini (port 9418) ... 192.168.178.50 done.
> Counting objects: 9, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (9/9), done.
> ^Citing objects: 100% (9/9)
> D:\TEMP\test\test>
> D:\TEMP\test\test>git add *
>
> D:\TEMP\test\test>git push -v
> Pushing to git://mini/test.git
> Looking up mini ... done.
> Connecting to mini (port 9418) ... 192.168.178.50 done.
> Counting objects: 9, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (9/9), done.
> ^Citing objects: 100% (9/9)
> D:\TEMP\test\test>
> D:\TEMP\test\test>git status
> On branch master
> Your branch is ahead of 'origin/master' by 3 commits.
>   (use "git push" to publish your local commits)
> nothing to commit, working tree clean
>
> D:\TEMP\test\test>git fetch -v
> Looking up mini ... done.
> Connecting to mini (port 9418) ... 192.168.178.50 done.
> From git://mini/test
>  = [up to date]      master     -> origin/master
>
> D:\TEMP\test\test>git --version
> git version 2.12.0.windows.1
>
> D:\TEMP\test\test>
>
> The git-server i'm using is on a mac-mini:
> git --version
> git version 2.10.1 (Apple Git-78)

What's the output of those commands prefixed with GIT_TRACE=1? (See
"man git for how trace works).
