Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62FF21F404
	for <e@80x24.org>; Thu, 26 Apr 2018 09:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeDZJTz (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 05:19:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:55165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753676AbeDZJTv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 05:19:51 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzYY2-1eGvu80KF0-014kB3; Thu, 26
 Apr 2018 11:19:42 +0200
Date:   Thu, 26 Apr 2018 11:19:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v5 09/11] technical/shallow: stop referring to grafts
In-Reply-To: <CANQwDwfJgoXd+iH207S8WoaWOS4BQnrm+GAOtfe1BvW9uyKiYA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804261117480.4978@tvgsbejvaqbjf.bet>
References: <cover.1524303776.git.johannes.schindelin@gmx.de> <cover.1524650028.git.johannes.schindelin@gmx.de> <a3403a69b692e4f4b0337800268a16818e790caa.1524650029.git.johannes.schindelin@gmx.de>
 <CANQwDwfJgoXd+iH207S8WoaWOS4BQnrm+GAOtfe1BvW9uyKiYA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-784255118-1524734382=:4978"
X-Provags-ID: V03:K1:ct3caORaZpbGyS5JkTf3jGg3Fc3zXH2GJVEEEuicAcnZW6ukjLW
 kNuElw0YiJMoNWeDqCiidiAtxmGO1kftn7mpFxZRNT5DkLl2gRdtRLvJRgZK4+/gMb85xwf
 j8sVsDm+cRmZ+fSFkA/AVLsHX8RIseFePypk0orRSkOs55VKSPty5TDKx0SO8GZa/Cs0D3f
 24UNopBjR9csTObm146tA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3l9OG4/mruA=:S9p8gGMiyssSmCwsIrOsWr
 kkpNL8hfO7q+/aC8G3+WEFD+BYXinE1NcAgk61sS6jvAZe9+Xed5+l86aLnQGaCxxXkY4ru8O
 zUTx6lpphaTECO/CqZz34Bvr5kK2Qz6m9lovsgtBDF+yfWer9HUEplALJqx7XLc77aWgPDeAb
 WBGe1ThrY5D4ebTAwozKf9CvasD1bNGSSCKdlmnD3kp+/TzJJfZRbX5tH/XJwvLKsLskxLT1X
 0ZlYjWvrvywvdN5zQqI/yTW98jkLbZ7VZW8y/cbcZflMzQpiUcN6kXfwmHLUN6Ss6iWZLHBfP
 12kOXmwLBGgdCK//5LScB2xMgQ5QBtpFdfxanTIMEwdurDJSsb92hr+WZt/L4YNJLq8zUCVUJ
 PYsij20wm0J0bg3e/Dv5voeaoPmcCzrrsaeotu3Zsf7oZ/wgBsPVS9vL1q658ZOMrrAed1w8Y
 qB9skybwha/5PdBtutO5KZKSnBdbTL8omqsYU711C2Cpg1syOtxMHY911Ek+ZwFmjbGrZqdEI
 GsLoWSAC7qEQCDbsZDdCzOinVgVDJUR87MfuBQNlt6xsh1jghxF/1A2LdVI5Wa5zUkx7KX0sG
 Te54r4D7kB0gajdvjg0Y3mUlCBc5R+FKQltlg38VZEa73qiLldOYktKWHU0WePRafp8tqZra7
 jZDJNQ1U9kwdcDCNlaQlQMmBdeLucVw4ReBopVkKIoEhLiI/pbp0WNP1OM1UO+M8M99XPbyeP
 zkrgyLc0QXIazz7nM7Ht5qw5No4Dcfz1KX5+ZSFaOCd1LhGDwpbhWq8LFhJthtkSQ5TTkBqcQ
 hKfJtlD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-784255118-1524734382=:4978
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Wed, 25 Apr 2018, Jakub Nar=C4=99bski wrote:

> On 25 April 2018 at 11:54, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > diff --git a/Documentation/technical/shallow.txt b/Documentation/techni=
cal/shallow.txt
> > index 5183b154229..4ec721335d2 100644
> > --- a/Documentation/technical/shallow.txt
> > +++ b/Documentation/technical/shallow.txt
> > @@ -8,15 +8,10 @@ repo, and therefore grafts are introduced pretending =
that
> >  these commits have no parents.
> >  *********************************************************
> >
> > -The basic idea is to write the SHA-1s of shallow commits into
> > -$GIT_DIR/shallow, and handle its contents like the contents
> > -of $GIT_DIR/info/grafts (with the difference that shallow
> > -cannot contain parent information).
> > -
> > -This information is stored in a new file instead of grafts, or
> > -even the config, since the user should not touch that file
> > -at all (even throughout development of the shallow clone, it
> > -was never manually edited!).
> > +$GIT_DIR/shallow lists commit object names and tells Git to
> > +pretend as if they are root commits (e.g. "git log" traversal
> > +stops after showing them; "git fsck" does not complain saying
> > +the commits listed on their "parent" lines do not exist).
> >
> >  Each line contains exactly one SHA-1. When read, a commit_graft
> >  will be constructed, which has nr_parent < 0 to make it easier
>=20
> Is the removed information (repeated below) important or not?
>=20
>   the user should not touch that file
>   at all (even throughout development of the shallow clone, it
>   was never manually edited!).

Back in the days, it might have been necessary to tell people not to
meddle with Git's internals. Nowadays I don't think that'd be necessary
anymore, hence I removed it.

Ciao,
Dscho

--8323328-784255118-1524734382=:4978--
