Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15E1C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 08:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD76A20656
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 08:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HlObJKoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgHKIDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:03:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:59625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgHKIDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 04:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597132983;
        bh=+39undwzNXHjGEXr35zyNKzeJzwKXCuEfOMMxuLbVCY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HlObJKocN8TEm8N1xfn9pasTu8O52mnWuj8I6MX9/Gj2U7S/Nxt5MGvdaRxHq8OJp
         R/vBI+i09X2gV4epDX+tk98L3QN/3/0cOlA5AD9erwzDTEv+4KfikQ6hA11bqjl2Tt
         7eW0+7aiNUrj5jMmqFG7e1H57dn6cxdE//hBAwX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.90.36] ([89.1.212.145]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1kdueI0M9N-00hP56; Tue, 11
 Aug 2020 10:03:03 +0200
Date:   Tue, 11 Aug 2020 04:39:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
In-Reply-To: <xmqqo8nicxn2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008110430080.50@tvgsbejvaqbjf.bet>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com> <xmqqime69jfc.fsf@gitster.c.googlers.com> <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com> <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net> <xmqqv9i6814y.fsf@gitster.c.googlers.com> <xmqqlfj27x7q.fsf@gitster.c.googlers.com> <xmqq5za596uo.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2008101349570.50@tvgsbejvaqbjf.bet>
 <xmqqo8nicxn2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ANvH4ryFxURVebr9NvMma0f3RSyO9mqfhWesV7BDt2krUM/sCvQ
 IBnLAL01J7MEr210vQmobV9MrhcO/sum1APLGjlbfmADn9alPaqfbeLy3ODeb7DJZhhSYZs
 sAGCOSMrOXa7d+U10QYPDiGDN3GR0CMOl+pZdwgU5MFPdGvqQNZJ8Z8edtOewVxA2LqBI6t
 xEmbBiK1LjwtGThxAl1TA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x6Qx2LZm5DU=:g8HWW2u9lEmfAFYN+BZl6P
 6VkUY7RyeuMVkIPSFlcLj6Crfw/528PzgVqI3hFZG1KXu7p0+urEcfwOVfMLQzQ69SrkVTV7n
 wbDasYaKS0pWhwUz5pYTICxLcfMc/4c3JezKESAHeWqXu/XkpW2BhZ4hdKdGxiu43Bewj9Edl
 km255JpS9RIOPrO8uSGk889V/temBG2ci61H8KJMsklEMX1Cyd/+qIqN7hLn8S/NSHrhg0PI7
 dh3/BaFGs6v+YaGAAlS2Dwqy274eFRbVwICGTz6tkJfoEBLnnEeEG+wFsCiOr3WvjhlWCj7RM
 cnZ81PfJlnimguO4E1Cb7gA6MmpzfZxNKmXC4p6OX/CWAxarccKk9Ab7fmEhiXQcUFUcO1xgO
 7FRqSnjP5YqLkMbZHgLZqFQqlSXP4SPilkDgsCG7ECrmESo2ZM0AZxIXrTyYUoJzxVerTzpsQ
 kSalsrCN+pLpgCF54XxX9fsMpYffnNTr0EMybuHBvp6yyhvtrVrZh/tvH1zrQ79Bdf8gXuP4/
 hg6+GxtzLKB29hvn0b8M/5gOMc9lMm6rGl9zYr4Oow2dtz0dMYAhTBP/FrMzqJNl/FJifE6Nw
 nbTx8GloGyH/lUpAUP4zpkUPlYw3k2GL5DwRbB5xiDVUvDr7oTrjEmu79fvjlStzMlmUnfzFL
 V49PeHvTEUpfqHPIH1hjBNgPFHYuEY+o3jkDh3uXCU/k68FPfEm8CyJGAO4FH7El9Tz96+Qtm
 p7kNK22S1tNM9OAcV1iaX5vx6M0Mzpnr6if54yV6+mS/yUAb1y7nxWu2YR7DeokS6333kGhkn
 CKiFE0TTsdZ6o1cgn2+bVK2PhdlF4SSKqGg8v2Wt1ZsNQjUVWVsBoZgqDJYrZYHbUDIPgyyMw
 +/NSZJ0u9kc6LB+H/weTMlWKklHkymkoxuGwPittsyfRL4b4KFMTIFBz8hcM2k44s6clZMfBS
 7wWfxp/5DtIpOcBBSMGtR6KDsBIhJS6WxoGKysr09ovOy1mm9gzsHtADHllKnPPeg6OX9wf0C
 9e8lGDt63/0XEcf5IyF2F78pT9o7UJuBI5KG8gofmq+ryMHSX/PRrJjl5oBJEaPvzrxCxT5ki
 FR3Jb7ZO4WoqPEN9vXHryVZZw51biUWb1S+Xr2L8Ct6Yk1TVeq1WKy0m8p7/PFajzncu4ilrj
 kbq4DoRPaW5+EzIVjrgNZvR58f48lU0om/i3RkD4R+7xPv6xEWwgWyRa3Lz7lM6eWPAeo9T4l
 mVRUzb7TZ/zeid6+qazdumQ204XpgPxaQbhpqcQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 10 Aug 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > TBH I expected some discussion along the line "Shouldn't this be an
> > opt-in, with the initial default saying 'every branch except
> > `master`'?", but that seems not to have taken place.
>
> I do not quite get it.  Without any explicit configuration, every branch
> except 'master' is shown, just like we've done for the past 15 years.
> You can opt into hiding other names instead of 'master', hiding nothing,
> or hiding everything.

Sorry for being unclear.

What I meant was: instead of a list of negative patterns, it might be more
desirable to have a positive list of patterns, with the option to exclude
some, much in the way `.gitignore` allows us to do. Something like this:

	[merge]
		mentionDestinationBranch =3D *
		mentionDestinationBranch =3D !master

i.e. a list that specifies which branch names we _do_ want to mention in
the merge commit's message, with possible exceptions.

However, this might be overkill, and a bit more complicated to implement,
as we now would also have to allow "negative" patterns. The most likely
avenue to this would be to use the `exclude_list` machinery, which would
be doubly confusing because we no longer would _exclude_ but _include_ a
set of branch names.

I am not sure that it makes sense to pursue this direction, but I wanted
to at least mention it lest we bump into limitations later that cannot be
fixed, by design.

What do you think?

Ciao,
Dscho
