Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80F381F428
	for <e@80x24.org>; Wed,  3 Jan 2018 05:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbeACFlq (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 00:41:46 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:40710 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeACFlo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 00:41:44 -0500
Received: by mail-ua0-f179.google.com with SMTP id d37so371696uae.7
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 21:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uu9qBp4AUu8iwTZX6fw0xhFiGOf25Nf/yXmMPqEnutk=;
        b=UvI35RFGz/2dmBFGMPWOgQ5RpqLKZqFKoB/4qdlJ8lADUFKAsKkitEEnXxby7UiQDh
         ZveFvJy6MzpRMKqUBpFMZJ5f+XDn0Q8/YnFdyY60juBhK6kdhi+eRCK5TR2bUvqoctup
         IEe7/4dbeJCEDbHvmt7wlyJHNap3G10zeYGxTWh4tG2DNqtYfybFOLvRMM+80UUl5kAN
         PVtl5fnj35ig8C8vAGai7cEMV+pf35Bu9XqhtG6I130H2SoLyYUducEIkbcJSgdtudjY
         oLM4QtBF810ZcMAU9wrkJiN9q5N+QC2QTHSH0h2oA7iOKBaWJGVqJqSSilrBM/ZDBHtV
         P0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uu9qBp4AUu8iwTZX6fw0xhFiGOf25Nf/yXmMPqEnutk=;
        b=GyUyj2x6rRSDeABzU6/ALm8BxyrsGn5JQQYsZpIOgR7ef2P1BH9NOOfJse0QoJr3Nj
         zoN3X85xUkif2LKhwWnSDnoKiEKZOL8FmrgkH3vcAVbqck2th3Wm4l/Ri57jDCdPplWt
         rLR56BKJ1VyOuRCn3bqPj6w4s8047YBN9PTB41NGNXmD80inRsb4hNDxbYseFmy+JUNm
         c5ZUtJY0d7/HsDB8GmYQTJJurrY7WWfEWOMhXQhr8zeh4c+ngt44heuhTzwm1gGabQAS
         DtvOQeIhl69PE0DzQlx8+fFQEmnel6HJOuFJpO5gw7gnJgrOBFa3AOujyGGRiSAAy2Ex
         Ih/w==
X-Gm-Message-State: AKGB3mJUb1JzZmvJ9hDQK6hLJLJI5o9mykqysyxuUHO0g7A8f6qKHDqv
        rVhh4p2PYfYvVggtTSVduQdZwekH1E17BB/Paf6YPg==
X-Google-Smtp-Source: ACJfBosuGcJpuM5TXEWvzK/aBRhJ0W6XmsaZ0Rf52uFEjTuc6sjH2XINYx23S3ld6W5tTGgy1ejjrEIyIZ6RmKahxw8=
X-Received: by 10.176.86.88 with SMTP id z24mr323972uaa.142.1514958103637;
 Tue, 02 Jan 2018 21:41:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.20.37 with HTTP; Tue, 2 Jan 2018 21:41:43 -0800 (PST)
In-Reply-To: <20180103050730.GA87855@aiede.mtv.corp.google.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com> <CAGyf7-FQp4q2vvH1ponQvmVDTu0hiMSK1JKytQZ4O1i0MCnz7g@mail.gmail.com>
 <20180103050730.GA87855@aiede.mtv.corp.google.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 2 Jan 2018 21:41:43 -0800
Message-ID: <CAGyf7-EeBHwg50+MnUGF6=aE91TJY_iYSrg5gF1rp8ApsTsrvw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 9:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Bryan,
>
> Bryan Turner wrote:
>
>> Our test environment is still on Ubuntu 12.04 LTS (it's a long story,
>> but one I doubt is unique to us), which means it's using OpenSSH 5.9.
>> ssh -G was added in OpenSSH 6.8 [1], circa March 2015, which means the
>> "auto" detection "fails" and chooses "simple" instead of "ssh". But
>> OpenSSH 5.9 _does_ support -4, -6 and -p. As a result, commands which
>> have been working without issue on all previous versions of Git start
>> to fail saying
>>
>> git -c gc.auto=0 -c credential.helper= fetch --force --prune --progress ssh://localhost:64281/repo.git +refs/*:refs/*' exited with code 128 saying: fatal: ssh variant 'simple' does not support setting port
>
> Hm, that's not expected.  git-config(1) says:
>
>         By default, Git determines the command line arguments to use
>         based on the basename of the configured SSH command
>         (configured using the environment variable GIT_SSH or
>         GIT_SSH_COMMAND or the config setting core.sshCommand). If the
>         basename is unrecognized, Git will attempt to detect support
>         of OpenSSH options by [...]
>
> So my first question is why the basename detection is not working for
> you.  What value of GIT_SSH, GIT_SSH_COMMAND, or core.sshCommand are
> you using?

So I'd been digging further into this for the last hour because I
wasn't seeing quite the behavior I was expecting when I ran Git from
the command line on Ubuntu 12.04 or 14.04, and this nudged me to the
right answer: We're setting GIT_SSH to a wrapper script. In our case,
that wrapper script is just calling OpenSSH's ssh with all the
provided arguments (plus a couple extra ones), but because we're
setting GIT_SSH at all, that's why the auto variant code is running.
That being the case, explicitly setting GIT_SSH_VARIANT=ssh may be the
correct thing to do, to tell Git that we want to be treated like
"normal" OpenSSH, as opposed to expecting Git to assume we behave like
OpenSSH (when the Android repo use case clearly shows that assumption
also doesn't hold).

Based on that, I'm not sure if you _actually_ need to change anything,
and I apologize for not turning up that we were setting GIT_SSH before
I bothered you.

Thanks immensely for looking into it, Jonathan, and my apologies again
for wasting your time!
Bryan Turner
