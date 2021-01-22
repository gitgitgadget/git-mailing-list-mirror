Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2275BC433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E558F23A9A
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbhAVQ4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:56:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:57159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbhAVQbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 11:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611332984;
        bh=NXyjX1TTLmcrphbuCQSvrCs9MtPbwwFMmxFZ5JIJhNY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gianjxyH/byRhq/vHAsoHUA1SXcgJaB80zQY/04GkHeSWGVjUos61qv5qppst/RGw
         JTW8C75OBVLwFvWyvsx3342dPDqlTU7+LhXV2j+PBvpdzpvQhK8DLPVt2PuZjfyK9x
         z5r/RK4wX1CE8oAEG3R1kO9UQlIOyLkNsUEnPRz0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.115.203] ([89.1.213.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1lrdzd2ZgX-00tPyU; Fri, 22
 Jan 2021 17:29:44 +0100
Date:   Fri, 22 Jan 2021 17:29:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
In-Reply-To: <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net> <20210109224236.50363-1-davvid@gmail.com> <20210109225400.GA156779@ellen> <xmqqmtxhd1zx.fsf@gitster.c.googlers.com> <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com> <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com> <20210116042454.GA4913@ellen> <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wgWAsk3Az4fh47ED5K0AGZQDWP0wGPuimO2k3jcQWqOrq92mY6s
 H9hHeLJOifm6KTCTJNyIIfTdKJztyWCZGbwWvxkUoqCkYb3gvQmykMYj25Ia0FIEJ21ow9x
 C1gmXVD8HWK7UN170hCZ3LLXYpsbxy6U3C2CTrZLdg0zDwc9w94ewX5SS7FiKFOqHSo/xzR
 TkNuo+MWcTuZmyNvhWMNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t+qut+V5Nzc=:zmzsnZ4VuNEUGaEGvM7PyG
 7tB1133bf6unbe/INOPQPreQY6MJ5CXHYvJJPp42AjXVPJouulvp7a+iD2XBaI6g+kVISq1HR
 Ivrzh1qtpS3VHAFqhWDiosaRpC2L11jmsLpnAC3J9vztSjPRdAKrMtQn6JulxAn6TjuEjWZZW
 nrBVHkeumtB5Ip+qkHXyftbAuVtLjSJkA3rTan9Kp2NraZyKonBAza5antxTUdM/ikqNoiv1r
 Tf7U3NERsib6/7FkIV+3ZyLIZLjf9zqQKWCVPfoWVVbASXZdptTWTSS2InkEaOFXY+NR8qW6C
 QE8fz094TdyBGv757FQycxqz4ModU3JkKbGdjQxh0Tgt0xlZWPZphokQZJ1rSRs4pcBt2uIuK
 IgDtmA58e9/fCuksQ5er+GpwpCZM8ji6TWaUPlpnszVissZPvFk2THDZIkbi8ChVtJ82TbVUR
 f+8lIunMW2H5nyiOV92L+v1zMTYVMAcHxNfMrCy1w+M69k7D3J3HBqYPj+ZsZ2/uZ7/k+z2TO
 I0Kgsn7qghRFAMu5r0TioO3N8mLa55q/geNVFcQ/CfO7t1orxNvsj5zhrEOFADEKKD8YSqL8m
 XmXl9uezCfwRV5YJM2yTGupLgrtbqGDTm7SWb5JW49FMzZzXZhKF7IFhTR5otlJRt56Q9r6r3
 1xYX0+3OqXBpmOInBzaYYpPhysrA1zQt379Wu4Nvmh3a+TEd1WCtLC9yoyFhpIH4vuQMyUmjy
 2zqeV+nAdkQNUUc5jgXijBfiiT4FFwdE1lX7vBnp34nZwXDhMYtsR6XmybbVRqlo76M2SDTlC
 aNICVXDaMyqGmrora9kd5NcAyigpP36T0t8/LfQTbpWuVyfGwLUxMgzMjGgVdOjmuumMbm3u+
 +k6vJwBEp4XAQ2A6NEP1PUes7wJNrGOE6LJGqPNxg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 22 Jan 2021, brian m. carlson wrote:

> On 2021-01-16 at 04:24:54, Seth House wrote:
> > On Sun, Jan 10, 2021 at 03:24:48AM -0800, Junio C Hamano wrote:
> > > Note that with t7800 fixed with the patch, non Windows jobs all seem
> > > to pass, but t7610 seems to have problem(s) on Windows.
> >
> > The autocrlf test is breaking because the sed that ships with some min=
gw
> > versions (and also some minsys and cygwin versions) will *automaticall=
y*
> > remove carriage returns:
> >
> > $ printf 'foo\r\nbar\r\n' | sed -e '/bar/d' | cat -A
> > foo$
> >
> > $ printf 'foo\r\nbar\r\n' | sed -b -e '/bar/d' | cat -A
> > foo^M$
> >
> > (Note: the -b flag above is just for comparison. We can't use it here.
> > It's not in POSIX and is not present in sed for busybox or OSX.)
>
> Can you report this as a bug?  This behavior isn't compliant with POSIX
> and it makes it really hard for folks to write portable code if these
> versions implement POSIX utilities in a nonstandard way.  As a
> non-Windows user, I have no hope of writing code that works on Windows
> if we can't rely on our standard utilities working properly.

I fear that the Windows-based tools do the correct thing, though: they are
meant to process _text_, and newlines are supposed to be
platform-dependent in text.

=46rom that perspective, it sounds to me as if we're trying to ask `sed` t=
o
do something it was not designed to do: binary editing.

Ciao,
Dscho
