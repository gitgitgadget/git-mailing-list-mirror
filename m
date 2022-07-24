Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C24C433EF
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 22:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiGXWEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 18:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXWEw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 18:04:52 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 24 Jul 2022 15:04:51 PDT
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D12EE34
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 15:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1658700290;
        bh=gDwJLbtab3ZW1/PWFAoOEJEgQw6Umy956YPAd+9gWs0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mHoYEEidp4Su9OswZ8gsGpP2co2UFRJ7dyIMvUuarFW+gWwIsNQIAR/HhppGsp6f2
         q6qdTx0Ww5ed33fzLHINp4PxDyM9n/N4wVAfWmnjEEgCjbI65Y0wBvTGXz1jswBQIg
         tZaxtaUlXSPi0gYbsCuMjvFadl25TT4i8Tqvqsu0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.32] ([93.234.112.53]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSBG-1o1yWI3IPu-00Wj6p; Sun, 24
 Jul 2022 23:59:40 +0200
Message-ID: <7dc225d7-eb36-9fb8-5977-6913ac4dd007@web.de>
Date:   Sun, 24 Jul 2022 23:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: =?UTF-8?Q?Re=3a_Changed_diff3_view_from_2=2e36_=e2=86=92_2=2e67_for?=
 =?UTF-8?Q?_vimdiff?=
Content-Language: en-US
To:     Fernando Ramos <greenfoo@u92.eu>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <99c80fc2-0f94-a607-ca71-c45961c07e2b@web.de>
 <CAN0heSrCocuKA+8UvU8dH_bsM4Xg8L3M8O4W0buXkUc3uCxpGA@mail.gmail.com>
 <YtsMhb0XUPw2EekJ@zacax395.localdomain>
From:   Claudio Ebel <claudio.ebel@web.de>
In-Reply-To: <YtsMhb0XUPw2EekJ@zacax395.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6WJiHk8A9A3fuMhnmPP7QGzRgPRl/vmhOYCpAH5P8XMbmSP7/pb
 gawC/zX3VYMHdsdhsPtYzJy/xAEIR6qgrpfPzlkTTYJhnFAegpnu2GmcTaUURd5lDjKMk7R
 gEtWW5h+exvSXLmcSTO+NKJ4PrQzKs2ZNtMshf6kruBZI8mpfTEzqlMuVJVZ4XYybXjw9xD
 gdUsmN+635S/LCMuZdqLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rmt5TJtUJsU=:CkL7zd4/+op81X9q/1X+kw
 Q75x3aA8WpPGXJ9LBa4sPUBsvdwNDoPMh36Z0kAvuiec7a5CkmOB8ukrntWeSmUJpwe2nmYqb
 NzLjLqVurmKMYmVI7HYsKAAlPaXgdpwLWk7IoeONc4WJZpBZYFHORDcQb1L7zvxyEguVORHwe
 smxgsyj5tgRTcXR0jyTWEJR5spZ4RCKlXq6Av+199RoXH7mXnKq4tM2BYG32RYwEJxK00PrwE
 WllwodMkaXGgM6lALm9R1MM7q6DmQh/ZmjG17H8ahPuOUVGPQYNf/nLgE8a6/aSgQqpkYEBxg
 +ytpOwTBE1pxOxasuvgGHyfQANfM+hTSMC7P619+8yua70YbXXZ0CCRIchJ+awToP8kkT19uP
 XmZ4tbK+TtBE7JbQuf6WbjPOhK03xwTjiCuLw2bMKjFgwJJ4wymTNntV3lLlwlkzahDhdHoB+
 Ex2dq+vQCNrH78wfkLF85Y7ShBv9PSJ+ySu4XHLCiS8BhPyqyGjkPLXVXf1dU1KqF2Yd2WCWf
 N0fayvgOIkMInkbTrVEs/ydAGR6VQrxJ7ZZedzz102nahiObveK1jOo5fxcgUB3hpcLjVa1zM
 87nLuuf0udbNUiKlqfW0PijzFlZCUtK1HPN2ig4yyQW3Zd2FavBS5j6OS6SNaud23JXCrO2j8
 cXD+Fr0i88RA+48R3ZIQ7inqdv9lfakoeUQn+j84o1YugYs/nT8q9+o3L+ndQzGeZFaAb3gGX
 kAfmTb2fRVJJ/CV1O4euPnUyjhxPunQaTH456HXE0v/FGJEGhe1X95qiKoHEBOfk8kNG4Cb5r
 0hOc5ZdzUKsx7h12b0hD7hqrD3G+zB15yobCp8PRJoBFoDfDNVvrzv7GqFhBr6df9lehCbsoa
 5sKjxtzlqW/OqrdvfAoPEa9MhGh49xau8QjDTM3lV2AA7pEnLDgKUCr3fKGtmNyIEWZsRJE2A
 NRBTPmToxrUPAHhaDFUXCePpnvay9r5ssfPfN7wxDtAA73luAc3BJQcyYGUFY7UqoWNfgLmXT
 FdVfVGDo1GfDZiAgvnyeQLJEbRlXtxzjK960AkV2Ys86HqL5z1YDHsIefVvsycQ8DeVcoBLlp
 OzgA1p+I/QjoGi5e6dzfOaubt3EgYB/2uNpZuSODVkdEXkLtmHUWVAvaQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Martin, dear Fernando,

first of all: Thank you both very much for your super fast and elaborate a=
nswers. It's amazing to get responses from the developers themselves! I re=
ad the blog post about the new vimdiff layout with delight. I like the new=
 feature very much, especially the decision and implementation of the gene=
ric mechanism which is indeed better than the introduction of new vimdiff4=
, =E2=80=A6 layouts. I think I'll stick to the =E2=80=9Cadvanced=E2=80=9D =
four tab option for my future merge conflicts, like you suggested in your =
blog, too.

Regarding the problem, yes, you both were right, I have had a =E2=80=9Csec=
ond rogue=E2=80=9D vimrc in my home directory. It has been =E2=80=93 as mo=
st often =E2=80=93 a =E2=80=9Clayer eight=E2=80=9D problem (myself). I hav=
e had a ~/.vim directory with a ~/.vim/vimrc file inside. Since I had expe=
cted Vim to need an ~/.vimrc file, I had created a symbolic link ~/.vimrc =
-> ~/.vim/vimrc. =E2=80=9CNuking=E2=80=9C my vimrc had meant for me to del=
ete this symbolic link (~/.vimrc), but as I learned today, the ~/.vim/vimr=
c file is perfectly fine. You always learn new things! So to really nuke t=
he vimrc, I had to move the .vim directory as well and then git behaved li=
ke expected, just like you suggested.

I investigated further and =E2=80=93 oh wonder! =E2=80=93 I found those tw=
o lines in my vimrc:

set splitbelow
set splitright

Uncommenting them brought the good old back behavior back, too. So the pro=
blem is solved, great!!!

By the way, the buggy layout looked exactly like Matthew Klein reported in=
 Martins link [1]. The difference is, obviously, the difference in tools (=
his --tool=3Dnvimdiff versus mine --tool=3Dvimdiff).

    ------------------------------------------
    |                                        |
    |                LOCAL                   |
    |                                        |
    ------------------------------------------
    |             |           |              |
    |   LOCAL     |   LOCAL   |   MERGED     |
    |             |           |              |
    ------------------------------------------

I also managed to compile the newest master branch of git (the Arch User R=
epository git-git package should be fixed, it's broken at the moment, but =
I managed to bypass all obstacles) and, as you hinted, this version (git v=
ersion 2.37.1.223.g6a475b71f8) is not sensitive to the "splitbelow / split=
right" options!

After successfully compiling Git, I'm almost ashamed to ask, but I was NOT=
 able to run the vim command you suggested, Fernando:

vim -c "echo | split | vertical split | 1b | wincmd l | vertical split | 2=
b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis" -c "tabfirst" lo=
cal.txt base.txt remote.txt merged.txt

because there are no such files?! What do I have to do before executing th=
is command? I read the man page and tried it with "git config mergetool.ke=
epTemporaries true" and "git config mergetool.keepBackup true", but still =
no such files appear. I am sure I am missing something completely obvious.=
 Even my google-foo failed=E2=80=A6 Since I solved my problem on many leve=
ls (thanks to your great help), executing those vim commands is not import=
ant anymore, I just would like to understand=E2=80=A6

Thank you very much again,

with best regards,
Claudio

[1] https://lore.kernel.org/git/CACRpdvnuAYY0U1_3uD8zKgtq05+bgwjzXpZKomro6=
gqYDNrjGg@mail.gmail.com/
