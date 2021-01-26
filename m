Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB3DC433DB
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43E722EBD
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 14:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392786AbhAZOeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:34:50 -0500
Received: from mout.gmx.net ([212.227.17.20]:36475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392762AbhAZOeb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 09:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611671534;
        bh=BTwr3EGUE83oXTqMVah0T9ewCW+duB5iEd80z2NBX0Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VxDJp066iFv8nlCtUmqPAzB9chrK/VjEm9Aos49JpsV9kIufkqeCQ2BaOe7Zo0CO5
         8SrLgie/deLcferwRBS58mGJr2TSdYGeX8SReJi4QwpbxJuVjxWarbNE/tpIoJCWrF
         uZuJx8OOqWUtacREI7+KJoE7dv6ZXWbgW/Vu0Vyw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.88.23] ([89.1.213.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTmY-1lS6My10dC-00WTM3; Tue, 26
 Jan 2021 15:32:14 +0100
Date:   Tue, 26 Jan 2021 15:32:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Seth House <seth@eseth.com>, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: Re* [PATCH v2] fixup! mergetool: add automerge configuration
In-Reply-To: <YAte7ixZYdz1AOMX@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2101261522200.57@tvgsbejvaqbjf.bet>
References: <X/onP6vFAHH8SUBo@camp.crustytoothpaste.net> <20210109224236.50363-1-davvid@gmail.com> <20210109225400.GA156779@ellen> <xmqqmtxhd1zx.fsf@gitster.c.googlers.com> <xmqqa6thcn1n.fsf_-_@gitster.c.googlers.com> <20210110072902.GA247325@ellen>
 <xmqqh7np9gqn.fsf@gitster.c.googlers.com> <20210116042454.GA4913@ellen> <YAo9aTkZBCSGLYTT@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2101221728410.52@tvgsbejvaqbjf.bet> <YAte7ixZYdz1AOMX@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0W9wM8/wmEgzX6Kq+sb93pB9f9ZMzKxZL91iIgZSAfoS6duQIYr
 rtPZD4J56rdxleJFBtNrhdYLMGc5bj+DiPejg8RQjLKTFcTHlPL6Ug9Op9EwfGkXBY11E2Z
 95T4/djV4puwkGS0fTB96RUZkdxYwhT4KV3U5ZIqvsvB4jSv9NSZupqcS0uqSOY/tPB3Bjg
 w4RJQ3aeDq86LegjaHtkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YCmbqOK48Ao=:mCnaQJVWDoVdhSya0cvzaA
 28PRUQ1MBCYqTCS6B153qfvZkdxyBZ9lfKs8pCcM74ZO7REfF7LeW0iKWYkNzf1xqKL2qabZL
 /HBSJAOQWEvVSoe56eyOyJ16sntNUdQDnAkLswQngnJtrrwYZ9Je2UgCQR6BjvOs/2vv+jPFo
 aPEMLfQ2H5hSg80h5M218pqEJRutG+HtwhjsxYyk3IyyNRhr44vaJEUVs+TLXJXc8x6IhkFfE
 a1SCotMj5+GdgU0Iod5i7LVfnBWythqc4FzjVGZ9s12LUquX69Q5I9oss75orVzesrVZirdlI
 Nh5E0vcSHbVS6qOtGlQ1PL+V0JcaJiqgCwiCjF6AWWgxoAYfSxK4lZlSqB5oQ2+4kRAhCVxW8
 6gqthoM7afGqwAo7xkcLGcvZlWt54A8tiJwV+Ru7lUBMuM9gOb9UrcOPXGecfeOaOce8oVZI6
 smKfVxO8hN+RVhuaWAbrOiY7gGC4pdsSbtmwjYsAuGuSe9S39vX9DEPOrlTQ4ocZHLnE5zl4R
 +XyD4b8uHNprylYv69guBwUuqyX/ssKjFrRjEDVVH+IWloI+LBrQd5bqkBsSh4oHMnUs5lkg2
 S4NpWguclvClDwyLegY8yzgYLrVB0R08QqD5xHXQpchAm5SdPaU3HZ3RzDnvxnweaHFCNijMX
 D/kP2fXIXhppiAI3yYxbUfUHTjWqOOXk6BnHXdbRiRYnDlK3e3WGl/AnGELIP+otT+jWKab+v
 UUpcLLuxKsMhVTyub4oprTKDQyly+V2we1+8913XcAJKaJz/E0SNSI2zzMQlYJNpPlHn8wHRh
 NtM4S7Q5cUF4r7hw76K3xGw7T5bS8le+w3Jhdeojh/1s/IJ5y1YxcJM8YruGIGT/kNVPHl4IT
 MUxJLUtBh48Yp77sID+YkbNtBIrugtYDHUJ5K+xVg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Fri, 22 Jan 2021, brian m. carlson wrote:

> On 2021-01-22 at 16:29:46, Johannes Schindelin wrote:
> >
> > On Fri, 22 Jan 2021, brian m. carlson wrote:
> >
> > > On 2021-01-16 at 04:24:54, Seth House wrote:
> > > > The autocrlf test is breaking because the sed that ships with some=
 mingw
> > > > versions (and also some minsys and cygwin versions) will *automati=
cally*
> > > > remove carriage returns:
> > > >
> > > > $ printf 'foo\r\nbar\r\n' | sed -e '/bar/d' | cat -A
> > > > foo$
> > > >
> > > > $ printf 'foo\r\nbar\r\n' | sed -b -e '/bar/d' | cat -A
> > > > foo^M$
> > > >
> > > > (Note: the -b flag above is just for comparison. We can't use it h=
ere.
> > > > It's not in POSIX and is not present in sed for busybox or OSX.)
> > >
> > > Can you report this as a bug?  This behavior isn't compliant with PO=
SIX
> > > and it makes it really hard for folks to write portable code if thes=
e
> > > versions implement POSIX utilities in a nonstandard way.  As a
> > > non-Windows user, I have no hope of writing code that works on Windo=
ws
> > > if we can't rely on our standard utilities working properly.
> >
> > I fear that the Windows-based tools do the correct thing, though: they=
 are
> > meant to process _text_, and newlines are supposed to be
> > platform-dependent in text.
>
> Ah, but POSIX gives a very specific meaning to "newline", and it refers
> to a single byte.  If you want tools that process CRLF line endings like
> that, then that should be opt-in as either different tools or additional
> options, not the default behavior of a POSIX tool.  This behavior is not
> conforming to POSIX and it is therefore a defect.

If we needed another reminder that

	we never say "It's in POSIX; we'll happily ignore your needs
	should your system not conform to it."

(https://github.com/git/git/blob/v2.30.0/Documentation/CodingGuidelines),
then we have it right here ;-)

> > From that perspective, it sounds to me as if we're trying to ask `sed`=
 to
> > do something it was not designed to do: binary editing.
>
> Most Windows tools are perfectly capable of handling LF line endings.
> Even the famously incapable Notepad can now handle LF without CR.  With
> the advent of WSL, handling LF line endings is now pretty much required.

I have two comments on that:

1. We could spend a splendid time questioning MSYS2's (and before that,
   MSys') choices regarding newlines, but I think we can spend that time a
   lot better.

2. Newer software _seems_ to handle LF line endings just fine. And the
   `sed` invocation you mentioned above does so: it groks input delimited
   by Line Feed as newline characters. That does not mean that its output
   is LF-only by default. I seem to remember that recent Visual Studio
   versions did something similar: happily read an LF-only `.xml` file,
   but then write out a modified version using CR/LF.

Would I wish that Windows used LF-only instead of CR/LF, just like macOS
switched away from CR-only to LF-only after MacOS 9? Sure I do. It would
remove quite a few obstacles in my daily work. Can I do anything about it?
No.

So I'd rather see `git mergetool` be turned into a portable C program, or
alternatively using a built-in helper that _is_ written in C, to perform
that desired text munging instead of losing the battle to the challenge of
cross-platform, advanced text processing in pure shell script.

Ciao,
Dscho
