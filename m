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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4381F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 14:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389921AbfJYOw1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 10:52:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:40057 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbfJYOw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 10:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572015140;
        bh=dPayqmbYXb+j+VKKZ7BMMitzEC1e2ColsRPpeykEaSg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=eLnBm6J6fEFJkIGJimkgiE8ngT7uxkpxLWOEoaAZkHI56lXE6c4+EtBbVm/rN6p0Y
         CoOP2s4BPFMAhy8u4ky7IyI+GubT6YqD+3k5Gejz7lm2NvyQUknxlMW/oGTG5l+ACR
         5ytrb9OIi2p2euxIXPK10/9aBKPwyFKonJYP8iRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1i6Lfp0dsH-00rDrb; Fri, 25
 Oct 2019 16:52:20 +0200
Date:   Fri, 25 Oct 2019 16:52:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/builtin-add-i, was Re: What's cooking in git.git (Oct 2019, #06;
 Thu, 24)
In-Reply-To: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910251647340.46@tvgsbejvaqbjf.bet>
References: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VOk2sHObj0NemvWDGUmy0yAKiAUi0YyBeFg8lUWGDwinCvBlKhf
 gLpwpNUOk7UKwQCHwz6kfqP/g8EgCSQxk53cmFH5TF0F0/otBsFRDXyYYTHtDlvIZacxJPt
 UD8pU1UrObfSZ1SVHRRqV2r6RVEIPV9jNNhww1253ghFDLMTvQp56LAe2aoo/c43zs4QXw4
 X0KvIuLMT5Hs0xDbyhyJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qEyUs7P8leI=:TplchHX6s8JDDUv7woWgf2
 0MCrW44fePjZrE0OShKC5cbGDakbABN2OiUdBCmcXj0VW4UrCuZBpPs7zRsMyCCPBeLvWmY8h
 j7ULD0204Uaj6F5+Z/TSJKJq3BmkpktBE/I0/XuLmZYuch61CT6pc0RMPpTdLPrJ0kpQbsMso
 XmRpWjuoquoc9wjSSdSC7wh/mOA/vQw+KicjVG9urr1CUj7nHvZPrwW/arrgUSFxOBh/0U89B
 5vcQGYcih3SQrZ0LtJlFtnzRcXgPJ0sv4JuakiCqg+9y6S9Yx98v3wNg7UAOyNXmAsUIDaJLa
 8UoRY9IWUcRucY/6ZN+XSS/tnT21HREOfWyEr0XPUHbn+z87li32FxI2iDEm5/fFOzoaLWqQC
 2AIeriuNOMRl+yUK6pqo/MQp5a9/Hiw3H9rFK5xBjN3BqYpzqZC9BGOe7fgJSk9konFX0kvc1
 z2P1FRXzJeLeR/BBPKAjFNBBUi+6jvig8y2SA0+UUshCFF0Q46Yw6/7PIBYu+YE+U+dltMUlJ
 X9eXx1NGQjUi9MYTpnU7XGFDiu84W5yiBEt+huEmSP87UfShYCKyEivHIlzGcfKITbl1Degnf
 fMfQYS4f6bE6Y0/MC+ZJjHkvz6Vtmc3F62xS2Tb7JL6hYSu3s1DyFqyJM3hLL0eiF6W9+jes/
 uXNXgCkMxc/+pdQE8NoMFMfkFGTW84I/tT6JJ/9hUGEcBso0laYNKPLBxK6a7D57SvwUs+UHu
 R/Y6LwfcYEfEQxkc3N6/yOTFIHdQnwtdu00YmyA5bu7Bfqj+Dm31YLwOVISVLiDBtYHcWaXcj
 bBdJI8EwtuPgSdLMdKLQ8d82Z14TkYdgZg3UUucGKc407UXMYOH+I/o+JjOAEcU66lrTiap0G
 Odsfe3//tpYNhjwGMjVjfoaHU8CoPnYmiXRT+pHWi5nPxORZ+tizxIhrdAtSQzd371Ks4Z3pO
 //OeAYm7FGawRp5wCB4oXaI2uKTkv3VDKpJKX9Eg2znHLHthi7a5bTXijrNppd+geePZbiwwd
 cYXSgIf82O4OJcdSGc4nc7GjJk65uQpEYjmb3e9NmIKAfwCavYKIuPlcBvHJWiG/RnaQzB2EO
 2gI3MFSM+xvzDJqEHA//dyWz4Y6ucOYSN7fe4UjCVEEDJKu/0EgtlsRtVpIFcBNAnTQHHDQs1
 WK0PrY6DsTJFDbqwGlPK1XvkH5LKBTX4Rk1Z9ZuYk6Lw8XZU/FyDR1rR5Kut9eNrlARWNy1OC
 3MawsG+BGHyDWUkeB3EqR2C5I6FPVtvIDbaEpny5YgshFTdDeNoTWJeZnGyk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 24 Oct 2019, Junio C Hamano wrote:

> * js/builtin-add-i (2019-08-30) 11 commits
>  . built-in add -i: implement the `help` command
>  . built-in add -i: use color in the main loop
>  . built-in add -i: support `?` (prompt help)
>  . built-in add -i: show unique prefixes of the commands
>  . Add a function to determine unique prefixes for a list of strings
>  . built-in add -i: implement the main loop
>  . built-in add -i: color the header in the `status` command
>  . built-in add -i: refresh the index before running `status`
>  . built-in add -i: implement the `status` command
>  . diff: export diffstat interface
>  . Start to implement a built-in version of `git add --interactive`
>
>  The beginning of rewriting "git add -i" in C.
>
>  Expecting a reroll on top of a base with the tg/stash-refresh-index
>  topic that defines an updated repo_refresh_and_write_index() helper.
>  cf. <20190911175201.GA11444@cat>

FWIW I am holding off from sending this in order not to distract from
the -rc (feature freeze) phase.

I will update https://github.com/gitgitgadget/git/pull/170 in the next
minutes, for interested parties, though, with the plan to send this out
the _second_ v2.24.0 is out ;-)

Ciao,
Dscho
