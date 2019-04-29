Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB74C1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 23:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfD2XGL (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 19:06:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:55779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729652AbfD2XGL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 19:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556579164;
        bh=HD7Anbd4Yl6i4MRFCvQ3KCX0nXb6JocinwsJOy4hCOw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dvwZ94pIXHmCUquzYH0VVtI2ozpEp5fnyt1KwtXABPnsAWbMyLsvZqRR9CNPobyod
         c8JQRD9O/z17rtTGUKJAHePc9fI2TivQiqMs0YGCm3MSAPWqRaS8j86jm4C32Ua9Vc
         ACPVBYMBCF4xYTogIdUsavr+/NXBFJkrmosgrWSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKZLb-1hJK4R0SRD-00202B; Tue, 30
 Apr 2019 01:06:04 +0200
Date:   Mon, 29 Apr 2019 19:06:05 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?UTF-8?Q?Jaros=C5=82aw_Honkis_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jaros=C5=82aw_Honkis?= <yaras6@gmail.com>
Subject: Re: [PATCH 1/1] credential: do not mask the username
In-Reply-To: <CAPig+cSiv+4xh6bWDTggBiApywAmAx6eQLq+Dh116kO2+cf_kg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904291904560.45@tvgsbejvaqbjf.bet>
References: <pull.138.git.gitgitgadget@gmail.com> <e459e487d3848ae1b7f37676bd9d2a2f9c967430.1556575570.git.gitgitgadget@gmail.com> <CAPig+cSiv+4xh6bWDTggBiApywAmAx6eQLq+Dh116kO2+cf_kg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1127276314-1556579169=:45"
X-Provags-ID: V03:K1:GmAYS1q1QRZAQ8t7KLus8jDRAwQAgg/xWnmyjIl1Z57/90skBAA
 MwwFZVR90VoAGZDQAp+5a0l9MaTEu5wue3sRD8Ird0OwzSfTm/A0iMS9NaGHpBWMqr90e2p
 FfuH6rzgKstC0hQQsqbKEhqmkXKAtoVeRZknkFFwUuoZz7W+t7lqVaJDp1gaLH/OV+NXBsL
 vQyRu0FaRFJHYFRDkJXMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cY239Elz12w=:Tu1E1wF7I0+NoandC6rMoB
 +0IPogtHxqPNp6LbJ9aVDntJdGP1zxKYQb0rwuYwdIw7/liqnXrZosFXFtk6oN6o3XQPJJ3HQ
 gUKO3To9RygnJqL/0bNQ/Ok4lO0F1pkxmYqLC3jCOUnKkxEq0j4XGyoDdM2G88wyFsxGrwuOV
 1Gkjn0VSbkENMsffn9s8IPidQOsZvFNg2IOmaBRZBzXaG2YPFxkfMRrJ07STCb95c6RVzUQmd
 OkEWPb9RZD8Iz5XzMUSndsVglJWBCdlKFT8xM00qDz0xDI+/Y5trczb1cOlkFfWkkvx21/giT
 FvI3dSKetfbvpIX24LE6DMQmh5JNNOJJr1yUzY0tNu6VrDjfVzKvfiiPLnaUdA+352WzXeIWX
 +z2QTQrVefkVDDNWVBWFOexXTo4dfcWlFnQXEqgRD8w9CkY2QQPQ5V0JjpL6/hBGAolpw09zN
 rDeW5rg6AZM0rfCC+7W/kmbZTLfDX0z2uscmst55k0NYuZS8jHHN2BMvo/l3oGQNCK5CHJn5d
 UID738xr3ZFzNElvW9J31vabrRuWH/+Ua+cZlM77+69/MYfNjlCiG7uKRxPksny1OxlNXNbvt
 L64MLlaPOpU9Z8bKY3++bHKTPUuc1KTnJo+RqUfoEKYtUOmxl3cOAflOZelo+2ehltRiJu/F5
 vivvi2F4CT0U7IVmDBCFUVjHXEnpE6dW2LD3kNp25m8NEv4BbbG3UdndjyqIhmcVOzTLn4dRq
 to+j9c9L1Jtihkluu74x1qds3sl+VQzKFR4dSLD2ZlGP29IdKkQxOSvnMSLa0Q3w7PZtH3Ahj
 Db0UKcz7SDYKTbweQcAPGpoAf5Jd/4/nDhd6B0Ej4O/SNpnQ/abT0+1TU3H1p3W941Hcl1Ucy
 bQe8ydwLjPNrVpdh+cCM1DUuqrEPw6ZoYNUlm111fbS1XAvHi3H4Wy2zQMS1pokNw0KbFnbmD
 hJV5HgtqSfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1127276314-1556579169=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,


On Mon, 29 Apr 2019, Eric Sunshine wrote:

> On Mon, Apr 29, 2019 at 6:06 PM Jaros=C5=82aw Honkis via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When a user is asked for credentials there is no need to mask the
> > username, so the PROMPT_ASKPASS flag on calling credential_ask_one for
> > login is unnecessary.
> >
> > The `credential_ask_one()` function internally uses `git_prompt()` whi=
ch
> > in case it is given the flag PROMPT_ASKPASS uses masked input method
> > instead of git_terminal_prompt, which does not mask user input.
> >
> > This fixes https://github.com/git-for-windows/git/issue/675
>
> This link is dead. Is there a more modern URL to which this can point?

Oops. I should have looked more carefully, right? It is missing an "s" at
the end of "issues":

	https://github.com/git-for-windows/git/issues/675

Thanks,
Dscho

> > Signed-off-by: Jaros=C5=82aw Honkis <yaras6@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>

--8323328-1127276314-1556579169=:45--
