Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EECEB1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeCORQ1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:16:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:54635 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbeCORQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:16:26 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ldspr-1eE4ut3mWx-00j0uu; Thu, 15
 Mar 2018 18:16:21 +0100
Date:   Thu, 15 Mar 2018 18:16:07 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Daniel Jacques <dnj@google.com>,
        git@vger.kernel.org
Subject: Re: Why don't we symlink libexec/git-core/* to bin/git?
In-Reply-To: <xmqq37121vz5.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1803151807060.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <xmqqtvts22za.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803071333590.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <871sguorb5.fsf@evledraar.gmail.com> <CAD1RUU_EuLSo5fPjZe7v3882Tkx2Dymxn619smS-wuoejKyG+w@mail.gmail.com>
 <87y3iwp2z0.fsf@evledraar.gmail.com> <87woyfdkoi.fsf@evledraar.gmail.com> <xmqq37121vz5.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-40666139-1521134183=:64"
X-Provags-ID: V03:K0:l8Xx9oho81Dw41DCZHNofATJMTBqHIUOLIxPF9h7jXE9hhqM+pi
 NS4iyJ0Ovf7dg09bj4Z2X+fW6/s1KEMHs0uFqoIjE+VJNc/7cEsiF22wjHqps4SWoqGDyCx
 zvyXzKENMYiM4mAug32dTcpozyF2R6qa2JScsc12qktoMo5Q8x4Kff+WIgD/hbnzMvlI/h3
 /Nv6CnALIfLdeTv6KpBXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vyAR39MUWfk=:eSluaGM3YNR+a1TLw9c4Nb
 3FAw+1osSeeYhXmBpkjkLFcb3PZuUmsGCNm05nAXcdPmcDZx2Q+J3W5zPxo20tGu+a27quZxn
 zAybLuZ2+d6+KmeL8vBz07FIrjz6Z+O/p08wR39i4nQ9Fc5lXg/pYFXMfX1cMH81VgHSkzPhw
 a/J8mCCvS8PKO5Q0Mm9v2diQdweD8NzSunliLdXiauKsz6dBgJQBUO3vfEqC8MtX+5eF4/X6M
 Ad3j7HxK9AdpePTFUJjYbCIfrGcxRQDWy1Sg7xy+FJXzn8XFnhkdH72b7tkOyr7vp8RK6oI/0
 8ORaF9C723KyPs8RU6GDp1MJHLgxxSDk1OFM7JWgmwTVPMasNOh24daXrND6Ebm4trg251NJ6
 Qu9UbttUKruTD3PwoE6+L9/CGIAYfuiAIqBPZQuRMCjyFVygY+8J66eL+po8FKrqKDcCSSFev
 00yo3fNzN93F8Hq/OIXWHrM6ggFPHYQkQsrkSP1W2MXL0+BIjFWhgjkAaHdZ+5hw17avycYcM
 vI+5LjTQxD4cr0Mzf0123b+P1qF03W/x/rcWzOLB97oNxUMbDPqO7oZwQpa3XfF0Oc9oPFyIZ
 qIXyf6golNM5S30dTLU7cZkyFVaurhbnGROrrpANqM+QeXtomXs+RVS3UAEQQ9AKFWW25z/4c
 ElO6pb11AQHCG5GCsFnDKqFp2wz2t19gxpR0K8MFCKcQBPLreJGDTufnpcprG/4mXtJ4J7MW9
 h3eKpthg/KPMT2mPQEns913XcMTixgLyUw6ep6LEPVkN8DTJwPXBbOtbiZuVzpVueuAAB1fXz
 oycB37SEDNMd0GmwKIeCQgtxEM8oPLDEZ/5vEsbti/d/vQ+S8c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-40666139-1521134183=:64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Wed, 14 Mar 2018, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
> > Is the only reason we're still installing these binaries like git-add i=
n
> > libexec for compatibility with some old installation where that was
> > added to the $PATH, shouldn't we (and I can write this patch) also have
> > a toggle for "I want the modern install method" which would not install
> > any of these binaries like git-add at all?
> >
> > Then the libexec/ dir would only contain things that we really do need
> > the bin/git to dispatch to, like git-svn, git-bisect etc.
>=20
> Removing them by default was proposed and failed; see this thread
> for example:
>=20
>   https://public-inbox.org/git/7vr68b8q9p.fsf@gitster.siamese.dyndns.org/=
#t

Let's add a very, very important piece of information that was missing:
this thread is from late August 2008. We had deprecated the dashed form
"only for a couple of months" by then (we removed the dashed form from the
completions end of April 2008 in 799596a5d06 (completion: remove use of
dashed git commands, 2008-04-20) for example).

> If a packager ships Git without these copies in libexec, that is not
> the Git that promised users that prepending the $(git --exec-path)
> aka GIT_EXEC_PATH to your $PATH is a valid way to preserve their
> older script.
>=20
> I do not think anybody actually minds to have an option to omit them
> as long as the users understand the consequence (i.e. old promises
> broken) and know they are not affected (i.e. they do not have
> scripts that rely on the old promise).

I am glad that you changed your stance from "without dashed builtins, your
Git is broken" to this much more tenable position to state that it may
break super-old promises whose use we discouraged already a full decade
ago.

To add some interesting information to this: in MinGit (the light-weight
"Git for applications" we bundle to avoid adding a hefty 230MB to any
application that wants to bundle Git for Windows), we simply ignored that
old promise. We do support hooks written as Unix shell scripts in MinGit,
and we have not had a single report since offering MinGit with v2.9.2 on
July 16th, 2016, that it broke anybody's scripts, so it seems that users
are more sensible than our promises ;-)

Not requiring Git to install any type of link makes it even possible to
bundle it as .zip file (which, let's face it, is the de facto standard for
cross-platform archiving).

Ciao,
Dscho
--8323329-40666139-1521134183=:64--
