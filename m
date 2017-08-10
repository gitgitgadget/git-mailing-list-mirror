Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3DB20899
	for <e@80x24.org>; Thu, 10 Aug 2017 09:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdHJJiQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 05:38:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:61806 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751732AbdHJJiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 05:38:16 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmK3e-1d7ENb0Ckk-00ZuXY; Thu, 10
 Aug 2017 11:38:14 +0200
Date:   Thu, 10 Aug 2017 11:38:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Stefan Beller <sbeller@google.com>
cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
In-Reply-To: <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1708101137190.11175@virtualbox>
References: <20170808012554.186051-1-bmwill@google.com> <alpine.DEB.2.21.1.1708081404200.4271@virtualbox> <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com> <20170808182324.GB73298@google.com> <alpine.DEB.2.21.1.1708100032050.11175@virtualbox>
 <CAGZ79kb6Ljk8brLN1bbOnBLfm=Q=aCnkZ=ZBtDPzf7MZionmSw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x0PjN6Jcp+yXtgtnYA8a8vZeJlVA5YyTmPtSpYjV/dCGD3dwD1S
 XOqiZHeAR9OvOrne9I+TJagLYdfpPRhXrU/Kfs7a/bfhjyJl1DcGP0GhOKz1DN1nbL7W/IC
 aZYLIToYSTTH8K/bt93ZWtlX2vQMFdyRkwZwdqMQzMHAioEWM9mmGzWC0Ne1sncy/NKs3cU
 5L2rBL8VfBE2vF9nykUtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pLYaF98aong=:+Qdnswtfman4CIAtTtSPjE
 aomrKOTmyj6uUZM7iMB7HeRb1/TZXvcJKBOJu0AbCFZCNUOI4IK9RWMyJBmKfrlAQfj4I6NmR
 1GEuLf/zAcJz20gJ2M22MswhOgWnsjZFkBxDDq1gYZFeeHUVxzBtF5z3LduZjS/LyKdDbHizH
 GD/sQizSBXzqb2ef3Za8FR3Fu2o8Np3HQE/AA4/HJUPakQZBNkLCoTbqDNHBdoCZ+VucsnU62
 4IqBebYOkXxUwR6TRTUPgmVawFCQacKKz2l+YqOFkrzjnZTwJBYzJlGJaHYk6qiRFXOq6kmT9
 AVwlXVMORN1Oeix2M6wckQtFHiHvquQ8SYPJvyV+dEs+5fvDPAMInUernzB0nPFzuywX3Q4pO
 KcpdzY76tLF0Z1sb9TZ0tviHTrG+3xAti9u8AbOWADMJeUA5k4sHmQ1HMnhEnrgby0o9y3Ggq
 LzJHm9t0b1Z0qboHkWKWPgaR/z5McKly7eSkaZMnZf2MgJFZZfjAzDEy3gXgG7+GF5f2ZQDBT
 vRtYRlgOmERL71q+XLf2L6gqSX76+64CUXvptWzZ0P+HAx/BCnfB1T3CvqUu2MOAzESiL35X1
 FLOPDxuZMqHcseT7qpT6C9XzlDMDUDLJr8qg7FUhmjzOvKX7hwuwvjsevEdG4FcWT4WdnLkH7
 VlfK7V1fMQ14MY5MOgXhaqiJ97u2REEP5LoaEGhKF6VEfep9lhXctMd0mx3B4ocHs91OehhGv
 yoUP+kmfKi5rIdEoshAv6o9elWBpIJTtHSh1VHo+qGTprrY6eruWKODI0vEiVAZxVULMWjDQm
 +qy9EplEk8SrU9WeyI4wvutinocU09Vz4f/RIw1ixgLLnGNUHI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 9 Aug 2017, Stefan Beller wrote:

> > I am sure that something even better will be possible: a Continuous
> > "Integration" that fixes the coding style automatically by using
> > `filter-branch` (avoiding the merge conflicts that would arise if
> > `rebase -i` was used).
> 
> I do not quite follow. Is that to be used by Junio while integrating
> branches?

I was more thinking about a bot on GitHub. "Code cleanup as a service".

Ciao,
Dscho
