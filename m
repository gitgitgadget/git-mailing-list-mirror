Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 651AE1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 13:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933454AbcHYNjr (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 09:39:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:59702 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbcHYNjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 09:39:46 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Las1k-1asYDg0KHw-00kOwB; Thu, 25 Aug 2016 15:21:36
 +0200
Date:   Thu, 25 Aug 2016 15:21:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
        meta@public-inbox.org, git@vger.kernel.org
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <02c1c636-b0b4-8730-68a6-18f017ed3410@gmail.com>
Message-ID: <alpine.DEB.2.20.1608251508280.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160818204902.GA1670@starla> <alpine.DEB.2.20.1608191720040.4924@virtualbox> <20160819223547.GB16646@dcvr>
 <alpine.DEB.2.20.1608221509010.4924@virtualbox> <02c1c636-b0b4-8730-68a6-18f017ed3410@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-184351075-1472131296=:4924"
X-Provags-ID: V03:K0:ijoMtVCTlNlzRlJuLwBXGJpCUsVxrOiCma9S37O1Yx/4YHSsU56
 0SP3XPzeKJKME0qiVInakWq2X468lcoDP9tX5rSKsPTima9FNueRBWJoXSo0flGxspzFMXR
 X0AURLvOwvnz8Kw2d+SdIOYJk7cH3AfJkAVYJQ8xMPSr+4KXTeoHV5r2Xj0aHHj2kTrokIA
 it6Zc1Oiumkh2+DlFLHsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AMw3IoQWgyc=:HBAzhwhGxYXnxEmM05zq2y
 ylbswjUuYAynhM19zDhLwu1NF+np9RPp43fr/ZuZjily+PdF+DaVSNV8vXVb4gmeJFNjHucGt
 WnDlOd/bcyrZxPchiYXIK0QiAcaOITn103FupQctZGt41liSKuKRL1QMHoepHpspjstty2t9l
 LJkRQP81L7u0MO+M1rkvUeoCaEK1YJJXDQgSB3wCS3YVFGXxpNpmzQbP+OGO0Fv5PUHMIy6eu
 dFyY2wvTL07azqyG9fpSeEJwnGJvUnwm599RpzYzgltXDsD5SLyelPKkixbCjF6pAC+tSJfVa
 Ao6fo51uL0jjmjYbd/ubZ+q9HiCG9r+tqwW9cIpapj7uMifpZAgCep+3WebScnWdzGfdWsSVe
 erFjpRE8YV7KEVr33DQsAAZWbIGbvjOb26heQg71PLzEB4pB3xZLai97WTAGbpC2d03WUayw4
 p3GcmkZSvDd7zXb/E1q4e0+iaIwqbyYr2/PIrM07zk9YdaN2ykFBCa/mS0zSGPaVCwAUHAyQL
 V4foB2E6jXfcjmC5fDydvtsthzjBRA85lsi2RRdgSdRwN1OuK4mPDV0XhmZkWosoCng+vPgVb
 i/kz6VayekH9JGBLjhC0fsj/PtLG3YT/3CqpyBiF5B73DlXW0Olh3dj31DueXIzm7wgjSEpmH
 evjaFH/K1WWHdGZX5K8oQks1DIG6bmOEyzSakkBa1FlGIdcFlQpxFiCC8c6LWcljg5E1zgrau
 NQwhe15hMODTlJapk5iJ5K/4fR+H1dUwrST99cLGLL1h518deIxMUS4rX4w9le5BGE7xGiEl0
 QVjZVGU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-184351075-1472131296=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba,

On Mon, 22 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 22.08.2016 o 15:18, Johannes Schindelin pisze:
>=20
> > So unfortunately this thread has devolved. Which is sad. Because all I
> > wanted is to have a change in Git's submission process that would not
> > exclude *so many* developers. That is really all I care about. Not abou=
t
> > tools. Not about open vs proprietary, or standards.
> >=20
> > I just want developers who are already familiar with Git, and come up w=
ith
> > an improvement to Git itself, to be able to contribute it without havin=
g
> > to pull out their hair in despair.
>=20
> What is lacking in using submitGit tool for those that have problems
> with sending patches via email?

Where do I start? And where do I stop? Here is a *very* brief list of
issues from the top of my head (and the history of my web browser):

- You cannot open a PR on GitHub and include the PR's cover letter as
  cover letter: https://github.com/rtyley/submitgit/issues/9

- You cannot Cc: people explicitly:
  https://github.com/rtyley/submitgit/issues/31

- submitGit does not include any interdiff

- it is really hard to get back from mails to the corresponding commits

- you have to register with yet another service to send mails on your
  behalf. Would be nicer if the mails could be sent from a submitGit
  address (moderated, of course) and did not need a separate registration
  step with some scary permission granting.

- submitGit requires you to go to a separate website to interact with the
  submitGit web app. Would be so much nicer if it were a bot operating on
  PRs.

- comments sent as replies have no connection to the PR *nor* the commits
  they refer to (making submitGit basically a pimped up git-send-email,
  nothing more).

- submitGit would require a substantial effort from me to learn how to
  extend/fix it, to run the web app locally and run its tests. That is a
  rather steep hurdle.

This is an incomplete list, of course.

> Submitting changes in Git comes in three phases:
>  - submit email with patches
>  - review and discuss patch
>  - apply patches from email

You forgot a really crucial step. Maybe you did not go through dozens of
iterations in your patch series as I regularly do, or something, so it is
probably easy for you to forget:

  - find the commit in question, run rebase -i and patch it as suggested

This is something that costs me quite some time to do. It is easily the
most annoying aspect of the mail list-based approach for me.

> Pull request via GitHub / Bitbucket / GitLab is easier than sending
> patches via email (pity that GitHub et al. do not have such submitGit-lik=
e
> automation built-in).  But I think email, with threaded view, careful
> trimming of quoted contents, multi-level quotes is superior to exiting
> web-based solutions.

They are not exiting, but I know what you meant.

The thing is: GitHub does not need such an automation. Because most
projects are pretty happy with the process centered around the web app.

It is only projects such as Linux, Cygwin and Git itself who refuse to
allow for tools that would let the majority of potential contributors
stick with their favorite way to read and write mails (I am talking about
users of GMail and Outlook, of course).

Ciao,
Dscho
--8323329-184351075-1472131296=:4924--
