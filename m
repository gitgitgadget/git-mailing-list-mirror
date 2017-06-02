Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9157D2027C
	for <e@80x24.org>; Fri,  2 Jun 2017 12:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdFBMr5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 08:47:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:61095 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbdFBMrz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 08:47:55 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M54L0-1e73Z13vnq-00zBp2; Fri, 02
 Jun 2017 14:47:46 +0200
Date:   Fri, 2 Jun 2017 14:47:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests for
 console output
In-Reply-To: <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1706021442190.171564@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox> <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DceGKAWVAejGTfp0CLMLu9V+O7ETlpC6LZZvBJ+X+Zy6eqbn0yL
 cO9KSCJWj50ON0RlLRaWtzR+Imyv74NJqKREJBze/EnHNzkSPTiVXk5vXHif18hijD0Bxjt
 ycng339rIxN2HTChqdzAE+e1BsRoF5LutbYwSqqa6rYngWjOXcs5GV9GCOrgzIlEXgarsHM
 pcMu+61v8s49kVT1HWdNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6GwtvSwoK2s=:o5ZczHnmMDmTTqNcSrJk/S
 dQRf28nJ1PQfjaxPHKbtZe4KWYB/xCE0IIIsq9c4cWRybPmfPi4SXwCsp2lJDS4DeoTsu1Os0
 VxMjLPyJMKM0Ft78ql7bwjYWi68ZhpQOdBa/qIYRge4aTpEKujhMpGmD3pITttLF6PRr5eE9r
 DbI9nxfONmtLyhXi+jp4Qcl54NSgNPr/43Ru4Z+hLEOoLAFDp7OatnmqGxhHYakIWVpmmnIJx
 wZQu4dnjSaDWPvhToqe2koFcvPdz02HmJKTXKLCFgXXrIhr2CF99vxLfpeYytssJOM+xiO9CJ
 N9M/ufwezFUCifgwxP3ix8LlYeSzF+I386h8Dm4l4fGQMrif9I2dn/Yg4ih7eRLM7x/4MfGE3
 7MhIZx6wHQ+qY47kBYlKin0BM7+gd6lAwzNzYSF33Vf7JcfPkTEoIOgkf3e4QV75EGgcb9UOZ
 AW/A58ohLeugissGe3JmrblwVE3PiZLVXbQBm7cz1hImHBBTBIDo0UwiXT8MX7cypbJkOXEwz
 8oEPr8II2i6oWeu8/2bKEqIGLenBhPfeDV1D2POkjVYb4B6SqyEztGEJ/fWS1Qnz0X+3CFopc
 URi0OZwdBYk8SrcVzh1cJD4sWigChKPVeL7zvDiWhYnIN0SsH40QCAZiUXc1hJuNrr01kWbf/
 0004KMe9izZjYNf1pETtLRucIoMRnHlk4A8BOsfLCxo+iwG1bTh+NstDf46UQ7Q2NPD9n5krV
 7dKUQu5EYDgZPvFYmW+SHf7QqgiIEHmVknPiNZW15CINiy2pidvY5QnXzTLcc/ja/zJcjKxMD
 XPRHZj5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 1 Jun 2017, Stefan Beller wrote:

> On Thu, Jun 1, 2017 at 4:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >> Also, about the commit IDs. As long as the tests are consistent (i.e. they
> >> use test_commit rather than plain `git commit`, or at least call
> >> `test_tick` beforehand), the commit IDs should actually be identical
> >> between runs and not depend on the time of day or the date.
> >>
> >> The only exception to that rule is when some previous test cases call
> >> `test_commit` but are guarded behind some prereq and may not be executed
> >> at all. In that case, the precise commit IDs depend on the particular set
> >> of active prereqs.
> >
> > Good observation.  The tests written such a way may make later
> > introduction of new hash function troublesome, though (we already
> > have tons of them, and it is already a hassle just imagining that we
> > will have to migrate them X-<).
> >
> > And what you gave below is an excellent suggestion to even solve
> > that future headaches.
> 
> We had a discussion off list how much of the test suite is in bad shape,
> and "$ git grep ^index" points out a lot of places as well.

Maybe we should call out a specific month (or even a longer period) during
which we try to push toward that new hash function, and focus more on
those tasks (and on critical bug fixes, if any) than anything else.

I also wonder how we can attract (back) cryptographic talent to help us
avoid repeating mistakes when picking a new hash algorithm.

So far, the only undisputable expert opinion I read was from the Keccak
team, and I did not have the impression that their opinion had any impact
on the discussion. Needless to say: I think it should. Cryptography is
hard. We proved it ;-)

Ciao,
Dscho
