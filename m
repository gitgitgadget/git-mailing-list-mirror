Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D593C1B0D9
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2945233EA
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgLIOtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:49:07 -0500
Received: from mout.gmx.net ([212.227.17.22]:38825 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733205AbgLIOso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607525228;
        bh=c5spJx2Rn1Hy7WCSXVt9P/KSNks28wdWI8ZaqeGNUIU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bE60wnMFbfD+IuNWnpcELpefc0U3j7s+IgJwvgW47CuTb9si7iRrDwmxoRpqUdETs
         uQlRXy06LhUmJzEL5rkDfdVHKyW/mfAWxkW/PuYsvsIeNr0EeHO682vh5OJJJBZVLW
         oGMaqtuwghfVEypFWo/wW2I6Ms9JiAGFU7cVhwaM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1kSt230aNr-00NyMC; Wed, 09
 Dec 2020 15:47:08 +0100
Date:   Wed, 9 Dec 2020 15:47:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012091513540.25979@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>        <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>        <xmqq8sarljfn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet> <xmqq8saqjx2n.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LdXOyhZjo4aSZzoW8ShAb8r6fZB5PDBGtjXf+0z37pnYwICSodx
 uQSSbJJ2h6ywjNOHT+jyo0F1KMmCbOiN/j5567tVmiKITK82FsUCogUFXoNOMVIYfyNZIFG
 qI0yF1E2GS/FYw0R+dMVybF/ieFCDBkLQBPEFmi5OIsp5X4taNW3OqSqChyL/7lV/SURDcC
 t9JPNUTkvfJcqxJVCMf7Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uoo/owuuw9M=:25fztCg+uHl5d9n9ytK/10
 Ycnbn+9Fc2rG9n4nG3AJrDSmZ0pwjfZJfcPN0XEVn/vRyHVEb4G1YcPCshz9fFtFoKjTlrmxD
 d5OSnN+9+Fvcs+ywS6jxW5oDYR+sK0Z8xI5JMdqJtTZNGH3APeDe4IZWPLN3ognuml/Q0qw00
 gyXpKowPVAEuezHKshC+5e9GNuzuXwji0PkoXdzyK/9xQtdsxJDU0+7sXuRxg10rI5OPnX4XH
 w8WWrg6otQxqDfB9gBPqzkIj5qOd2gwvP4DlQS5HAtuPyCVgUoQogcpNp8KuzoWxpKjffB8Tu
 QSNYuDMo6FrXTkqP48BWdrLX7oASJQJqUiCfLys60HFzRFDngvZdeJJ8W8aFFrf91cFVOHMSm
 ZgsKYz9kHx/6dxhZKIxJN4cuLqa1OzZcQi5GVCpmGh0f/KZzo0ZwunoKQ6/rMHitCXF8PbbDq
 wDe9fTCl7hXpifDh8A6g/MeyCRvMXP56/IiZ5sac8dSUJLNqyaU0wBNJmlKURb7yV9av2xtGZ
 9LAkxo0ZntAbkeBxWsYBax0VmHJKgqGGzMiBSX9n1W9icBg3kugitavQfxmSMiWUa2iQn1Ksk
 zBEFE3MJhCTl6t2wL5UNu2s1iDptYM69InunOQLo99W1ifA9MVGT5X4NHlpsWDGoO7OYTpXel
 FLYXfl61b1lwcfMOgwaadPUB6j0JPYKWJwULR+bVCoRt88Y/V+ZJX/r49A6He2HR1EqTlGkOS
 Xsfw/z7jilwyjo8iiWIRM7PGl7jHFPhofY6nzHrKvdxh9tt8S9VYVmiKKZARwrwnRLUEY3qmB
 M1u1cARZ9cUtN7Z2jHQNlYlQNDNpw16NOFZysbMO4NW7Pmua0O8zoK03akBv11fczuVRwRqVB
 M1QjZsM+14Zc4oQFkqjxCJjNfn2g9b9Z4JZrAsIZDSuOS7g9AwlI3Mi6iwnAQUVPdGT7oSx5A
 Y62cmGTS/EQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Nov 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >>     To configure the initial branch name to use in all of your new
> >>     repositories and squelch this message, run:
> >>
> >> may be better---it makes it clear that the offered two choices are
> >> (1) do nothing and see this message every time, or (2) commit to a
> >> name and not see this message again.
> >
> > Well, I think I finally understand what you are saying: there is a
> > legitimate need for a way to go with Git's preference but still suppre=
ss
> > that message.
>
> I am not saying it is a legitimate need.  I just wanted to make it
> clear that we deliberately chose not to grant that wish in the
> message.  An advice flag in this context means that the users can
> choose to let their distro and sysadm to flip the default silently,
> which is much worse than having to see the message every time they
> start a new repository with "git init".

The distribution already can add patches, so this objection is a red
herring. The sysadm can pick a different value for `init.defaultBranch`
and dictate to the user silently what initial branch name to use, so that
is also a red herring.

I still think that there is a legitimate need for this config option to
turn the advice off, without having to override Git's default branch name.

In particular in this context, I would think that most users will want to
just go with whatever is Git's default.

Ciao,
Dscho
