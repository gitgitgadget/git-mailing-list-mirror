Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9194C1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 12:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753194AbeGCMwy (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 08:52:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:37605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753186AbeGCMwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 08:52:53 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvV1X-1gHXeN2zrf-010g50; Tue, 03
 Jul 2018 14:52:48 +0200
Date:   Tue, 3 Jul 2018 14:52:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org
Subject: ag/rebase-i-rewrite-todo, was Re: What's cooking in git.git (Jun
 2018, #07; Thu, 28)
In-Reply-To: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807031438240.75@tvgsbejvaqbjf.bet>
References: <xmqqd0wawpwy.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yfEiCKUN/bxM5UeHuJmut2bc0BlL8e9c8n8t7wbrx8UnOvsnURk
 NbDSKI7vh5T/pz96GCIsbD7eSiFzM9iQYV+xjFI5FMhtw/y5UstFoAZnxBj/VUBoTEpYKHG
 4cbm8hWAkOJuwCMgPRjznNNy8jgGgDxJ6afz1NCFVtCb2sDKjtkWJlIEMbnvEeXktxcwyhQ
 NKUljTmfJzEaSoLjWVZ+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xODxerCjGJ0=:/5uLHptfBsPp4McZRoXksT
 jobfrqsCZsJ9jd3H9vX7Pdmu05islziQ4F2drjuI8rlV/TXLEJd3I25LKH7btpBEGCIJrV6F0
 iDCV5txXaHBx8F42cm+fIHbW4xErkFiaUlPzbfdQjB+RcIJZdlHjvXoa43yLwEyIgVWlvh3pI
 3Fe+/0L2y+Y4LtIPAhk09gsk3jnj9ogEtlAccbOd5BFNRaL+Is5D/t6OlfMbknRZzEFelEaIa
 sgVLNLXSC1/IYHpLILwrAP6H8yeKYWraWTucbuXgc32lynNlxI7s/jIqw/3tnrj99I5i9Zd6M
 4NATN7NgOY4oikU9PGSdJUaBKvWa/7SBVsCpXRjHp9O1FUXzsDq/ZPrL4vmYxMllNMjZ7y/ke
 GHWlHeCx0okgHNcJCaFZ9zI7JPSZcR3cTOx8u086pFUHKfO7LKPSHAE5zQIXZz0w8BAfNxb03
 xBaxabylTt6JPNX1IYZATvrzlFRXiuz5eDJmJdoZMKbjOnl6FIb3Q8Fert393PvC6JzbPWp22
 tNQAr8wgw/UVrvBX9pIZ+tuN5Tpva2iVzMlOtvuGqXwF9t1vva2FV0hwa22m0LotMYO4Nwtvm
 u+ff0STLHvbtne4We1ESVeh8T3Jb6DXiffuUjZAaamPGoLPH95+AKbkjioDu79h+PCzdN+ctZ
 UzSJHfSAfHHU7sk4iu2TcoFt6DQeJxVnTY14Jxtw7KuhD4xmhmaNJT9P0Ky0vw7vJO5iTOnr7
 qA1lEQgzCcJmsUFtVF9GuitSd2XTIha71myS0w7gnce+YrmszUyLuhq3zCAoj87DGASE30xv1
 9XMyC6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jun 2018, Junio C Hamano wrote:

> * ag/rebase-i-rewrite-todo (2018-06-15) 3 commits
>  - rebase--interactive: rewrite the edit-todo functionality in C
>  - editor: add a function to launch the sequence editor
>  - Merge branch 'bc/t3430-fixup' into ag/rebase-i-rewrite-todo
>  (this branch uses ag/rebase-i-append-todo-help.)
> 
>  Stepwise rewriting of the machinery of "rebase -i" into C continues.

Alban abided by your wish and smooshed those patch series into one honking
big one, to grow even further with his ongoing work. I have to admit that
I am not enthusiastic about this, as it will make it even harder to
squeeze in the time for me to review those patches.

The latest iteration of this is here:
https://public-inbox.org/git/20180702105717.26386-5-alban.gruin@gmail.com/T/#r8eea71077745d6f2c839acb6200bb8b2bea579d3

I would *strongly* encourage you to allow Alban to go back to the small,
incremental patch series he sent before, because it will make it
*substantially* easier to not only review, but also develop, and for you
to merge.

In this case, for example, the two patches in
https://public-inbox.org/git/20180702105717.26386-4-alban.gruin@gmail.com/
and
https://public-inbox.org/git/20180702105717.26386-5-alban.gruin@gmail.com/
are ready to go into `next`, like, right now.

Yet because they are now embedded in a larger patch series, they will have
to be re-rolled over and over again until *all* of
`git-rebase--interactive.sh` is rewritten in C?  That's really wasteful of
reviewers' time.

Ciao,
Dscho
