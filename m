Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D685C32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD969217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 21:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jcQY0CHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgATVfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:35:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:53941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgATVfb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 16:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579556126;
        bh=JawFyOgNl8Zk/UxC6LUb4GEJ0qZWwGc2sap3CxDhZIY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jcQY0CHCqWI+p07OVJY2RXhK+uw/Ml+rdMiSusemlrf5BQocxox02FpwIxHxZD4+a
         0RSiHunIF06Bksg4zYTLmTMZ4GiR39K3O+fHEJx2MMVaLH4A/M/prT+A/5Yrw4zImq
         bDEZ9Y48hxjodQyhz31Ss9uY/3TUJloknARrS804=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ygO-1iwNzM1Xhm-00658J; Mon, 20
 Jan 2020 22:35:26 +0100
Date:   Mon, 20 Jan 2020 22:35:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Nirmal Khedkar <nirmalhk7@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Facing error in git-imap-send while compiling Git
In-Reply-To: <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet>
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com> <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com> <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet>
 <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:0Dc24PQ6BXqKnYJFlCVe9153CJ1OuY0N32Kz6fri1UgEl92ca9E
 5hLkWl082gIhB2Jilum3DY1Ij/xlJE65gXT5l+3lYOuimF7975wjmcxieaA90A+Vau14HOi
 q+zUhccl+a1St87CynsHHYM9WRMNeCskHaEmHPai9cPeoAre8w0Iq9wnwbsJph3hHpu0lkr
 kno+99X9L1ElML9Y+zc6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBr1o3mtAos=:vn2ljhjNtEWAoGGYjNhF4l
 ZV6uCv4F1Vpyn4YHUcV5dr3DVtODNIw5uUTQU6vdPdxtEqKdrHH4sMmWcRiiePfhGM8DsjITR
 MOwzzJYJ1+SYVN1HrnoX2WOno7r58jS5C+PwYumA1i0JX3uJx32fTOq7YAXsV/P7qZbaohaY7
 7bOhRB3daHNQeGh5i+yr9AV1+c7sMjuFZtqEBQO7jYiJCv0foCm46c1J1y62+blzccHq1EjK8
 6SULxITuGxHwPnq4tRl3eFYAecJHdx5pxb6uMX7Klt+gv253KlJpRMEQ2pkYFN0Vpxy1yIQBu
 K9OBfrKBT/niueL8Rr1xumvMQlzoRJPxTNypCF2WpRKgSEpsS4FUqUAwnb8hJeVDB7L3L25H2
 e9Gbf8E3sOPu+O9Hk9sVs+QBwCCEruUixLDtYGrTQqFWITNiwr/vmhB9GcGQjtwcELtWzR12l
 +EqRnGcbGW3lXvh72GFMlgKOzlM+2ECSurJGm1HUycM6mi3eTjuK/1cHB2qdz48Uk6ee8tq/N
 wzwiLhAeq8eJmmWVI6N8CqFOGZqRA9gVYZz3uGx+xNxKZginCOwnrVaGmGT5t8i6I6bqNqCJq
 z5uJL4pZYzaDL3oosp2xpuF3UxT5kOTIql+mhFT3XLVVi1/9zVXTNBjr0VZ8QVPF2lvuJ0Bbb
 hJ82Sntk+4mQ3W/CSmpsnfpgER0yvHm0oPFGyEIt18+gTA/KUAlycQvomaxLugAaQB+bYO+io
 2t0ZHXywdHDIrJsWeUwMb8N/8ClIPgBfrnC9turjGDF1gJe62BXEfUKxuxWju6gWPP+Abos2v
 7jy9xHdgcCdnCq8i2JkacnVRi56asbUe4Rl0MnZtOyUdmYzb+JyI+HzzQzXiORDlQAODkVw7I
 NTEOYXHMnbdG7VsavJ4njwC9gDaXfpIfUoyjGgOB2Ip3MJzDzRZeP+Xz3Wqh2P1u1xXYT5Z5m
 R79b4pfrkWT8h7Zdcgml3Ag1GheqGNREUBeiaBqNwa+p9xQ8nMYrAa56kXrxW0+SvtkyGxhaN
 LH5im0UFLFo6G6uYrKRfGpW0fVNjWliWEaQLpb+zdMvb4+fzkyFFAz7tNrdwLm1/hqrqiMsSG
 /Ofn+dyd4NHSsG7TwSt4sVFpoEfH/KZn+s4WptwnwPWQEAjznmgD0G0XasJxvmNKycizRIrqW
 e/Oa+dwKVe8jFisFQ0ipuvGjEAtzaFXnLQ3mQ9Z0J3p3D/Su/gWlt+9CZXxYMswjBTsY5Bb9z
 ya5s0p0ZZopjLAMCOnZBJMcf+zhV2ty/lNseuFtW3FTZ5sUIL5CMb9mvVd/A=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 21 Jan 2020, Nirmal Khedkar wrote:

> On Fri, Jan 17, 2020 at 7:05 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 17 Jan 2020, Nirmal Khedkar wrote:
> >
> > > On Fri, Jan 17, 2020 at 4:21 AM Junio C Hamano <gitster@pobox.com> w=
rote:
> > > >
> > > > Nirmal Khedkar <nirmalhk7@gmail.com> writes:
> > > >
> > > > > Hey!
> > > > > I've been facing this error everytime I run the Makefile:
> > > > > -----
> > > > > LINK git-imap-send
> > > > > imap-send.o: In function `verify_hostname':
> > > > > /git/imap-send.c:252: undefined reference to `sk_num'
> > > >
> > > > Perhaps the thread
> > > >
> > > >   https://lore.kernel.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.google=
rs.com
> > > >
> > > > may help?
> > >
> > > It did, to the extent that I now know why I'm facing these errors ou=
t
> > > of the blue.
> > >
> > > I'm  not quite sure as to what am I supposed to do right now, should=
 I
> > > wait for Liam's patch to be merged,  or should I implement his fixes
> > > locally or should I just downgrade my openssl?
> > >
> > > Liam's PR (#516 on GitGitGadget [1]) haven't yet passed all build
> > > checks and I guess its still a work in progress. Nevertheless I've
> > > tried implementing his fixes to imap-send.c, and the make still fail=
s.
> > > Am I missing something here?
> >
> > Speaking for myself, I am still waiting for
> > https://public-inbox.org/git/xmqqpnfv3tq4.fsf@gitster-ct.c.googlers.co=
m/
> > to be addressed adequately. I think this is the main blocker.
> >
> > You could be that person who addresses this, as already 10 days went p=
ast
> > without even so much as an acknowledgement of Junio's suggestion. Mayb=
e
> > you can make it work, and submit a fixed patch (You could take authors=
hip
> > and add a footer "Original-patch-by: Liam Huang <liamhuang0205@gmail.c=
om>"
> > because it is most likely a total rewrite of Liam's patch).
> >
> > Ciao,
> > Johannes
>
> The OpenSSL version on my system is 1.1.1. I've tried implementing
> Junio's suggestions, and it just doesn't work.

Does the code otherwise compile cleanly with `make DEVELOPER=3D1`?

> It gives me the same
> error as it gave me earlier. Here's the error:
> -----
> LINK git-imap-send
> imap-send.o: In function `verify_hostname':
> /git/imap-send.c:252: undefined reference to `sk_num'
> /git/imap-send.c:254: undefined reference to `sk_value'
> /git/imap-send.c:260: undefined reference to `sk_pop_free'
> /git/imap-send.c:260: undefined reference to `sk_pop_free'
> imap-send.o: In function `ssl_socket_connect':
> /git/imap-send.c:287: undefined reference to `SSL_library_init'
> /git/imap-send.c:288: undefined reference to `SSL_load_error_strings'
> /git/imap-send.c:290: undefined reference to `SSLv23_method'
> collect2: error: ld returned 1 exit status
>
> Makefile:2454: recipe for target 'git-imap-send' failed
> make: *** [git-imap-send] Error 1
> -----

Those are linker errors, meaning that the symbols were not found in the
libraries.

If you build with `make V=3D1 DEVELOPER=3D1` you should see that
`git-imap-send` links in OpenSSL via -lssl (and/or -lcrypto). Is this the
case for you?

Ciao,
Johannes

>
> From my limited understanding of OpenSSL API's, I reckon all these
> errors might be because of the errors around 'SSL_library_init' and
> 'SSL_load_error_strings'. Both these functions are called before
> 'verify_hostname' is ever called.
>
> StackOverflow suggested ([1]) to add tags during compilation, but I
> dont think that'd work here.
> What should I do? Would love it if you could guide me out.
>
>
> Thanks!
> Regards,
> Nirmal Khedkar
> https://nirmalhk7.github.io
>
> [1] https://stackoverflow.com/questions/5593284/undefined-reference-to-s=
sl-library-init-and-ssl-load-error-strings
>
