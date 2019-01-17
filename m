Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D561F453
	for <e@80x24.org>; Thu, 17 Jan 2019 14:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfAQO02 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 09:26:28 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:35089 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQO01 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 09:26:27 -0500
Received: by mail-ot1-f45.google.com with SMTP id 81so11282399otj.2
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 06:26:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=t0eJpExuaZBwPj/sCaaObUmwhKh0iPKeJiNuOK2wBEw=;
        b=D5dvPmV+YirOD4EiWrJDIZnQIKokT/GjPvCHFTmQsHDJ77UjdNPk906rP+hxgSDBbJ
         l0qEBoRrgBUf2j46FMhBUEc7UOgncs4wH6mnK+nocPBlQqjmKjt6XanrMGRNysGHRFHb
         ETJrv5Csc9aMRldDZtGS1a2E7Bd2phsBw7aQXMp0j5nMir0KMwaNzw6aZnvSlUxdHjOy
         5Pgclww1DkfOARZDy+5M8aZ5zO4OGs806XYPdP7TYXvPdll/bxkAAfkgkV7TLgpwj1UH
         ENa7Qwm8BXMnO7K186jzTp/J6/W2KB5VfN/9OGW9NqqpDv/WngALJFOW7sEroPdLskWd
         VQ+g==
X-Gm-Message-State: AJcUukeVvlsi+7nbDVUCtQeFzg7An1NI+ODaI9uCgf3pzdShiuOalVzr
        +2RZ3UBvgUENNCO11Dg+ydG4ZtfCfCPgDFMCYA24Daak
X-Google-Smtp-Source: ALg8bN6LWofJt/hJYCFh9KwbPi6Fo+u9eKJTJwwdPLnuB/JpVFnC/1SvY/v7bGFQQUV3FH93uMvK3FCY1pAyEJckDl0=
X-Received: by 2002:a9d:7dd2:: with SMTP id k18mr8531626otn.232.1547735186900;
 Thu, 17 Jan 2019 06:26:26 -0800 (PST)
MIME-Version: 1.0
References: <CAEppYpH5F4v=Lam22ebKA+QYH2A1nGd7wVSrs0V2DkazYwEFUg@mail.gmail.com>
 <CAEppYpHr1Et_5MEB=tN-tZc+2XVt_v1Hr_1TgnZNFaNuPyvndA@mail.gmail.com>
In-Reply-To: <CAEppYpHr1Et_5MEB=tN-tZc+2XVt_v1Hr_1TgnZNFaNuPyvndA@mail.gmail.com>
From:   Kenn Sebesta <kenn@eissq.com>
Date:   Thu, 17 Jan 2019 09:26:01 -0500
Message-ID: <CAABTFJMyEaa867f-xi1zpGX3mn4ydZXjKDJ+PZn4F79ZA-L4Qg@mail.gmail.com>
Subject: Re: git-gui child windows are still blank
To:     git@vger.kernel.org, Rob McDonald <rob.a.mcdonald@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good to know the upstream error has been fixed, thanks a lot Rob for
investigating.

https://discussions.apple.com/thread/8066794 suggests that we can
never hope for 8.6.9 to be installed as part of the macOS framework.
However, all is not lost as a commenter suggests a workaround of
bundling Tk with the app. Is this something which can be done for
macOS git binaries?


On Thu, Jan 17, 2019 at 2:23 AM Rob McDonald <rob.a.mcdonald@gmail.com> wrote:
>
> It looks like this is an issue with Tk that has taken some time to resolve.  It should be fixed in 8.6.9, which was released in November.
>
> Rob
>
> On Sat, Jan 12, 2019 at 11:11 PM Rob McDonald <rob.a.mcdonald@gmail.com> wrote:
>>
>> The release of Mac OS Mojave has broken git-gui such that it is unusable.
>>
>> This issue was raised by Ken Sebesta back in November, but I can't
>> reply directly via gmail.  Message-ID:
>> CAABTFJPpmThrrwP6pb5gZ82fb8yKteLpDcXTCQS8p_7WZ0Ne5Q at mail dot gmail
>> dot com
>>
>> The main window opens fine, but any child window (say when you press
>> 'Push') is entirely blank.
>>
>> I haven't been able to find any sign that work has progressed on this
>> -- has anyone made headway?
>>
>> Rob
