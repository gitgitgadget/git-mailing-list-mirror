Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32177C4332F
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 23:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKTXvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 18:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTXvi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 18:51:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE422B01
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668988286; bh=1rU4YtT5bL4GYuZYm/ke+z7ZhDC6RfASHQN3mQxQAOo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=t+Hgpm6nawz7zDdBLD5EhCV/HFoDBxRvrzSBp/JXTGc/AHvbtIIHZbXwuplM5oNJZ
         HgC+Wwk0IddaU+t5vtyKiiM+tLU8LR8zhiC9bqqkxE5bzayc2IeJdIT7qNXttiYl9z
         jA1FQKtbasgsv/I+GvC5QZdq7AWejER4ehuaB68MP7JrJZN+oiMKAcC6b9BjG7ID/D
         3g+Cb/oWtjKeY4VMcaCzF5sqZzjmYFJKgNDHj7mu8HgV4f6n5IEhQHtnQeQbMfekc5
         nLxifwKJSq1Iu4eTz1rWOyzlLTbEAE+eODgkQZ0OYPFnh8tDnqe3CrZOuXno6BP/oW
         EeDj+pjFa0BbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1p0LPH0psT-017oHw; Mon, 21
 Nov 2022 00:51:26 +0100
Date:   Mon, 21 Nov 2022 00:51:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     David Hary <davidhary@gmail.com>, git@vger.kernel.org
Subject: Re: Issue: Git for Windows: : Incorrect registry entries for the
 Git Bash and Git Gui
In-Reply-To: <Y3WNYNjos+2996jb@tapette.crustytoothpaste.net>
Message-ID: <s731n00o-2o6s-nq66-sqqq-n42qo6o4rs7n@tzk.qr>
References: <CANNdkQZByT6dAiAJ=yrQshBi9suDUV2Xum2TtAGyJDKxb3f5QQ@mail.gmail.com> <Y3WNYNjos+2996jb@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-488566746-1668988286=:189"
X-Provags-ID: V03:K1:DFvqSjrPg7MsnV2hAD0FoK+kFXCp1cDPCKY0MVGzu30XvJXJeEh
 RQb1x9eRMcYMT31NH8c407Q8O1TvCbGxqY65KzF4/WuhxasFWrPvnzrnfF8Bz8IoIniK5yL
 tU1zEY7PGSwDY8c2tMaOsuGnF75yk+3PCsbb+qq+SDB+zwXeSkxe6yBHPx6YqBKznHmuGSt
 i9L9/0dfCMc0ya4Dw8mzQ==
UI-OutboundReport: notjunk:1;M01:P0:Ae0CluoUYmM=;PJxCq3HOi1cgwp0TkoHmvxruHa7
 SJhoy4o+gjxCN9ELPX3WEXKJZjs3JLFR+H5F8Po9PR947fueojL07XUzTylllo4+qFrQo11CY
 atLUCdYdq4/xuICQ+5vZ+dLTFH+wnANSRYl6lTgcGv9zyiZ/xVeciP+7KkGfqpcTbajM9HB3T
 OCO+z9acn0XxirnT1gyhK2/l1Fmf3iYel7Z40bXKbkTjhgFcWdglEfyehPs1UiZjM3M4YYeEG
 V6Ue2LgqJGVldqXJyiS+ZPj0egu8QJC1zXmzIVY+1CGpVB9m+bpMzCe1lFp4QoB5aMal36XQI
 vcNoaVDryXdoLgV2P5UyXkfZf6z5k+r8VH3YLGiFjxcWMyEalzIjowzGGTdETJ8OQ3CIoxZOQ
 fP+KsfAKBTONbaq0b2P1VxRztBxCQG7MaJ2BbzPZ0T7tnSnn46QMQtcx74jQnXPrXKs3QMcMy
 XqqUHZ1xmiVC8UwJefXO+yJOSWHU/9ncbpUtJgg2uxqQDJNxechJcmyXJ+wrBkkZZZAvMyq2Y
 iujR5S2i9VSZt70H+6lqiSGJl9f/jP5swmhOswWERLBzgxZ8iNtgtUMPLyDx+h5jBXToJ2+RY
 TnKifNETZ1S1O9sheAD3aTMxYntE2/VTDdeQ/4tozZaF+R2MkWuKULOH4EsPs5DPFjV2F0x/s
 eB/NX0q8j2xkc27Iax7sWndV6VmUk6HH1kJhCvfpg5hZdW1JunyCzJhTzt9Jgxr4xeJDOqzkK
 IgC/7l9AG++uuEWzulpvoyXk3lGkNMb8S6+SxrHJw4BXeFftBXGtNjpwBBXKwvKl7ldzwoGxp
 D4hGw/5XDAZF0WJfqUTvQTo5Gyg/zmYr0r3qjyqYgFYFxtgOjsyq3gu4DEK8sh1doblamHZ3U
 wU49xqGj6nVK7XTI3oLYzhfLgVp7ht567KNvrcxmyHwQi653/sYWSz9vqZgP+Ya8nVZB2V6rD
 jsUJGw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-488566746-1668988286=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi brian and David,

brian: thank you for redirecting the report to the Git for Windows
project.

For lurkers: the report has migrated to
https://github.com/git-for-windows/git/issues/4120 and we determined there
that an "upgrade" from a user-wide installation to a system-wide is
inherently subject to the observed issue, therefore users who want to
switch from user-wide installations to system-wide ones need to first
uninstall the former and cannot rely on the "upgrade" functionality where
the Git for Windows installer detects an existing installation and tries
to handle it properly.

Thanks,
Johannes

On Thu, 17 Nov 2022, brian m. carlson wrote:

> Hey,
>
> On 2022-11-16 at 18:36:27, David Hary wrote:
> > :Observation: Incorrect registry entries for the Git Bash and Git Gui
> >
> > Likely Cause: the registry entries do not update when updating Git
> >
> > How to reproduce:
> > 1. install git as a personal level user; git goes to c:\apps
> > 2. Change user level to admin;
> > 3. Update git; git files move to c:\program files;
> > 4. Try git bash or git gui from the File Explorer context menu; both f=
ail.
> >
> > How was this discovered:
> > Having had some issues with android emulation for visual studio, I
> > changed my user account from personal to admin.  When updating, Git
> > got installed under =E2=80=98c:\Program Files=E2=80=98 instead of c:\a=
pps. Yet, the
> > command lines for Git Bash and Git Gui as recorded in the registry
> > were still pointing to the c:\apps folder causing the explorer context
> > menu shortcut to fail.
> >
> > Workaround: edit the register changing =E2=80=98c:\apps=E2=80=99 to =
=E2=80=98c:\program files=E2=80=99
>
> This list mostly discusses the portable upstream version of Git that
> works across systems.  Any sort of custom Windows patches or Windows
> integration, such as interaction with the registry, should be reported
> to the Git for Windows project on their issue tracker:
>
> https://github.com/git-for-windows/git
>
> You might search first to see if someone has already reported this.  In
> any event, as the folks providing this integration, they'd be the ones
> best suited to fix it.
>
> Hope this helps.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
>

--8323328-488566746-1668988286=:189--
