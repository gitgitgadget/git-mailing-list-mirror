Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510C0C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 22:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E683613AA
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhGEWD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 18:03:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:49627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhGEWD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 18:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625522444;
        bh=SGK5/qW0Dv4F21lW04CZEuHzGMWIfZe/U3V0tTDQ8XA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kaWq5alIZPpY9Cf/gFn4z2izbAE5c6zWiKNoH3Ynb9PlMd2rsc05WdBQK3mJxFvoa
         Q1m+NU+Yvtq/6qz+Chdkl4KLDWH/DVWmirjTyVW5KAgWLQP9WUrxWlTfjqGYY7l11a
         w4mtnGuunMi31xY1PI37BHTHwfdp9LJN3pC8r8ps=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQnF-1lzDKz0FfJ-00GsZT; Tue, 06
 Jul 2021 00:00:44 +0200
Date:   Tue, 6 Jul 2021 00:00:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 02/34] fsmonitor--daemon: man page
In-Reply-To: <877di9d5uz.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107052352560.8230@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com> <877di9d5uz.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-413430032-1625522444=:8230"
X-Provags-ID: V03:K1:tnXHQ0DpsEv2KIPcWx8X5yTWtfbWd5jqVn0TrOj6Ch3JZmQtSDL
 QIwf9jjE+HDo3VuARn3aDTY5TeMoYLxsG/RwRBPfU3PRIZMTKlCrD1odgByX2eSrYJpSBl6
 nebStplsefC+ZkcbkzFBH0FEb8iX1zS7e7fWEE6yi86F84WbrPMDe3DKVo20Er28XohfvGF
 mUtGQ0VjP2aO9N4JIIjQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vUKw5gotCIY=:NzvykK40bVrsM2E4OAPP6k
 lKimAtGnYH3XN9K9IAuqmIUvbxvU/dzkuOOlhC6TFaYay0WNBeRwTEpUxt4jZ7G/5r1Sh0sWq
 GorqXZE56Jicumc9EBCZWTwJzMZ5ud89RYmDicePed/i1neNOyBLtOGRXi7lOGYbHaLGRFWN0
 +6jvImWplfuH/Gbq38/kVVPSr7OLY6GUC2nqgsCT4Nh40UqTZOQfy8gewfdrk/hzoBX4tsGTe
 faZgLtbegJ3GK0bbN+nKEMoSw2Shdql6beHB5ojOZBae6VFVh5IUw5O5wlp8iwL+N85zT8BlE
 o1ztGgqGiaHDawqoODxxdFfE1ZTWFQ7+rBVfFDX7fLKOSkRXBYNKzA3SjgyFuVyPmfLkSsnSd
 sCvXbLayuzBY6IIzpkoaXLdt2eh25Tum+eI9j31iYxUBhMhjUrGBhKtZH+Gx8slbXm9hpVmWj
 F+kD4lZpiFm28qWbZwMZty0e1FzOnZqlaF904g4RTIRD8gsSbIhTy16CgmLx664HLogsiwgtF
 hLMMFNcv30UXyA72PblT1sqxVveAecwQKLR61T0NPpZ1jEIj5GWErdo7bcNmVlAcBCMYbrCwL
 2tDx4a1+yntA4uZsvrhO+K+iam7Ph+3jxV2GVB1v01uzBXhZfBmflCIbZFPfMrcFYdCodZ6EF
 W/DMMKNak3ZG1ISmekoXqdg3z4jsvxp3A43S/1dXICpce+j748Cc7w9EGK82xV3DPSw+R8TuN
 MLQrKQre241P/zOMuHKGQUFecXvTgkJY3QX0poaVxqCWOnDKTr9pgoCrynV6gsFTZplo3GQit
 ECTvNihrC/ZVZUi+75l7udCJ+Bv8Akp9mENSlPVGA17IxTVjGUt8pwiAuXtNNo58aSjGqQBhl
 fZIMF4d095NsTcSUzcj3JwIYmOPg/hbWm8bl/kEIfB+vBT8JikNxaOrTuhHzuueFmzpJqUuS1
 eLZGOJLXAMsoZJkiHexZG06jOZZmGIEpqbyozJq2KGln9EcgYXKKyoBuX2aaoEXehzhDEYqQV
 Qxf/YqmUAOmyPSuVzgZVWLKMDjGqrY8F9pSt/1ZzEdH8bjayespaY+QiseZRoQ+CZlH87xMsQ
 h9AjqfvT6SusgBGVQD8fmpjpleYKg2h+xXakErABO+fsw4CmNeouI/fGA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-413430032-1625522444=:8230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 2 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
>
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Create a manual page describing the `git fsmonitor--daemon` feature.
> >
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > ---
> >  Documentation/git-fsmonitor--daemon.txt | 75 ++++++++++++++++++++++++=
+
> >  1 file changed, 75 insertions(+)
> >  create mode 100644 Documentation/git-fsmonitor--daemon.txt
> >
> > diff --git a/Documentation/git-fsmonitor--daemon.txt b/Documentation/g=
it-fsmonitor--daemon.txt
> > new file mode 100644
> > index 00000000000..154e7684daa
> > --- /dev/null
> > +++ b/Documentation/git-fsmonitor--daemon.txt
> > @@ -0,0 +1,75 @@
> > +git-fsmonitor--daemon(1)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +NAME
> > +----
> > +git-fsmonitor--daemon - A Built-in File System Monitor
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git fsmonitor--daemon' start
> > +'git fsmonitor--daemon' run
> > +'git fsmonitor--daemon' stop
> > +'git fsmonitor--daemon' status
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +A daemon to watch the working directory for file and directory
> > +changes using platform-specific file system notification facilities.
> > +
> > +This daemon communicates directly with commands like `git status`
> > +using the link:technical/api-simple-ipc.html[simple IPC] interface
> > +instead of the slower linkgit:githooks[5] interface.
> > +
> > +This daemon is built into Git so that no third-party tools are
> > +required.
> > +
> > +OPTIONS
> > +-------
> > +
> > +start::
> > +	Starts a daemon in the background.
> > +
> > +run::
> > +	Runs a daemon in the foreground.
> > +
> > +stop::
> > +	Stops the daemon running in the current working
> > +	directory, if present.
> > +
> > +status::
> > +	Exits with zero status if a daemon is watching the
> > +	current working directory.
> > +
> > +REMARKS
> > +-------
> > +
> > +This daemon is a long running process used to watch a single working
> > +directory and maintain a list of the recently changed files and
> > +directories.  Performance of commands such as `git status` can be
> > +increased if they just ask for a summary of changes to the working
> > +directory and can avoid scanning the disk.
> > +
> > +When `core.useBuiltinFSMonitor` is set to `true` (see
> > +linkgit:git-config[1]) commands, such as `git status`, will ask the
> > +daemon for changes and automatically start it (if necessary).
> > +
> > +For more information see the "File System Monitor" section in
> > +linkgit:git-update-index[1].
> > +
> > +CAVEATS
> > +-------
> > +
> > +The fsmonitor daemon does not currently know about submodules and doe=
s
> > +not know to filter out file system events that happen within a
> > +submodule.  If fsmonitor daemon is watching a super repo and a file i=
s
> > +modified within the working directory of a submodule, it will report
> > +the change (as happening against the super repo).  However, the clien=
t
> > +will properly ignore these extra events, so performance may be affect=
ed
> > +but it will not cause an incorrect result.
> > +
> > +GIT
> > +---
> > +Part of the linkgit:git[1] suite
>
> Later in the series we incrementally add features to the daemon, so this
> is describing a state that doesn't exist yet at this point.
>
> I think it would be better to start with a stup here and add
> documentation as we add features, e.g. the patch tha adds "start" should
> add that to the synopsis + options etc.

Incidentally, I had structured the patch series that way until Jeff took
over from me last year. And it was definitely not more reviewable because
it was not clear from the get-go what I intended this command to do.

Therefore, I object to your suggestion.

Ciao,
Johannes

P.S.: I will not address your other reviews in this patch series, mostly
because I am technically off from work this week.

--8323328-413430032-1625522444=:8230--
