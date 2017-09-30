Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4322047F
	for <e@80x24.org>; Sat, 30 Sep 2017 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdI3PME (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Sep 2017 11:12:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:59627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbdI3PMB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Sep 2017 11:12:01 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbdE3-1dUjIW0FQZ-00lCLk; Sat, 30
 Sep 2017 17:11:55 +0200
Date:   Sat, 30 Sep 2017 17:11:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>, git@vger.kernel.org
Subject: Re: [idea] File history tracking hints
In-Reply-To: <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
Message-ID: <alpine.DEB.2.21.1.1709301706170.40514@virtualbox>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com> <E8C827ED458648F78F263F2F2712493B@PhilipOakley> <alpine.DEB.2.21.1.1709131322470.4132@virtualbox> <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley> <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
 <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rq7D8zzskp4El4jr/9vewiHolin3HiQPhDtMkTHjNYOWpImZ8fa
 oGU/822VZ5u45pB93lUZ0+Kk0SE2Q14xpV8/U83zrBq9wv4S+BnPFNul0a2t3YMs2W6CNSS
 +HSQ+OeGvHR8hwRQihn2Hp1eVVRhGZbiyYGeboTu7gvUbmSGysZQ/jtsuG86FYEi4QNQ+X5
 hBWqTYqixTl/Lt1KWziIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kqlz+TRnodk=:Bx/DGSqGWEwJ5mLNZX01rE
 /scg4yqScjl1IJoEpzyLdSkftE+gEvCXM+Ifpi0lz7VrIVBOTnE9uYoCqFN19bl8VyuQzwP/a
 b49VFy8zlFyUUBUssFVcGqRu9A5Ti3GAedwLSP3lSbclVlPK88pF9YgAoadZGM6Mw9TIzjSED
 /SvOlz92x6SD1ToWKS4eoNwcVt5JRqCkepV+kLWPOuwUH+B19RABy0XIxnrO60wFIhONkoxwz
 daAz7AvPqQ/g/JNY7FgMVtb8ChhKCNzlK6OlwX976SrWE28MaA5nca6ZvBEeeG9ZrcjrBj1Qa
 IHcSI74El3OqJwezzgS27lwdPkcvdraMhz6RTRpSDEpeemplqoRdwBapJ5lsOgu9SY+Fg68VU
 pqbHfqlBSjjEjPwHZNi99Se+YtrwBf0ReDVxZHMZ9YdZOF2heFIVP9aA1Ht8gUpPzYDhcj5Pj
 dYuU8K8aM+zUBdOdVm0tYWiARdckNviOdpL4RDGWws7c07n21seOnHH17tYRQiRPsugfdK5YA
 IFALs/FCga8hIaq1jfB/JI6G2/rwGxUwZwtk3vezQ8jY3EehqQuJyCYrqQnq4516yxxBRM5Ih
 Ae6z3p9tq6OZ1dCJVjlNmRUsEfaJzCZQbNaycLQUoWTh/cxfiQh8yyxdJdbygT8xwaNA8Clxx
 6gmQtyNRplcw2VE8615vT872BMW3kL+//WEGQuaizmPGJYKxNc8aBPR19G/q4IRl8EmNm/fWE
 hNBFMTryKnJXHDqNyWzk/KWRaJ6kt9V9FCPjz12Y6OpJFsYHARm+4nxXqyid2m8xh68rSxHM/
 0omOB+VokUyuWGpglSmfoVsuFOrOmiQHOpJmHiqdBEZ3gdyonc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Sat, 30 Sep 2017, Jeff Hostetler wrote:

> On 9/29/2017 7:12 PM, Johannes Schindelin wrote:
>
> > Therefore, it would be good to have a way to tell Git about renames
> > explicitly so that it does not even need to use its heuristics.
> 
> Agreed.
> 
> It would be nice if every file (and tree) had a permanent GUID
> associated with it.  Then the filename/pathname becomes a property
> of the GUIDs.  Then you can exactly know about moves/renames with
> minimal effort (and no guessing).  But I suppose that ship has sailed...

Yes, that ship has sailed.

But we still could teach Git to understand certain "hints" (that would be
really more like "cluebats").

So while we cannot have any GUIDs that are persistent across renames/moves
(and which users would probably get wrong all the time by using
third-party tools that are not Git-rename aware), we have unique
identifiers: the object names.

And we could easily have a lookup table of pairs of object names, telling
Git that they were source and target of a rename. When Git would try to
figure out whether anything was renamed, it would first look at that
lookup table and save itself a lot of work (and opportunity to fail) and
short-cut the rename detection.

Ciao,
Johannes
