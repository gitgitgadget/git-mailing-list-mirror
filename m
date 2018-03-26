Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841341F404
	for <e@80x24.org>; Mon, 26 Mar 2018 22:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbeCZWFC (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 18:05:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:36081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbeCZWFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 18:05:01 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhkiL-1eE25C4AF7-00mqQM; Tue, 27
 Mar 2018 00:05:00 +0200
Date:   Tue, 27 Mar 2018 00:04:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BGSoC=5D_Convert_=E2=80=9Cgit_stash=E2=80=9D_?=
 =?UTF-8?Q?to_builtin_proposal?=
In-Reply-To: <ad524ce4-8be2-4d14-44cc-2fbc9ff60b79@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803270004300.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <1521576562.2188.10.camel@gmail.com> <CAP8UFD3NKCSN8mVDiCUzvor5uZh4nFCAw4T0zgxpvHLf9AWmyA@mail.gmail.com> <1521760546.11809.20.camel@gmail.com> <CAP8UFD3bRaPke8MvubZ3+v6RrY7K7Peip1dpQ2LG9kxKoXcmbw@mail.gmail.com> <6603149f-776a-fde8-5d11-a7d9d6d37e96@gmail.com>
 <CAP8UFD2y605FQeiymO2JNxy7MXs=-vRcN-Z2ri1=ttDF8kccvQ@mail.gmail.com> <ad524ce4-8be2-4d14-44cc-2fbc9ff60b79@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:o8hn51TSvkLBDClECDpORCD0yoS8SQuQkLk9zbG5sKJIhxE2QIb
 qBCUWmZ9zMLeHpoX0DO91aroAMQ0hTN5nzOeArQDrvPEXqfjRPkHOpleUe+W93zIExsPIzw
 0uaxg4CP1rmNUz8UsVtQo2kBViXk115ZqQahw8pnVUtxaKojbUu8eAOseXgt4v78Iw8lHyj
 hlMmcsIPioPfnKQgY6c4w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jLRmKfIJ8Us=:z6KLZA77g+zKBasxWVtgfO
 iNjvER12/Wi2I5U4Q2/Jv9JNDH4Bba6yrvown7J21+1nEp6N+wSavlAE+hPIAN3VIRK5IGi0j
 gu41uON6HJaLs+kS/3zMuO4gm58ACFkuW8jafVSecCTDebPOM0ix7L+dytQFpb04znNztUalj
 jJCY1EWA68yu9BB+xVvMpRzWjymkkP4EyJh9mR+/OTfbYIcupd8V1aCMi021g7JIQKWBzfhPi
 4bMgSR5ka8pBK0ZrF9HzC8KIdkfCB4TSgGsxG75IFJQcD8lZV7/nlEhoEH4Aaq4mBX5781MFI
 nuDCtIPm02CXq0FRjTatwvtzOlPOn7nQeBi8cxOnVj8StFzrgUMaH2LdufLq+YO8cBCK5TgyD
 26OnToL77zxxNCJfEL+DX/J0pV6ocWJMySPnaCn7GAyDDMDdqqUMI2H2i5E47b6heneetISZX
 G4VITskJzkUuUGnEf0in0a+dsMOxRwmdsf2Hx0R5Ry9MbHSv1kzJ8VfIJjxeb2ophGLBUOdRr
 Wcb2/25Ge1wGD5awUArjQgG0x9GTcp8rtEaIaJNhS+cqpK/gkzIb8gXN3Z/TA9EnUEjhSQzEs
 Xxp+L7jqO7Sr2MUukJGxwi4Y03BcoUO8cfgvg8arNPgK12VwfY/pFLaqwFn2ey4wj2J0OIc7Z
 IqldJgVyBlOaa0z1vq4h0zWEDvRHxGPmRs1XAowYJddJv4iCGAZ/M/BJ5WSyJkebUNuPKxWmV
 sGwOdDIO7TYEVvmtkFZ0Wqurmh5zEI7jbmtsp08J2cXaBkHjI+GwQbFzEgJphVMMXHBHHFJhj
 LgclPwxDZ9Q37pUm6vRMNLAXArbtxcfz3JdPZ1RaK3nYfMs4D5WlJt5EjEvABCzXWsbx+jI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Paul,

On Sun, 25 Mar 2018, Paul-Sebastian Ungureanu wrote:

> One thing I did not mention in the previous reply was that I also added
> a new paragraph to "Benefits to community" about 'git stash' being slow
> on Windows for a lot of users. I consider this alone to be a very good
> justification for this project and doing this project will be very
> beneficial for the Windows users.

Yesssss!

Thank you,
Johannes
