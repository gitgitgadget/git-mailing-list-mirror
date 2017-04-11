Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC5D7209FA
	for <e@80x24.org>; Tue, 11 Apr 2017 14:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbdDKOzW (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 10:55:22 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753128AbdDKOzU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 10:55:20 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MW7C9-1cZw8s3nz7-00XH9u; Tue, 11 Apr 2017 16:55:11 +0200
Subject: Re: `git status` output is very misleading after a merge on a
 "detached HEAD"
To:     =?UTF-8?Q?Enis_Bayramo=c4=9flu?= <enis@picussecurity.com>,
        git@vger.kernel.org
References: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <88df8638-9b7b-42c4-bb34-4e1a49d4c22d@grubix.eu>
Date:   Tue, 11 Apr 2017 16:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMLReHYBVmuu5H015N1ShCD0iLNau9oLOabJhQ7xc=58rXQi+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GyWBTMCozs3sm81ndMXBuG1Aq75WEXc9gJfemdJcqO/0jtoGMnX
 kSv2qlUwiUQhEmJuptd7BYQ1O/yR7Ph/8JhpCwrdCie2w6SkraTtnvmF3eD00ZcsU3siEC+
 2fdmZGYy3NZSPkuAC8ziCG7rHGgcMO6CU+jgMOYABt3s1tqCQ0VAQ5g73pL2wH19/i/4HXJ
 vQ6B/t5zQK40peg38zltg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2kAd59SG8F0=:e+lZbfMarac8c840c3OTDm
 5C5Jx69MnFYimMkaxk+aYczM1vbsY6tixlPTrlZV0zUwAQ+WIDS7mW7ceP5HdxCPwHxI01nz9
 iTGMcbpYGnrOUrrvF4OUeoiG26Wanz9DYaUdPQusEpA9MAhY0J6CAPLuiis9IO/UlSeCv9cL+
 7DEY8XYJ9kaF4LVJ6M7UsF57MpkmBgEoQ4QY/tuRQ8kdFFaOxJPbpsVY3V/JDXeMJcuK33Gi4
 QEBqcATrpcWdAK6ETYUbLt1f7jXw/s8i1pZkAXxb4qDIZMAtGLcOUpPJMMiYzvjNLePR/ubs4
 Ve1Gtt8C2yEeJtA7HyV6xQMn8Plro/upbJ38jPXxjSw6emcVOP9hQ0Vzs2aEd9giLFD0RwY2h
 ZnBlw6lX0z0zr9/QHQBdifV4cth08DOwFTcf+lyBXM/yi5YC54Tx1g3Fo1AcjlgmLNr9gykwT
 Rcw1GIAafpB0b9YYhJOiPHu2PKBjPoNCCIaTmXYK80tiPWj0nWRM4mwDhtv3eEtYE9v2zGhpC
 bDJnKakEMpsewwwuESIoL4yOkiE5dsm6w6eXUu6LNTEuIH1I7zJMXXGdELXPZvZMTDVoF1T/9
 Av+DAb0IFEoiFetSzEjGrk+pS2Oowq9Q9eQ4FSO4mVP+iLeovCbqguCxzTxapujiqdQnGp1a7
 JCQDfiiaFYox/MH0mWOLmGOPEncPnLbWZVkpq/6n3DzDpCl1rkfTaoaZ3BNArp3C7pONz2g6V
 JR7zUUggTh46dXUf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enis Bayramoğlu venit, vidit, dixit 11.04.2017 10:57:
> I've encountered a very misleading output from `git status`. Here's a
> sequence of events that demonstrates the issue:
> 
> $ git --version
> git version 2.12.0
> 
> $ git checkout origin/master
> 
> $ git status
> HEAD detached from origin/master
> nothing to commit, working directory clean

Hmm. My Git would display "detached at" here as long as you are on the
commit that you detached from.

> $ git merge --ff f3515b749be861b57fc70c2341c1234eeb0d5b87
> 
> $ git status
> HEAD detached from origin/master
> nothing to commit, working directory clean
> 
> $ git rev-parse origin/master
> e1dc1baaadee0f1aef2d5c45d068306025d11f67
> 
> $ git rev-parse HEAD
> 786cb6dd09897e0950a2bdc971f0665a059efd33
> 
> I think it's extremely misleading that `git status` simply reports
> "HEAD detached from origin/master" while this simply happens to be a
> mildly relevant fact about some past state.
> 
> Thanks and regards
> 

Well, what do you suggest as an alternative?

Git tells you that you are in detached state and where you came from
(detached from).

Michael
