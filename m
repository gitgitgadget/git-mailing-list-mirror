Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F7C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D844A24679
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Alhv+4CO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfLORbV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:31:21 -0500
Received: from mout.gmx.net ([212.227.17.22]:54365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfLORbU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 12:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576431076;
        bh=6NObxY6xaxDoJp8Y2a8yH1NcCvVGzZ03eEIeADmh3XI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Alhv+4COg+baGfClXVEDpvKeDKDFqdMy0a9Dy2IxJN6v+Psv/3HCOwZeY1DEbBLe+
         rRLHcVKHGR+JkiMc1v9JX+Mrv/JJjz53VHLDVvSA5k5gEitO4qNRVGR5zuFnWxT4D9
         NJLEkJlC4PK9FqCQxNCzKvzIUAOg0DEFtQtPb27I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1heF2M0Ki2-016xII; Sun, 15
 Dec 2019 18:31:16 +0100
Date:   Sun, 15 Dec 2019 18:30:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 4/9] bugreport: add config values from whitelist
In-Reply-To: <20191211204811.GC107889@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912151826380.46@tvgsbejvaqbjf.bet>
References: <20191025025129.250049-1-emilyshaffer@google.com> <20191025025129.250049-5-emilyshaffer@google.com> <nycvar.QRO.7.76.6.1910281506040.46@tvgsbejvaqbjf.bet> <20191211204811.GC107889@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Z3wxfK7iQCaWd6r3eJDWIKcpZ16Tzaxgr3aAj2adVWEdD9PQSwt
 3gzNjpNEgWmYI7+1/5ca7gVElBdYbdn4rJ9+ohSG9w3lNiANAtASIq4HDwSxhU/mcSIpmd1
 CZOnrTG++qMFOgzSDV/H+yq7xe4IIRRindP/aaOSQXZZRebS/p5M44dsllgGBk0N0/CCEwn
 c0TjlZzLBpRedA+lVnIuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:q2bLiwmcXYE=:vT6NcZlVZHVOWECFDHMaz/
 sF4dk0qkYUXvMxlDkmSd5E9Z1cZAa4VySqdl56EQYCgF+bACuiCHBhtp1ZkDccAwYVROB9M6Q
 zmF2ShYrt2pHuq5mY90foKRayZ+E/1z3G8tSc+27QR55ywTlQ+6iuR73MEpYKsDpvW8QAP2wy
 vzQZoW2MeuOKZYyvUCbzdPgMe+QEMrS03f0ycrINQbceQvpmUMiClgi3tMFYiOnByRVR+Of2O
 5CVDLpQG90mJGiH1ddohCVD+dOeUhf+PHp8S1NBXyf6H2XUZyZqp7WlhcBPGQjnqvKqM6vavK
 p4ehi0jy54yTta+m0ubFqPfF6aklFfQ94vGZOt7Cb0SYgZmLs34+R9bCRtXWKaaxWfSkbmvYd
 GPGITbhEizcJ9P+6R9fLi7IAquaj1XdltdEX/UvNSU+lJXISUQKA/uSWkGfG1G2CdSWHY4FmV
 jQGIovHFyfERMSxAjjr/2S3GlOFGbbZ5Qs/XcM5NWY71nkimfZA8JbZ3vVN5VRH/QoF0nAYn/
 0BEqYIEyKIjtUhsjIJ2qJKTy3XanSDzGV6wwhPHKQ8Cg92PqXPZoI7l2Upmw23ni6S36snUbm
 DpvdZnP0RKaMWLxq7a+BPFdW7vIMOoOS1CwWjgPdT99QIt7bni0r60vir7fQd+4f0imEY5Vl3
 /5fVRj798k8EgXV/0Jup1qxk3CHSa3gxXjPEOijWExLVzWfsQpVnwtaGOmu6fE0RxQncFS+9R
 jot+RBsSXaD5I0/deuaheLlIOzLOcezXsnf+f1LhCoek/Z0CRb65XCooWIe6bInpJfPVAnkfE
 3Qnecys+nHAih6al5TgCZmhfqGeGQctgiNhh1UlVX9S5DWgAE83MWvyuz+yJLinQVkRa80BS6
 Ha/1OmxApVaCbqs0hM8/OfZBCWY4+6itcV+icD90008Vi1NW2QauP3JaFkTON//6OV0X6MruF
 +UAiOcAZp5B2rhWgI0eHFd9wC1UCF3VUmmwBf6/YNqsexp7I5LyufTCZC8m2SwCSZAfxR5uaA
 UfIYqPkFDXRpSHS/+6PfM1T5FUCUg5BPlhZWqPnkqKH4wnmzWIzxtHGzWEzxmlHKM3XuibM5z
 H8wcWlQgHB2lmbjvgDkQVfDUTbxtsmlQ45V6dfsmvL/upnpCzujh6ctBDcutUny4l0agMFWEI
 9MZ5nr1gN7nGh4UGbuni5l9bUu3GBTnDmo2tZWXV7ewIeTmHm+O+a+bYGxtNamzTTWBDzidb1
 bElZb3ah3ARTdQHmgQ+rZ8udewyE0VpMHjVfsPK+75toQF+EQ5CaVUWHJkwI=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Wed, 11 Dec 2019, Emily Shaffer wrote:

> On Mon, Oct 28, 2019 at 03:14:35PM +0100, Johannes Schindelin wrote:
>
> >
> > On Thu, 24 Oct 2019, Emily Shaffer wrote:
> >
> > > Teach bugreport to gather the values of config options which are
> > > present in 'git-bugreport-config-whitelist'.
> > >
> > > Many config options are sensitive, and many Git add-ons use config
> > > options which git-core does not know about; it is better only to
> > > gather config options which we know to be safe, rather than
> > > excluding options which we know to be unsafe.
> >
> > Should we still have the `// bugreport-exclude` comments, then?
>
> They were optional (useless) before too. I can remove them if you want;
> I suppose I like the idea of having precedent if someone wants to build
> their own internal version with opt-out configs rather than opt-in. I
> can remove them if we want; it doesn't matter very much to me either
> way.

How are you guaranteeing that this information does not become stale,
like, immediately?

If you _still_ insist on keeping those comments even after answering this
question, at least please turn them into C-style comments: we have no
C++-style comments in Git and want to keep it this way.

> > > diff --git a/bugreport.c b/bugreport.c
> > > [...]
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void get_whitelisted_config(struct strbuf *config_info)
> > > +{
> > > +	struct strbuf path =3D STRBUF_INIT;
> > > +
> > > +	strbuf_addstr(&path, git_exec_path());
> > > +	strbuf_addstr(&path, "/git-bugreport-config-whitelist");
> >
> > Hmm. I would have expected this patch to come directly after the patch
> > 2/9 that generates that white-list, and I would also have expected tha=
t
> > to be pre-sorted, and compiled in.
> >
> > Do you want users to _edit_ the file in the exec path? In general, tha=
t
> > path will be write-protected, though. A better alternative would
> > probably be to compile in a hard-coded list, and to allow including mo=
re
> > values e.g. by offering command-line options to specify config setting
> > patterns. But if we allow patterns, we might actually want to have tho=
se
> > exclusions to prevent sensitive data from being included.
>
> Hm, interesting. Do we have precedent for compiling in a header
> generated during the build process? I think I saw one when I was adding
> this script - I'll take a look.

Yes, we do. The entire `command-list.h` is generated during the build.
Look for `GENERATED_H` in the `Makefile`.

Ciao,
Dscho
