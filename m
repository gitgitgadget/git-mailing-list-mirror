Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4812720986
	for <e@80x24.org>; Sun,  9 Oct 2016 11:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751320AbcJILWs (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 07:22:48 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33261 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbcJILWr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 07:22:47 -0400
Received: by mail-lf0-f50.google.com with SMTP id x79so71532862lff.0
        for <git@vger.kernel.org>; Sun, 09 Oct 2016 04:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Jfn3sPkNToKT+cJlSo4zfkI+w0iWh5D1GHJHYR27I9U=;
        b=Gqr3PnYweKbTSvvzESCs5+H7SNGOOxPa7SrhMyBltBpDLrtK8TXhKal033vtk6t6sp
         Nk4HPymurH8q8qNJ6orCh4YH4SbypjjXGSMH6aDujv4fp3NySo3E6QNIFfPLTBIdxukz
         CCxHM7Ukvc+FDkkcMIJDzIzfBEZ3f+yx4MtekjGkZy+YaLMC+8fnqX4Dnv8dBxFZoBP4
         K7ZrsbVc7lViOcrSt628Nt/b0HhUGiWnwlcOhvZXONplLcnXhFSfiaKOlQ+Af5tXdiIP
         U54y7/XPRi8BAeWlpO5LNRym6BDCDUcVkyEBHii3nqFh8iPtwz9s3mQBOBPQ3jlvTDfo
         BheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Jfn3sPkNToKT+cJlSo4zfkI+w0iWh5D1GHJHYR27I9U=;
        b=YA/ww6MGg2v2h1NN6Im0+L7MDGzvgGIRIQ1NMKIXcASE9hQ9S7ds8SnVT01tOPcHCp
         /WQ1Zmq3DOx1IaST7sOA2SPCcEzhLa1m/U5l97tCU8j52DoaEo4sIxM+3kVJnwNPcAaw
         gOaeHgBst3cZc7l5rPWur4ITjcS2lqjUEi5kMKD+2U+M6D0YBjf7juK/vV6c83QeLznS
         icrp2vR9xU+AT8DDVX+uC8JFoGLUcK0CcJ9aEhUnJDLyBqP8IM/2bVyP/UcS+pZf3IG7
         XGIGQTbiYeXxvYEloy6xRfmzjXcgXdrME5c8BW7gRkG8X5l5SAkwj93CG/Y1LPCTA94G
         Ikag==
X-Gm-Message-State: AA6/9RlACq4KrnFXRUD8dZcVZ3cR67WFF0TBhVKQZtV5+52BWuBDixTcGnFrETOt4B6Z67ohT6QXmRDzh7Ca/Q==
X-Received: by 10.25.203.135 with SMTP id b129mr9500275lfg.145.1476012165356;
 Sun, 09 Oct 2016 04:22:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.165.11 with HTTP; Sun, 9 Oct 2016 04:22:04 -0700 (PDT)
In-Reply-To: <CACsJy8C0kyKor4gCLSJrreRCazazbexvaSdbBg+Cka=-beZU_g@mail.gmail.com>
References: <CADKxhpe3S4L9CPV9yxh2yhrtJMa9wyZAPC45u_S=RiuzY1Xrkg@mail.gmail.com>
 <CACsJy8C0kyKor4gCLSJrreRCazazbexvaSdbBg+Cka=-beZU_g@mail.gmail.com>
From:   =?UTF-8?Q?St=C3=A9phane_Klein?= <contact@stephane-klein.info>
Date:   Sun, 9 Oct 2016 13:22:04 +0200
X-Google-Sender-Auth: tEkuY5i2oATkDpJL1-B71G58VdI
Message-ID: <CADKxhpd-gDczp05Ny6wP57RXafWWCimArfA9ki2phh+-gHez4A@mail.gmail.com>
Subject: Re: Feature request: use relative path in worktree config files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-10-09 13:11 GMT+02:00 Duy Nguyen <pclouds@gmail.com>:

>> * [worktree_foobar]/.git
> This is made absolute on purpose. So that if you move worktree_foobar
> away manually, it can still point back to
> "[main_worktree]/.git/worktrees/[woktree_foobar]".

Same problem if you move origin git repository.

>
>> Why:
>>
>> 1. I configure worktree on my host
>> 2. next I use this git working copy in Docker with volume share
>> 3. next I've some git error in Docker because config files use absolute =
path
>
> I think the common way of dealing with this in docker is put things in
> the same path where it actually is outside docker. If you have stuff
> at /path/to/foo, then you create the same /path/to/foo inside docker
> and bind the data to that path. Does that work?

It's not always possible. I can't in my project.

I think there are some pros and some cons for relative path and absolute pa=
th.
Maybe append a "--relative" option with `git worktree add` ?

I've converted all path to relative and all work with success.

What do you think to append this --relative option.

Best regards,
St=C3=A9phane
