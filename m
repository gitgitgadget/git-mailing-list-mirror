Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B699C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 13:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD32364F6C
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 13:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBENX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 08:23:59 -0500
Received: from mout.gmx.net ([212.227.15.15]:60655 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229876AbhBENVB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 08:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612531152;
        bh=AwnEpkyCgh4LEX+kbLALnMYWvRihqD54kliDs0ZqfJw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PwTKB1V1vU5PIMbjMP4F/Dg2Cm4jIXETa1BcJldzm2y9WF0sqDWlNHcWLPRUnYKuy
         RPKOtl219Pmg2mqxEpKq4KoB/UQ+tnBLYmLqlefNZLsjyOytp1xCAPN8VDcSRTQ8wA
         qznYysDlak98uZDS4HhGUw+ReZ9jvrSGDl41fFc8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdNcA-1lhLlX39d2-00ZQH3; Fri, 05
 Feb 2021 14:19:11 +0100
Date:   Fri, 5 Feb 2021 14:19:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: candidate branches for `maint`, was Re: [PATCH v2 00/14] Simple IPC
 Mechanism
In-Reply-To: <xmqqmtwj647t.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102051356210.54@tvgsbejvaqbjf.bet>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com> <pull.766.v2.git.1612208747.gitgitgadget@gmail.com> <xmqq5z3bjuqs.fsf@gitster.c.googlers.com> <1be67634-4188-9ef3-306c-72b78ea856b5@jeffhostetler.com> <nycvar.QRO.7.76.6.2102030003300.54@tvgsbejvaqbjf.bet>
 <xmqqmtwj647t.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VU9yHc6uBzTj4+Xnehs3rWXZGrqnZJ89vTxEqTZKR1MfE7lDT/w
 lkf/TODwqjvE8Uv4oJTWX21+imNIxiBqY5aG7FG5cnUhMYPTeV38G0221kZ9P3+H9OU29bD
 hhzxhfPZNAG2kmaDTWmD117kEFxq9fXmi/lVynOAFs+GRco4F7PGu3QELWFySrQ5j0MDTWe
 rSWYrPLXcWngmJORoWXpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2mOZEsZhEMc=:Rxat811lmHmkEXx400Bkys
 826YgXe8HbgWPkgMnHkvpeGEwMw3DwdbzaHv0azv99Xpc1r1w6xlETPordvLs8zYgpMw67g6S
 fssEOtWHQ0xbW+hc0kx2AnzjBR85A1ZqwHkU7MYtLrKHhFoTZ1W1/AB7WIwE0s0OjdsDgyF8n
 xXAHSZRSUzrSwEeH+FzfvIhHzJVGx1pZsB3Bpz01kusNwmPFXRUX/N+VIUehTZVZmpI0KHS0o
 HJfeRAh+Z168HCVrADu4cNkhF+Ji+A/GgRzK5kXh5sq2fkEFrBI6rc4wTSwYyqtCtffB9ZcRF
 ZvtLA9vCC+HICP+PZ5ZYYTy8gy4+6iAhil6z1ZOtSx9I7c/fCYcHYjrRz6AfzrTG2bTlF6QbZ
 f05uwog3N891mHobVgbJzQ+pP3x4V9hAJMN0He1KMbfzPTdJIatC07HsW3nfC0DSS527Lv9Mm
 DaMpRi8EBb/bwHaQIHIk+SbbCT854PO0f0bFBpq9u3iJ6QH+l4OZ/IL03OlFCfxNki0LhbzQ9
 ypmcxBkMM6k6XkUwMyTzPIrsoQeXn2AgV4nzOYUXP+o5bOs4lo+siUg641ghqr33c7mLTcjmk
 ebcW5mQ2JtqSfcUv5YneHqo7mYEx+k+xNwKUzrLBA3titE8gFtED5QeRlsP4lIj/2XsDkzoGJ
 iPMtxVKfvzjGfIzlKboqE1PtG+mWzyMRIPE4bzv9l/UNIzM0nP8H49RTE66q6YZdYzCZbI6Yf
 qRWUVGYrSSGsjkIRI2wL7+/buC7tazST3YtOFZPJOnmqQQ5BbwumcXoo2Ur8+PA366q+vUJXu
 LjaRkVdIcFz+wirQ2QYLvg/Ws4IRVA63/n+wPxq3pXUbFYACoYFSzE7BZNIlLlr28RDziQqYk
 laiBjUgrs/LDWixoZ0izktypg0aeVbXbEX7fJ88Jk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 Feb 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The idea being that we want to be able to merge this branch as-is into=
 Git
> > for Windows (and also into microsoft/git), and therefore do not want t=
o
> > base it on a later commit that is not reachable from git-for-windows/g=
it's
> > `main` branch.
> >
> > Maybe it is time to merge `jc/macos-install-dependencies-fix` down to
> > `maint`? Then we could base Simple IPC/FSMonitor on `maint` instead, a=
nd
> > would still have the benefit we want.
>
> Now you mention it, if we ever have an update to the current 'maint'
> branch, we'd trigger this known failure in macOS build without a
> good reason, even though we have a fix that has been in use on the
> 'master' and above.
>
> I definitely qshould merge the jc/macos-install-dependencies-fix
> topic down to 'maint' now.
>
> Are there other topics that deserve to be in 'maint' that are
> "obviously correct" people can think of?

I looked over the branches merged into `master` that are not in `maint`,
and from a cursory look, these seem to be good candidates:

- pk/subsub-fetch-fix-take-2
- rs/rebase-commit-validation
- en/stash-apply-sparse-checkout
- ds/for-each-repo-noopfix
- pb/mergetool-tool-help-fix
- jk/t5516-deflake
- jc/macos-install-dependencies-fix
- jk/forbid-lf-in-git-url
- jk/log-cherry-pick-duplicate-patches
- js/skip-dashed-built-ins-from-config-mak

=46rom a cursory look, it might seem as if ds/maintenance-prefetch-cleanup
would also be a good candidate, but it is not based on `maint`, although
it _does_ appear to fix an issue introduced in v2.30.0-rc0~23^2~8.

There is another candidate that I am not _quite_ sure about:
dl/p4-encode-after-kw-expansion. It _seems_ as if it would be good to
apply on the maintenance train, but I am uncertain how important a bug fix
it is.

There are also a couple test updates that might be nice to have in
`maint`:

- nk/perf-fsmonitor-cleanup
- mt/t4129-with-setgid-dir
- ad/t4129-setfacl-target-fix

Finally, there are documentation updates that I would probably merge, if I
was tasked with updating `maint`:

- ta/doc-typofix
- pb/doc-modules-git-work-tree-typofix
- jc/sign-off
- vv/send-email-with-less-secure-apps-access
- ug/doc-lose-dircache
- ab/gettext-charset-comment-fix
- bc/doc-status-short
- tb/local-clone-race-doc
- ab/fsck-doc-fix
- jt/packfile-as-uri-doc

Ciao,
Dscho
