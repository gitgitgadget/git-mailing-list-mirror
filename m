Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66C8C1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 22:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKSWJ2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 17:09:28 -0500
Received: from mout.gmx.net ([212.227.15.18]:57455 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfKSWJ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 17:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574201365;
        bh=tG+s8ss7sHsaZJ4HwqqCCRFLjk7hfu/Co7dtuR9YTzM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ie6AAUuU/rPfgFdh9dQeyssDGA0awbinQJrtNCOLtUkMGa+Npc+Wm+8cUV4eQPyeF
         VlWV2KiVe0bLUFO4wLRPtpH8+VTsFGSF85/U58kQtQx7Bjr2nTfhnjHwOPNKZXEUOT
         IN5hDlQfbcQyvd83wY9MZjKr5TTOLaGgsmSZ92DU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1hhYXR3Aqa-00uFvL; Tue, 19
 Nov 2019 23:09:25 +0100
Date:   Tue, 19 Nov 2019 23:09:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Harish Karumuthil <harish2704@gmail.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Making GitGitGadget's list -> PR comment mirroring bidirectional,
 was Re: [PATCH] Feature: custom guitool commands can now have custom keyboard
 shortcuts
In-Reply-To: <20191006210647.wfjr7lhw5fxs4bin@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1911192305410.15956@tvgsbejvaqbjf.bet>
References: <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com> <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com> <20191003214422.d4nocrxadxt47smg@yadavpratyush.com> <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com> <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com> <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com> <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet> <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910062208460.46@tvgsbejvaqbjf.bet> <20191006210647.wfjr7lhw5fxs4bin@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DllsnwA4w7Y2FSbR7bKTk85zRP1npMfXC2NSSzZmmghha1VXaIt
 p5l1qmtLHzCpwhhY2RzCaaMpmZDcsvzB43wgnO2REUbsUZzAleb6M5j2sYe9K/9G1ZnOPUG
 GOrhF6isC+RpvH32Q1UvQFqePLAAlrNUeFLG1DjoOsADJG2tVOj3mhlNTpc5bdh++7tmBkZ
 T9cDXHRwx1wd+AAEBr+ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V/ZVu6vFL1w=:15rp/KIImDbSaSHoQCGi9n
 jMadWbIJrtNwXJ9VKukdkwiUQKTfXUtonlkBw9wtP2Hi7pUY7DJt6yrRwkOwmOWIAuDUv5O0r
 O8Ck8BZ/yq3ZQp7ZdKLVn3VXZms88k4ZWP44SRMghNRlz4WyelPtM4BCJpRT1gZxnLAhTSzp9
 2P7k7Ku5fl0aJTQFeN1dM+ADPB5Hk1EZoYOFeWIVFfcQIKhZs87yGhF89H1cEltzZ/Wu9vkU1
 79vJIVv5hMnzvazAcGP7Ns/dAUIU7yGCSgLaCoOq3L0oYuEHPoqGtvEQ/htKsd47yUCOB8Fqg
 zADNsGg51Q2Xwwy90DxwqBGVVRFPEKyGgMoy8t35ZisoWFeFtRXEXXs/4IY2ZLj7Nls7Ef0/M
 V/2t8Td84/SfjQBlirmk26RWEDT9gl6Nti5zv4Gm5Vo8j2TBa26eQv1SL6c8U/gGwSrcoxri9
 E/uANr8cu7y26DGk9qZ+OqhLsA0ujCLFCIdRxzIWYruor4TS/U51sttPYdflb2N3INbphMxRO
 QWHxCEl4S0WcDIV8NXzKFficEFUwyT9mPaXOwPFWE2+J0q6OvS/Of2Xkkm9Ecdg14TICJ9Df2
 X0Z5G1mQGTwnbU8gvh/76e+EcNOfQ0i+FrQftzxb8PzBnBnAsbGeRCVz70VdubxloIONzIGQG
 V4wU7iNu+iW0IsGN6unNcOman9llpFVtl8ZO2LmrtiKFjXwRoFcDuH1pFVyrcYwnwGWaSrcE6
 LXF64YV6zGmXO0bcZQO2lOZtV7/P7BHLSXqt+1RoZnmQSCCxXkYi9aBD7xvQvwY/dvrDLA+4W
 jfDePaXuqFttEygx5SDxhYkcmMKuxTEz9dv39CTsKIJHcmXA6K/4UDgTczqL0nEvc2fBWS1Cf
 LO7fAc/DELJwdIQdYdwahqhd1esJNp1PNaXp8uTLWuRDg490+bEovEu85A6KcB2yP3jclZwJ5
 i1rABdX1+FkWmvaxtJzwonREWiW79Stie4lVf/Wrf04qRM7xz6UXCferFpEv5U948XaZjRFM7
 Tu62BhkQP9MrPtaIo8wGx/jfdC9PpR9GsUyCtFkLRibiFRJ3xvplvDQmd53n+zJCGhjhp6xyG
 5txqKdww57TPaedwcdyIk0cOv+Gezb+y3amFuTM2n814MD05t+kJZeCXHQ1/r1s8ounj3/O5l
 8aP44nIdc7NxzvWj9qgefFmKMYApOzIn7ajBwSdEqSQxfG8wRaFCWDzep8dRYOs8WR5B7Lpai
 kAqpxru9jW16OsoTLbNQLrQL0ICy2RPg2Y52VK6mPazrgvQm56ndiJuc+MS0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Mon, 7 Oct 2019, Pratyush Yadav wrote:

> On 06/10/19 10:27PM, Johannes Schindelin wrote:
> > Hi Pratyush,
> >
> > On Mon, 7 Oct 2019, Pratyush Yadav wrote:
> >
> > > Anyway, GitGitGadget solves a large part of the problem. It
> > > eliminates the need for using git-send-email, and it even shows you
> > > the replies received on the list. I honestly think it is a great
> > > tool, and it gives people a very good alternative to using
> > > git-send-email.
> >
> > GitGitGadget is just a workaround. Not even complete. Can't be
> > complete, really. Because problems. It has much of the same problems
> > of `git send-email`: it's a one-way conversation. Code is not
> > discussed in the right context (which would be a worktree with the
> > correct commit checked out). The transfer is lossy (email is designed
> > for human-readable messages, not for transferring machine-readable
> > serialized objects). Matching original commits and/or branches to the
> > ones on the other side is tedious. Any interaction requires switching
> > between many tools. Etc
> >
> > > One feature that would make it complete would be the ability to
> > > reply to review comments.
> >
> > And how would that work, exactly? How to determine *which* email to
> > respond to? *Which* person to reply to? *What* to quote?
>
> GGG already shows replies to the patches as a comment. On GitHub you can
> "Quote reply" a comment, which quotes the entire comment just like your
> MUA would. The option can be found by clicking the 3 dots on the top
> right of a comment.
>
> Then you can write your reply there, and the last line would be
> '/reply', which would make GGG send that email as a reply. You would
> need to strip the first line from the reply because GGG starts the reply
> with something like:
>
>   > [On the Git mailing list](https://public-inbox.org/git/xmqq7e5l9zb1.=
fsf@gitster-ct.c.googlers.com), Junio C Hamano wrote ([reply to this](http=
s://github.com/gitgitgadget/gitgitgadget/wiki/ReplyToThis)):
>
> GGG also adds 3 backticks before and after the reply content, so those
> would need to be removed too.
>
> Does this sound like a sane solution?

Here are two real life examples where an unsuspecting GitGitGadget user
expected GitGitGadget to mirror replies _to_ the Git mailing list:

https://github.com/gitgitgadget/git/pull/451#issuecomment-555044068 and
https://github.com/gitgitgadget/git/pull/451#issuecomment-555077933

Neither of them include the line with the link.

Just to throw a bit of real life into the discussion...

Ciao,
Dscho
