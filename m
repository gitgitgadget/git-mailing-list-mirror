Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1A6C211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 10:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfAKKm0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 05:42:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:52105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbfAKKm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 05:42:26 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lx8OH-1hJbYX1UhV-016gD7; Fri, 11
 Jan 2019 11:42:24 +0100
Date:   Fri, 11 Jan 2019 11:42:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Markus Wiederkehr <markus.wiederkehr@gmail.com>
cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: git rebase: retain original head?
In-Reply-To: <CA+h-Bnvp3mrXBqqY+mdD36feOkx1EhnnQtDXrmPhyW4KzKb_3w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901111138530.41@tvgsbejvaqbjf.bet>
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com> <87va2zavu1.fsf@igel.home> <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com> <CA+P7+xq++4W32JT9WcasXn=Oj9W-U1eteFgpLZn8GVqeO0foog@mail.gmail.com>
 <nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaqbjf.bet> <CA+h-Bnvp3mrXBqqY+mdD36feOkx1EhnnQtDXrmPhyW4KzKb_3w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dixTm7xYMl3jXwQHcA2VgUQ4XSkpnPYqvkCnRvl0i0YjiBXbeAB
 VwkWDEAUswMCTp8MgpyNcpd44X3I7AjXhuscnwuYL8Cwx/luZ8M+K2RuPx70meywy+G/FT7
 1YyWyB6M8Y5/2AHFHiTOvop0dei3Sf5yMOLUTXdpj/syD3zsjpyHBzb7yUXptRCpo3WCUhl
 86fxlwGqM++8/mZzwYFRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n4Rm04HlhBk=:uSem/SNTVfVCC9ErSEHgZy
 WEQTT8AANefeTj/ZLvL3w1U4bloBaXuIDy+0JXWff5RJ/xYsuWTEw0Yjev1PiSRD2gs9BaBdT
 iZuqRgFnz0v2RzFkwph1vVnr3kuICPCwehrB6JYhDzXwoqiyXaVuKJgRu45MxVJsXQ8vVDmpQ
 TpNooB41G5xEYcOjhUCvFVdx5Iz/b11iGzXzO5ILUqO1jjGTA/dx301X6wj53rIW69zPCIl7U
 46RZtEIaLvIkX8ApZ4VeWHFA3UcHLTp1KMT29TYpdTa9uGwsWFe0VuF4aNBWkyI0BKrYFARA1
 TE7WGutsLD2ydy/hwxbm91tbqILgFgqrq3udKjn2EmlvAnoqR0CdOsIt0w8cGUC6HNiSD0hGn
 eWfvfOIH2DE7djPAwMx3ZDu4vpSERnDEQp1/bFEV/VOQbq094wJKbAR5YdGXGMWC1AOx3yarO
 tHS49lhZS6vDbs5pisn3uUJITZMpDm+Qzjp9HlDYpfB0sjZJjEfSc8ETzl4YXMnPMscOsV4fq
 T/ektYdQ20Mg0A//xS0Tiz45ozrYBQLNNakLmtnyOyyTaQoeh4a+iQ3vG8UwKxhjSK6Tw0D/e
 1U1YUrF7GiPJ5i+mN7d40z4pyRrjS8GHug4iGlCcDNwQmD3VRjy/amsnKNxjcDqSkdRDqqcYA
 6rV9waTRyMOBftHuDVZmjKpKie/BOZRLoMcvSHEJOjL1CJvKt0rC4wa5v8PHAsNqlBK2yML8y
 Uk9P7QJKbhwK0ey099BhaKmQ/4top2PcKDPwYH9wlAi46S3vgAAkgPXznO5sx0Vxkgq1yCMk1
 5UqP883y90iG+Ytxh34ZaNtEhSZeRIKjjpFJIeneO5rUpGxIQ/01KVG0PRQ90YqCJQnQM9LJS
 FpfpuvQT90ZEhQSDEjJs9O8VNYxH3xOFsOST9uJfUW+DiMPwvB7ePlvLN1Fw2UGniBMH+yPL5
 NVF21sYWciw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Markus,

On Wed, 9 Jan 2019, Markus Wiederkehr wrote:

> On Wed, Jan 9, 2019 at 3:05 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > Having said that, it is an unintended regression in the built-in rebase.
> > Markus, could you come up with a minimal test case, preferably in the form
> > of a patch to t/t3415-rebase-autosquash.sh?
> 
> I don't think I'm familiar enough with the test code to be able to
> provide a good patch but the following code should illustrate the
> regression.

I think that you think you're too unfamiliar with the test code only
because you have not had a look.

> git init testrepo
> cd testrepo
> echo 1 > file && git add file && git commit -m "initial"

test_commit initial

> echo 1 >> file && git commit -am "commit 1"

test_commit 1 initial.t

> # rev_commit_1=$(git rev-parse HEAD)
> echo 1 >> file && git commit -am "fixup! $(git rev-parse --short HEAD)"

test_commit "fixup! 1" initial.t

> echo 1 >> file && git commit -am "commit 3"

test_commit 3 initial.t

> rev_orig_head=$(git rev-parse HEAD)
> GIT_EDITOR=: git rebase --autosquash -i HEAD~3
> test $(git rev-parse ORIG_HEAD) = $rev_orig_head

test_cmp_rev $rev_orig_head ORIG_HEAD

I leave it to you to make the actual patch.

Ciao,
Johannes

> 
> In older versions of git this test succeeded, i.e. ORIG_HEAD pointed
> to the previous original head, $rev_orig_head. In git version 2.20.1
> ORIG_HEAD now points to the commit that got fixuped instead,
> $rev_commit_1.
> 
> In previous versions ORIG_HEAD only pointed somewhere else if "git
> reset" was invoked manually during the rebase operation. I'm not sure
> if this is desirable, maybe ORIG_HEAD should always point to the
> previous head after rebase completes, no matter what operations were
> run in between. What do you think?
> 
> Markus
> 
