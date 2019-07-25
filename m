Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3FE1F462
	for <e@80x24.org>; Thu, 25 Jul 2019 19:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfGYTPS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 15:15:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:46789 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfGYTPS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 15:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564082111;
        bh=rE36m94p8A8YPaSEaTNNjfU2W2vdw5n2PaKjp7C12nk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CoSkDvBVvyVb3OsAulL3YWnHz1Q2rWCPOIlsxaQpIwKKJY3UQyoEELKwoUBqoBFuR
         Ob48bGJzF8Ry+UUBkFWWWxylq6YJkCzWpm9DUtAU1cn3H/yg1if0rjxk9/c28ApX6Z
         GQNPj7nzS6S6i+yXsLVzm0t4xgKyyKn0EPaLgb20=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1hiRSv0zXm-009Mhn; Thu, 25
 Jul 2019 21:15:11 +0200
Date:   Thu, 25 Jul 2019 21:15:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/19] Cleanup merge API
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet>
References: <20190725174611.14802-1-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OhDump6OX1vYaOh8komzyqfsJ3t2zD0IXubitZuvsRgMmApaeC6
 7AQcG88VVMPfwBaXZypW0JLvrjytc7z7WFWPk3blethz7iKad+5PSeS6g5jPgZFBplNFPWN
 VtJe5WHxEGRN7K/FgzB+ZMbWkkl98uKawjTVvNyq8IprZKnzow2ziY04rfdwJXNkfkB0fCc
 Y9RcN3cprL5yLnxK3AK3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jOiKWOEn8g4=:IJlt3o7OmOumAob03ASrkp
 LWisnVjSq6Ijczt+CYa7uNy1C/ynvDMPI4IGImUASsavEo7xBBLSbPKJr7MrAGY+at1oKdJg3
 lpBNazekj84mR/HaQphpGOhvV2QV+E0sDMcLLerpQ0j3mA9oVf/2BL2vPfAoBTzd4+KwbD8UF
 zcouNV7nOKh+pqT9UVyoEC4itozBU3q6z9Av5t0N1FVj/fVyh+riTH9FJrUUMARBFCzf4YAWH
 mm41aL06WlZRQjKK/Bj+40yykrA9oyWhmbViHecaO2Cbv6UMymMNK5i5ldC0J4oRsUBOEM1cg
 JqtMh2+pBPbdC/69kT31j84z3frK2ZLglaC3u1MOUqHJyPajmiBRqVdDwhMFoqO/Jf/54Uo7u
 FZw3mOGtPKm1ZXoa+uNT2XKx72Jv+tpeS+tJNg8/DhxXNNpFLpibQckSNlrfOVZt+gjt8HmeK
 QTfmQ2hO3KTNmYOtOulGSReEzndPA8lNomS+Cr7KcNc8TdcwM3pVTWSYsF8JTzi02S3IPlNcJ
 wQwIRyS1Z8xCUSHZwMihw4dxm5huGLoBuFnK2ZHVH+vWrmnO7XcyoPvp2jMqM5BPk/IKcz3Ru
 WOJmJV+mSw57kkZdsHoWdAbzHHRA3ztm0MXKeAVnoec6DGl9+Mmvkcl4oIf3Tm8XvhJz69gPv
 /d9OLK5gObOMpc+UA69ygQ/2Vv0c/oshteoE747+JssCTCCba/kEaUfaOQLJ0DQKx+5Z2HWJV
 DNDECmyZpg3AheBwNA/GV3OnZGgSP09t3abL6Nfq5R14zrKKRW8+Bhuyq9rwxgBnHXhuE691p
 bM2MAoUMxMATMMLMFZ4OTHJYQlBFWzPFvt9YJ6nhGXjfXE/1sMt4ix4FIzhgxK/V4z8JRMGQd
 yPWglyBQvZleyKSW45QuaxH6WHiMgRxBweedfwv2MwoGHXkyTJdLM0AqU0blQsRRqF94k+jNw
 V2eIe71C7C2+5C9IXPLiLXZypltvaWYpf12D+W71NkvRKXOfvq37NstNWC3H54XT7a3qUNSmO
 Kx7TVrmGYdRaj8h4ZVcHejiB5B+E7SsDak1KtSsEg1jRO9o6ED4USJNwbZn1cLiUuenqXBH6g
 45T8R1scD2kVUg59IPigF/A5+ZBlWN+mO5z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 25 Jul 2019, Elijah Newren wrote:

>   * All current callers (3 of them?) of merge_recursive() always pass
>     it a specially created reversed-list for the merge_bases.  Some
>     history spelunking provides no details on any of these about why;
>     it appears that the 2nd and 3rd callers reversed the list because
>     the first did, and I'm guessing the first did in an attempt to
>     exactly match the git-merge-recursive.py scripts' behavior.

That is part of the reason.

After I worked on converting that Python script with Alex Riesen, I
tested it on all merge commits I could find at that point in linux.git,
to compare the outcomes between scripted and non-scripted versions. IIRC
I even reported those findings back to the mailing list.

*clickety-click*

Ah, I did the extensive test on git.git first [*1*]:
https://public-inbox.org/git/Pine.LNX.4.63.0608092232000.13885@wbgn013.biozentrum.uni-wuerzburg.de/

As you can see, it seemed that the reverse order of merge bases (trying
to merge the oldest two merge bases first, then merging with the
3rd-oldest, etc) avoided more merge conflicts than the original order.

>     But if the API needs them in a reverse order from what people
>     would normally expect to pass them in, shouldn't it reverse them
>     itself instead of making all callers do it?

I would not, as the order the merge bases are passed in defines the
order in which they are handled.

>     Also, the order shouldn't matter when there are no conflicts, and
>     when there are conflicts it'd only change which side of the
>     conflict markers the made-up virtual merge base would list things
>     in.

That's what I thought, right up until I re-created those merge commits.

I really forgot most of the details, but I seem to remember that there
was a puzzling one where the reverse order caused no merge conflicts,
and the original order caused a double merge conflict.

>     However, we do have tests with recursive virtual merge bases
>     and which test the output, and I didn't want to try to clean those
>     all up.  Besides, the current order shows nicely when commits are
>     named things like "L1", "L2", "R1", "R2" -- it's nice having a
>     well defined left and right side.  Wasn't sure what to do yet, so
>     I just punted for now; this series is already long enough...

Good. I think you would have entered an unpleasant space if you had run
down that rabbit hole ;-)

Ciao,
Dscho

Footnote *1*: I did remember correctly, though, that I re-created all
merge commits of then-current linux.git:
https://public-inbox.org/git/Pine.LNX.4.63.0608131550290.10541@wbgn013.biozentrum.uni-wuerzburg.de/
