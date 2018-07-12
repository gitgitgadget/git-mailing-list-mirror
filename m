Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9801F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 12:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeGLNEZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:04:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:45143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbeGLNEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:04:25 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MF5C3-1fsDB70MWZ-00GLTI; Thu, 12
 Jul 2018 14:54:54 +0200
Date:   Thu, 12 Jul 2018 14:54:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase -r: support octopus merges
In-Reply-To: <CAGZ79kaYpw9t3kCvPnDiLc5z7cLFsVQv4XJDAff_T-bShEjPoQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807121450100.75@tvgsbejvaqbjf.bet>
References: <pull.8.git.gitgitgadget@gmail.com> <xmqqbmbd3cc3.fsf@gitster-ct.c.googlers.com> <CAGZ79kaYpw9t3kCvPnDiLc5z7cLFsVQv4XJDAff_T-bShEjPoQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CxOm7sd6H+abjb/n37IR6AUlSHtwAb3x6flzj1JT6P2BvKnG+8j
 pONbxs6vlcMFwQXxYb3gVF6F/XmUsg0AP0nSAlHZgAAX5u6wolM6JdaR3k1lNGRF6UqSF/K
 1ydGZdelRPH4MEjsgmNvypjkRnbnpAY8h5GxcTjffGUFts7M7oKJDUAKmrExX8QMEuecxDQ
 ncvNhJM/NGBPG39rzhs9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XojfEr4nFFA=:/yd394fCpeSrqZpCGR6knL
 F3XSPHam/IVJ8hVw2flH+zZQ32ciB028iUMEWTaYPj8xWpbVF66oi1EjXbG8TAmTHTH1J2lf2
 4syxu/bI+oWG6eA9IPaSaVV0p53nR1nTbkea6eLb0/rytRbkgJ+yxlLr+MU2Rwcga2j5AQw6g
 kQm7xkyM6KkkLHB8wU3PFe81w0cG0iiPvkFQ1m3MW6CyvwhklmQqx4lqr1wZ89sDATH28ogAl
 vG+CX43a/QcyRVlwvCiO/wSsRSd1tIYTCqU2EuFXoJQuwDrK5AwhL6rC955NbpMe8dHp0jXi8
 Q7+s/5chJwX5+mWDYVJLqn1Zkgy8tXoYhnyAVJNLYH7fVe3d82uB9BgcRMTwOhhao1wsClU6v
 4nk+tXWZ1+3sMsIqMCBnOT7CNleDDj3BcsA+tyfXK+e5cjsPQrhKXrQWK6XK3UvfEhpd/bdUL
 434ktw8o7C941Z9YFkS0yI0GcXGhwpObe1SvDTWdonFGebWunzK46xQyE8X7mwlOi4rNcHOg9
 d8VLeqfEcDrdCeEKhZakc240Z4CSlWKwQl3EPZ+zNMYX79zc6IzNDZ2HZp+MlsDdR6rzi+hSV
 s9zWtVkajEv7wRjYPmoBfjGlicKPyiYT0IoWodzSU+IP7raoQXciBZPM9lCKhRvTzp6/KvkNv
 mPtwlhQISSDr34/KXrqp7JsWVLyhZnWwWOQUvAfcOXIt8nKn3HF+6QxR89kgbz5VSIPxRQsBH
 21w7GgT//Ot/vB89ByE4OAhTuateWWkRymLCAO5i1G1nl2LxKf1Qlp1FPDX5ooDEhjJwZsXWZ
 n9bPY4C
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 11 Jul 2018, Stefan Beller wrote:

> On Wed, Jul 11, 2018 at 10:35 AM Junio C Hamano <gitster@pobox.com> wrote:
> > To be honest, I am not sure if there still are people who use
> > octopus
> 
> The latest merge with more than 2 parents in linux.git is df958569dbaa
> (Merge branches 'acpi-tables' and 'acpica', 2018-07-05), although
> looking through the log of octopusses I get the impression that mostly
> Rafael J. Wysocki <rafael.j.wysocki@intel.com> is really keen on these.
> :-)

IMO core Git contributors seriously need to forget about using the Linux
kernel repository as the gold standard when looking how Git is used.

Git is used in *so many* different scenarios, and both in terms of
commits/day as well as overall repository size *and* development speed,
Linux is not even in the "smack down the middle" category. Compared to
what is being done with Git on a daily basis, the Linux kernel repository
(and project structure) is relatively small.

A much more meaningful measure would be: how many octopus merge commits
have been pushed to GitHub in the past two weeks. I don't think I have the
technical means to answer that question, though.

In any case, the Git project is run in such a way that even having a
feature used even by just single user whose name happens to be Andrew
Morton declares that feature off-limits for deprecation.

When applying this context to `--rebase-merges` and Octopus merges, even a
single user would be sufficient for us to support that feature. And I am
sure that there are more than just a dozen users of this feature.

Ciao,
Dscho
