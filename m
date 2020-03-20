Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C2EC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C68620767
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 15:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iISKlE4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCTPmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:42:53 -0400
Received: from mout.gmx.net ([212.227.15.18]:51905 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbgCTPmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 11:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584718971;
        bh=VxCQoI5sXYZ/WidDWsNXL6AJAJKVjkIptCxbLSPDS+M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iISKlE4zLRF1nXNQPbmiK3OFy8wfQf8QnKPX4VNgzDzKO5tlwjN095YoxQmsbGR5j
         CXPhJQwxyRMp+A7ikUnbWKrYhGgEhh/f7D1CCHchmTMRu6AkqnbtqDGc5FNPOgvOrh
         fmRmp/PpW2pLCwHzEY+2CYH9/FIykSp5yMGk+8nU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.160]) by mail.gmx.com
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M8ygO-1jANqO3mEA-006AVJ; Fri, 20 Mar 2020 16:42:50 +0100
Date:   Fri, 20 Mar 2020 16:42:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <20200319213902.GB45325@google.com>
Message-ID: <nycvar.QRO.7.76.6.2003201636040.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <20200319213902.GB45325@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Jek/UcrMs4KvqBjt4NFNIybnq36MH8s3/k2lOCQ6K/Tp9DuW5Iq
 h0NNHRhOufvlG0KeJA3UUd/OQPSZ3eyS1qug+s8UzD2rVwkAZ6svt3slNwx4KiwJZ3pPE4Q
 z4P04qBaCgrMAjVsUPKRX4lMkO+4cdf+Hpld6DACSS0NDHQaK5DVaFUPA6Y4w5hRqfRAXHZ
 QW12LyFxpXmmHSzGToxDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rrrnCoFR1Jk=:Vj7QeSZbuQDMJscW8pKbhS
 GyJXEIQhnq06mRhbnu0i9WmuYE2Rb5vKxgHoyvojmUoTjQmdrKG4UpZ5feU8MP0bdwpyvxzay
 AHvxzCEcL1Ljf5RWaPzEQUDVpP4Id0s2ygbVS6acWFQ5Qr1fNUNfG/IFTVTeg5wgqNEEIR7DD
 dwgv2At2wpWuTa1MZEOxyxChBS2osKjB5UK49L4mqMymB/vpPJXJDWyDR2RE7PlM50LtXssjI
 hv8diuukOyFYVMPv3BRnd85giZLDAey9JBfTFkB72rPI2ruU5KRljUVr7yjGILzhOJiz2386K
 gsDfp5zYXXP+t9Fb8u2GpVmYTWeqcJM+mtKYZzeu4mLWiKf0W/uKIuW75koi/e2A3Apc4jxIy
 plsPC6VKVDXlFZs29540WzcemYTh98YJZE7LilLY/qFiJriLClTZxILUnTGuiu8wfrRGdUnTa
 GO24wvjqcOnqrrk+kW5OzjCivKcQsi9m5ta/9CiFkr8xyNnaOYHcwmyDnjlkkPCsFLTX6p8ED
 u7zA/1MUZX8fFchlbuXX4ytS5OQlMBvFKuofBaxZaPuIGg/lAxo2cF6FH+OQx/jT91PFBf3Q3
 IU8R01sVkGOtPPSXTz5LUz/4CNfhyKni2biTefCFupDuSDqiufDNQ+Pta0DX/P8beN5k/rbWb
 84EMrIe5cUPXPyzfO3DfzGIOlSAUlkloREXmI+OqwaRIprWfZplmhj7H/bb0PrqsnZdmcWayZ
 Ond8QubLvy1yDNHo4x0xswJc10Uq9PZaoyHvoVKjfNf2jGXCjHAHuKPjwd0C84gkrvrAMehvU
 /ZQQ0qya2JkOPt7eD3z52SFrGB0S7xnkSSLlAcsfZUogQVmf3tqkXzG+wwfnr/gER6HdHnwrP
 OPR88L6UaZft49cQQwL1ZApbFNaF5InCNljKpPLvz6GMbn4Qefo2ai92BpXoXKw9Xnrq3ppDO
 P19fo+beU7WZUaFz99lvZLKSLoROHpuNN+qWqX7qeIfeA28EEYAHDEbYDEX7YJ/LEMdwMg8BW
 yEcGE4mByFSpauR+IZB+YFBsVBEafFT67nfnRfuMjr20GwqoUU+rdMzafJqcS7WfLBQm5r1hE
 A4KLXdkD+TbEPXGNCVMkytOTeboortxUCAP0DWGq0EfwvXD0qyZxZmJdcl+Jdq3MX97sw8xFA
 4t8LsRiqQR2INSMoATIrh99gLz3RqoqYpd6BO8kMxvfnQansUPYGjxoTNOb4u17Ngd4hmMrlr
 uId/CwD3F0kyVNeAG
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 19 Mar 2020, Emily Shaffer wrote:

> On Wed, Mar 04, 2020 at 10:35:04PM +0100, Johannes Schindelin wrote:
>
> > On Mon, 2 Mar 2020, Emily Shaffer wrote:
> >
> > >  .gitignore                      |   1 +
> > >  Documentation/git-bugreport.txt |  46 ++++++++++++++
> > >  Makefile                        |   5 ++
> > >  bugreport.c                     | 105 +++++++++++++++++++++++++++++=
+++
> > >  command-list.txt                |   1 +
> > >  strbuf.c                        |   4 ++
> > >  strbuf.h                        |   1 +
> > >  t/t0091-bugreport.sh            |  61 +++++++++++++++++++
> > >  8 files changed, 224 insertions(+)
> > >  create mode 100644 Documentation/git-bugreport.txt
> > >  create mode 100644 bugreport.c
> > >  create mode 100755 t/t0091-bugreport.sh
> >
> > Hmm. I am still _quite_ convinced that this would be much better as a
> > built-in. Remember, non-built-ins come with a footprint, and I do not
> > necessarily think that you will want to spend 3MB on a `git-bugreport`
> > executable when you could have it for a couple dozen kilobytes inside
> > `git` instead.
>
> This is the kind of stuff I really wanted to get straightened out by
> sending the smaller changeset, so I'm glad to be having this
> conversation (again, and hopefully for the last time). I read the
> replies to this mail, which I'm truncating as I think many of them are
> distracting rather than discussion-worthy, and have tried to summarize:
>
> Builtin:
> + Don't have to call out-of-process to identify 'git version --build-opt=
ions'
> + Better assurance that we aren't shipping a broken bugreport alongside =
a new
>   version
> - Binary bloat, possible startup time hit
> ? Libraries will behave identically to where the user is seeing issues
>   (This point is a possible pro but also a possible con; see similar poi=
nt in
>   standalone list)
>
> Standalone:
> + Could investigate libraries who aren't behaving the way they should.
>   (This seems like it'd be better addressed by regression tests, and if =
we're so
>   sure that git-bugreport is working with the info at hand correctly, wh=
y don't
>   we just write the git binary that way too?)

No, you're linking with libgit.a, you will have _at least_ the same set of
dependencies as `git`. I made that point before.

> + Avoid binary bloat in the main executable.

What? What bloat? Have you measured this?

> - Have to ship a big standalone binary instead.
> - To get accurate version/build info, need to query the Git executable i=
n a new
>   process

Worse. You might pick up inconsistent info from unrelated Git versions,
and would be none the wiser. I made that point before.

For example, if you call `git bugreport` in a Git version that does not
even include `git-bugreport`, you could pick up a `git-bugreport` from a
_different_ Git version. This is a very real scenario on Windows, where we
have many applications that ship with their own minimal version of Git for
Windows.

> Of course if I missed capturing something, please add/correct. Some of
> these concerns are quantifiable - binary size and overhead, for example
> - so I'm planning on doing some experiments in the coming days. I plan
> put together the handful of patches in the latest version of the topic
> in both standalone and builtin mode, and then gather the following info:
>
>  - Binary size of 'git'
>  - Binary size of 'git-bugreport' when applicable
>  - Time for "make" following clean
>  - Time for 'git status' on an identical real-world repo (I'll use ours,
>    without touching the repo state e.g. changing branch or fetching in
>    between)
>  - Time to editor for 'git bugreport' with the same setup as previous
>  - Peak memory footprint during 'git status'

Something that you cannot quantify, of course, is the robustness. Which in
my mind is more important than all of the above, and of course you would
only be able to guarantee that with a built-in version.

> And of course, if there's more to compare that I can quantify, please
> let me know that too. I expect I'll be ready to run the experiments by
> Monday (taking some time off tomorrow) so there's time for me to hear
> about other concerns.
>
> I'll hold off on sharing my own preference until after we've got some
> benchmarking to look at, so I can understand the whole picture.

Why? Why not strong-arm your preference? Junio and I are not shy doing the
same, and those are _your_ patches. Junio is clearly not interested in the
command at all, but you are clearly interested in it [*1*]. You should
have more than just the final say over this.

Ciao,
Dscho

Footnote *1*: I am *obviously* interested in this because it might
potentially make my life as Git for Windows' maintainer a lot easier. If
it is robust enough that I don't get bug reports about `git-bugreport`
itself.
