Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568EF1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 21:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751398AbeCZVQW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 17:16:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:55129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbeCZVQV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 17:16:21 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKKaI-1f2Dtp2d1y-001esp; Mon, 26
 Mar 2018 23:16:15 +0200
Date:   Mon, 26 Mar 2018 23:16:14 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Daniel Jacques <dnj@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
In-Reply-To: <CAD1RUU-oUXx+mGUe6QuTawLhLz1nGFZiOWnF7=DVA1uf455zfw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803262305010.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180325205120.17730-1-dnj@google.com> <xmqq4ll3e5pb.fsf@gitster-ct.c.googlers.com> <CAD1RUU-oUXx+mGUe6QuTawLhLz1nGFZiOWnF7=DVA1uf455zfw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6WRGvckaRzPdE2ikjcVApwAJVPsSODsgy1vWDmbyxL9mfHw65R9
 On5CQLdW7Lh64FkphBNHEPcNJk+734zOtdLAt668jpeI/ZmJOi0XevoMECFDOodOqiVEiga
 QSJNshX7ZboN86SYWJu2flX0hPNn3ZxZJkkGKa544LQ8LkCaEKhxKt4V9uIIw/GzEPM7NED
 JiiTYyC9ejjwQsxP/NgXQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9JJ8BozCTKc=:D/6vr1ZjbY0KtObAFVuczR
 44zs79a7heE4t6gZHoR05Qlsw9XJi4fKcClVzFYQq2hb5U6hzwW5ef9OQzPDEo6SxzTqwd9bs
 3RW0WIdrMpYLEs0Ka8CyC225XNTXABvOb4es0AKU42njRTjwYvzOxhUPxsN8E4xMvUyXiYe1N
 ni/u7SJAzeYIOwKajyA5a6zi+0M0+T3yLhpAL1bA6mMUqRltaL3NSlOGW5FW0OaUmLVRvMTjB
 8YXauwHZP4QFP0IwFcXXoW7OiViZWFpXdeRA8gGmlyb5jRC9ACsXAoDlMKWm+l29PTwIb503n
 mjgUgeg6kit4/Fjagi4JNQvaheTxDyCdplKGiTK6r2bneA2kcUWVZzvHZHqu/dC9bL6LeiG3E
 GETN2TVPqNbvHGiUWqV9nihyZmDePoN6JIJa+S9N0MktbgCoP+RdxAM6M1aXz1OJsv9C2+bdT
 4CG6nKFZJFQzaVTHJ2hGg++RSbeBtyGR5boTg842DfVJ7resbvfNQFnJtorOWOkiYGWzWCl0m
 Oq+19Si9YgswC4uA/fYEh1L3iu1k6JQy3a4uWqma8bkzlgGPjPXC8TUrmr2RBIC8mx4Lnlrre
 oWKDkEbu7IdpPpwcm9g3C07/sQcQEyPVoEeOgauYEV4NBIWuatyTEu45Vkc7i3TBM/7rrK96l
 fWM/GEZubxrFeYq9LyYS8mlviYhhCZ+LVl57++1Lfq+LARJUes1zEFmo7VrJ5H/JvbS1LvJ6L
 7pbhYeup/nSd7jjFeLie1bFaSYP7RY0JC3iHhA/c0O+PGKxOsAFgZ1rG1jo0irETq4jSZADeW
 7fUk4ovOUrp6Ze9vR2Ku5S6/SJWwytCODnoECStik95C1i2TOm0/QIjWoI76/EmouK3BUtY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 26 Mar 2018, Daniel Jacques wrote:

> On Mon, Mar 26, 2018 at 2:01 AM Junio C Hamano <gitster@pobox.com> wrote:
> 
> > I wonder if the relocatable Git would allow a simpler arrangement to
> > test without installing.
> 
> > I am asking merely out of curiosity, not suggesting to make a trial
> > install somewhere in the build area and run the built Git normally
> > without GIT_EXEC_PATH trick.
> 
> RUNTIME_PREFIX resolves paths relative to the runtime path of the Git
> binary. These path expectations are constructed around installation
> directories, so I'd expect that installation is a prerequisite of testing.

Indeed. This is the relevant part of the code:

        if (!prefix &&
            !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
            !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
            !(prefix = strip_path_suffix(argv0_path, "git"))) {
                prefix = FALLBACK_RUNTIME_PREFIX;
                trace_printf("RUNTIME_PREFIX requested, "
                                "but prefix computation failed.  "
                                "Using static fallback '%s'.\n", prefix);
        }

Note how the argv0_path (which is the absolute path of the directory
*containing* the `git` executable) is tested for several suffixes, i.e.
trailing directories, namely

	libexec/git-core
	bin
	git

That means that you will have to have your `git` executable built in a
worktree whose absolute path ends in one of these.

While writing this reply, I was wondering why "git" is included in this
list. You know, I can see libexec/git-core and bin because that is where
the `git` executable is installed to (or hard-linked to). But "git"?

Turns out that I am the responsible person for that (024aa7d8d51
(system_path(): simplify using strip_path_suffix(), and add suffix "git",
2009-02-19)), having assumed back then that everybody who uses the
RUNTIME_PREFIX feature and works on Git does so in /git/. Which is of
course no longer true in general. For example, I myself got bitten by this
when developing some patches on top of Dan's patch series in a *linked
worktree*  of the name "runtime-prefix". Oh well.

But the short answer is: no, you cannot rely on the RUNTIME_PREFIX feature
for running Git's own test suite. The GIT_EXEC_PATH method to force Git's
test suite to use the compiled executables is still required.

Even if it is fragile: if git-FOO exists in <prefix>/bin/ and some test
relies on the FOO subcommand but we removed it from the source code to
test whether it is needed, the test suite would pass just fine because it
finds git-FOO in the PATH.

*sigh* seems that I cannot write short answers.

Ciao,
Dscho
