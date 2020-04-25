Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43726C54FCB
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A6AA20661
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 14:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gM0hAJ8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDYOPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:15:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:53623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgDYOPK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 10:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587824107;
        bh=NBDMnQjp9Vyd50Rs9wZcODIw3M/jzikItnKCoMBy1ok=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gM0hAJ8Y7CtQDCAqjxhWPt9KQ7MvtZEusRNpaEH+ji4jU8LaTwSfNfHAk+3WD562e
         IID9CmRHhFLW/Dn83KpRjXZh7Gzp/1/Rj+UKqbWVWSj4ptqWsa3b1U6eaeLfGfAHhz
         sBxnpxij95x4A3hJVsdUNDKi9O7aVEaTSqj2grto=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.117]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MAONX-1jMcHB4ATT-00Bsm5; Sat, 25 Apr 2020 16:15:07 +0200
Date:   Sat, 25 Apr 2020 16:15:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Kerry, Richard" <richard.kerry@atos.net>
cc:     Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
In-Reply-To: <AM0PR02MB37150CFFDD7A3871DB43DFBD9CD50@AM0PR02MB3715.eurprd02.prod.outlook.com>
Message-ID: <nycvar.QRO.7.76.6.2004251610300.18039@tvgsbejvaqbjf.bet>
References: <AM0PR02MB371559B3C5445A3C9D39821B9CD40@AM0PR02MB3715.eurprd02.prod.outlook.com> <CABPp-BGis7wswAjwgTa84m-TsQznrQWQJVJZW0_MyN9ieFMzeA@mail.gmail.com> <CABPp-BHjF4AJdTrdqxvgsZq+UBZd06upFOHEx-8eQ8qKO-CtkA@mail.gmail.com>,<9478ea01-8d1d-a897-48f1-813f88dde072@iee.email>
 <AM0PR02MB37150CFFDD7A3871DB43DFBD9CD50@AM0PR02MB3715.eurprd02.prod.outlook.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1163654236-1587824108=:18039"
X-Provags-ID: V03:K1:oEWwWdF8PC9+Pi5xDOWol2paAwVqEd7lCHFRKAE4PUzpPQeyucb
 WWOMJWEsk+FBgMIXLslBpNGFkQ2/YcJ8Ypo3woa+7jGO1+cQUK2cFTZV56l9zitCVvlQIyr
 m763p5aboJOMxZwq3WnQ75f7Tmz0NIfo5Sd8dNRonRro2/AZD9uem6ug2NtCr92MX3bINHO
 nFeuyvrdNEk3EAPuTdyVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pgtPNcP3JM4=:Z40MxUoVOq5YbIZvHjJa+G
 1kFd0V/YeiN2tsKftXPLHZ9t52hfp8eczxTa2fPO4A2KEpXvVbcrm/2WLaVnFL7vOusIVobZk
 8G84aVhf233AGvIJhp4LPSR//geRlpsPCrrAV71sK+NUYOcdfRHxAcQ7nHy6Mqtqjd/FmRqos
 jG+rwCIUPDuwIuH2QQlyuwzehIMmRU83ErM5m2wvEf0jEAOoaB6PXjfHhxddI0+frmlWCjC59
 ceWZIZry43qh4fb6mMaRFZ0KlvRFH/J3oPrqhJ0Nfiz/TvKT8jrqvFnG5PZrd+Bf7Cywgic0E
 fTyqHkG7xAgxIWVi57H5JJ8RknccYyWux7S40Wu9RZqjBcSuNT03nr0PxtHCW4c+m5TYs4QTf
 3WMUEAIuivFGDAtNuYQCcvS9luzNihXDxWnwnlkKnjbSEDk8lmXMUVtq6pzCsmI4okq+qrxBZ
 nekKLNUETRI0ZY5ZCRbeHyRMVcMBBNPuc/52zh0v6VBqsZAkm2Ptsam9pd93qikhMI5fYVXpy
 YLhc8d5TgPfRVLM9WZnp3TPhQIMvb/jfgl8YqYk0oSi4GrGW43u4vnFuT+CYb7QfKBZzCwR9i
 lnVve0ngTDz5K6TEnU6c8j6KbQGJSbfXSwg84w8+ykdiylo/o1BFH1o9ibEMieJnGxnR3eh0Z
 nHOZXuJJjPLEbsUSHPGVrCZqR6fPSSuprcwVSMFaP8w9Ccu2yI+FVZwKC0Ly+2+AKPPBZrCnr
 hxq/Esw2X5HGU4bnK92psXiVEi/8FRgJkydg4mQkZplB51RY6igdHQMeyTChWxAnwTQF9J2Q1
 lRRHbk0T5rA2pmO9ZjI59DxwdTA4ZhiHos6Z/k00yUxPRSfb+Ef1mzDsvqU+Rih5XyhPmRmea
 f4xAmNx6rrkF+QPw87UKmaeNWNnlVQVLd+wJM/FcpIkbxzKiJpv8/kv+BjeK+xTpadMJ0ZUZy
 IZwDeCukY5bcRC/OveIqerdzHzJVzfRxbmXO7LwxQ8esZwhjdODFMLEyumopwdXFg8smGRivx
 Mn0X8qN1dXhNvfblRGKYOmLNb2XxlEvu34e3ybkyDJVIBo0u032oBmqMDvD2975dnvbcP570M
 ab0ycz1BXY6MdxVues9ZY7pfgH6T6NUyUTj/umRlJQ6FvQQKTXaKfn3zWg1PtTPgNK9k9E97V
 I7sahcXK1DN/2AKUGy+ZK6/P7n+xsyy+9uEopJb8dG82AGN3sWjCXfjzsB+/2n+wDlwQ7XlR3
 8efyiVzJi99JmDA7F
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1163654236-1587824108=:18039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Tue, 21 Apr 2020, Kerry, Richard wrote:

> Thanks for everyone's advice and assistance.
> I had a look at all the links provided and wasn't convinced any of them
> quite covered my requirement, but I have now made some progress using
> Scoop.
>
> I had hoped that all I would need to do would be:
> 1. Install latest Python for Windows (3.8). Install for All Users means =
it's in C:\Program Files\Python38, and that's in the Path.

I installed it via the Microsoft Store. This put it into my user-specific
AppData, and it added two items to the PATH.

Unfortunately, even calling `python3.exe` from the PATH does not work: it
is apparently some placeholder that MSYS2 (and therefore Git Bash and
`env.exe`) have no idea what to do with.

What did work for me was `env python`. Of course, I don't have Python 2.x
installed, so that might not be an option for you.

> 2. Clone git-filter-repo.
> 3. Point Path at git-filter-repo.=C2=A0 (Alternative was to copy it into=
 "exec-path" folder under Git, but that was protected.)

For the record, Git for Windows also adds the `bin` folder in your home
directory to the PATH. That is where you are supposed to put additional
things.

Git for Windows considers C:\Program Files\Git its own home, and
it might remove your files without prior warning during an upgrade.

It will leave `~/bin/` alone, of course.

Hopefully these two hints prove useful to you.

Ciao,
Johannes

> 4. Run it.
>
> That didn't work: /usr/bin/env: 'python3': No such file or directory.
> That string pointed me at the shebang line of git-filter-repo, so I set =
about trying anything that I thought might point at my Python installation=
.=C2=A0 Nothing I tried worked.=C2=A0=C2=A0Some things, like "/bin/sh", di=
d indicate that the right file was being found and executed, but gave erro=
rs that it was being executed as a shell script, which of course it isn't.=
  Any attempt to point at the python exe seemed to say things along the li=
nes of "git can find it but not understand it" (sorry I can't now copy in =
the real error message as I had to close the Bash shell in order to update=
 GfW.)
>
> So I gave up on getting it to run using raw Windows - well not entirely =
raw Windows as it's going to be run from Bash-for-git-for-windows (or so I=
 thought).
> Installed Scoop.=C2=A0 Got Scoop to install git-filter-repo and python.=
=C2=A0 At last that lets me run it and have it do something useful.
> Though actually as Scoop gives its instructions for being run from Power=
Shell I'm not in the end running from bash at all.
>
> First attempt at running it was using:
>
> git filter-repo --analyze --source=3Dcore_system_archive
> which responded "not a git repository" even though core_system_archive d=
oes contain a ".git".
> But then=C2=A0
> git filter-repo --analyze --source=3Dcore_system_archive/.git
> or
> git filter-repo --analyze --source=3D./core_system_archive/.git
> didn't work either, same error, although it looks to me like=C2=A0core_s=
ystem_archive/.git is a git repo.=C2=A0 So would I need some different syn=
tax to make that work?  (And I've since noticed that examples use space ra=
ther than '=3D' to separate keyword from param, so I've tried that, with t=
he same failures)
> So next option was to "cd .\core_system_archive", then just
> git filter-repo --analyze=C2=A0
> Which has worked.
> Though it isn't clear what was wrong with the parameter I used for --sou=
rce.  How am I supposed to reference a source repo without cd-ing into it?
>
> So thanks everyone for a lot of hints, but for me, under Windows, only t=
he Scoop package manager managed to get all the right settings for filter-=
repo to work.
> And only now, having been rather rushing to get this to work due to othe=
r priorities, have I seen the comment about using pip to install it, so ma=
ybe that would also have worked.
>
> Regards,
> Richard.
>
> Oh, and having also seen Philip's reply (below) I don't think I would ha=
ve recognized it as relating to my issue.
> What is winpty?  Should that have gone in the shebang line of git-filter=
-repo in some form?
>
>
> From: Philip Oakley <philipoakley@iee.email>
>
> with a reply by dscho reminding that:
>
> This issue is listed specifically in the Known Issues in our Release Not=
es:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some console programs, most n=
otably non-MSYS2 Python, PHP, Node
> and OpenSSL, interact correctly with MinTTY only when called through
> winpty (e.g. the Python console needs to be started as winpty python
> instead of just python).
>
> The installer even suggests (on the page titled "Configuring the
> terminal emulator to use with Git Bash") to
> =C2=A0=C2=A0=C2=A0 Use Windows' default console window
> =C2=A0=C2=A0=C2=A0 [...] which works well with Win32 console programs su=
ch as
> interactive Python or node.js [...]
>
>
> Regards
> Richard Kerry
>
> BNCS Engineer, SI SOL Telco & Media Vertical Practice
> M: +44 (0)7812 325518
> 2nd Floor, MidCity Place, 71 High Holborn, London, WC1V 6EA
> richard.kerry@atos.net
>
> This e-mail and the documents attached are confidential and intended sol=
ely for the addressee; it may also be privileged. If you receive this e-ma=
il in error, please notify the sender immediately and destroy
>  it. As its integrity cannot be secured on the Internet, the Atos group =
liability cannot be triggered for the message content. Although the sender=
 endeavours to maintain a computer virus-free network, the sender does not=
 warrant that this transmission is virus-free
>  and will not be liable for any damages resulting from any virus transmi=
tted.
>
>
>

--8323328-1163654236-1587824108=:18039--
