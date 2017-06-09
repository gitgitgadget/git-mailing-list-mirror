Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9422F1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 13:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbdFINGE (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 09:06:04 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34619 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdFINGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 09:06:03 -0400
Received: by mail-wr0-f179.google.com with SMTP id g76so32423110wrd.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k4C2IJcl2u2mljaEs7iPxv7calqGblQtYOZvI61DPq4=;
        b=SpGUjBzV10yNs3kJDxJkmKhD3hYXa+Dy7iNueCE+69GIMAw4pehSwrpT+bWQZmIb1L
         2yuXGgauZQ7e1itEf4AolnveKYTRobVtzRRiLhQ2Zsm1b0HJpWrQKomYgRxb99lRcCqP
         kY5uWpaFe2CEvVWHFUQvv1emh3Q272fFAA+BPVTiNGNwK3l9EUkL7a5SgXmfv/aDc+K9
         3fOzyh/e8MK27I8VvLtRrGdRz60ctEnKVLTy42KG3aGGulukiljHFSpd5TltsA5bveUU
         PjByyjcMmogIkwqkKwiXjx/I+9zJvwh1gchs1U5SAHGYJjvMv2+/4FIhCVdVzNLQd1WS
         /hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k4C2IJcl2u2mljaEs7iPxv7calqGblQtYOZvI61DPq4=;
        b=MSBjyi15xSqJZhbh9S2eBDBGLIHSMsQA+L87kEB7fL2zqA2XV8IlzzH0pw95DMTiDi
         ryvoZxIDklcE89VDEudD+mApOeDWDpQ9+J2N4ancDtnDQg9zt/Nh6RfBTLEZBU41neLk
         CjZSx/6yH/tw+hZC86BR5tHTEze59UgtfOuvm8zgNwN3gQf8olvXhESQNHnA6Ez+KvU3
         TjW13P3MrJJouSOlfso3cRUIx8NMLbN4eU/1U/S5uU4/bXnm9QZd6uawbK+3zXzhgfPR
         M9a7Gd1Vum5ASmS1si3ruO1WaGCOYwjqdamJBb95GHGl3kHxdKNotIAZF7Z9528yNTnN
         G/PQ==
X-Gm-Message-State: AODbwcAnzkPuB0tXJdiFO62dNljoHTUuB3b/ohZUfD2BZlQkV86D8eEj
        /dehcpESMVja4JAMSvtokJz1M/YjPw==
X-Received: by 10.223.175.204 with SMTP id y12mr17319263wrd.113.1497013562191;
 Fri, 09 Jun 2017 06:06:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.105.139 with HTTP; Fri, 9 Jun 2017 06:05:21 -0700 (PDT)
In-Reply-To: <CAGyf7-GGo7VQX3pNVSOg6ZVOfipynxpHvHKWNfgvfDQ5ODcCtQ@mail.gmail.com>
References: <CAPMsMoAYpS8QMrfyed5=XPWJLbV6=kMg5gp-2a75kWMpVD3D1A@mail.gmail.com>
 <20170607103326.GB27719@alpha.vpn.ikke.info> <CAPMsMoCi4JRB7e6DLLOx+i-Gbfeh=EXeytWPn0WruOPJQZ0vow@mail.gmail.com>
 <CAGyf7-GGo7VQX3pNVSOg6ZVOfipynxpHvHKWNfgvfDQ5ODcCtQ@mail.gmail.com>
From:   pedro rijo <pedrorijo91@gmail.com>
Date:   Fri, 9 Jun 2017 14:05:21 +0100
Message-ID: <CAPMsMoBXTL5=GC2mBH6vAFOO3dca1WpF3ouDNPcSzA-pUgE-CA@mail.gmail.com>
Subject: Re: [BUG] Failed to sign commit
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Kevin Daudt <me@ikke.info>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

as much clich=C3=A9 as it may seem, GPG was with some strange behaviour,
killing the agent and starting again make it work with no problems....

Thanks for the help

2017-06-07 21:41 GMT+01:00 Bryan Turner <bturner@atlassian.com>:
>> $ GIT_TRACE=3D1 git commit --allow-empty -v -m "lol"
>> 11:37:24.594795 git.c:369               trace: built-in: git 'commit'
>> '--allow-empty' '-v' '-m' 'lol'
>> 11:37:24.605842 run-command.c:369       trace: run_command: 'gpg'
>> '--status-fd=3D2' '-bsau' '8AEC0DB537A9FC7E'
>> error: gpg failed to sign the data
>> fatal: failed to write commit object
>>
>> It seems more a gpg problem no? something not well configured after
>> the update perhaps?
>
> Have you tried running `export GPG_TTY=3D$(tty)` before running `git
> commit`? I had a similar gpg error that was solved by that.



--=20
Obrigado,

Pedro Rijo
