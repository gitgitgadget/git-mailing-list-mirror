Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 511A9207D6
	for <e@80x24.org>; Wed,  3 May 2017 11:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdECLWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 07:22:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:53949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751766AbdECLWS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 07:22:18 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M9KR0-1dE5223fAs-00ChRK; Wed, 03
 May 2017 13:22:04 +0200
Date:   Wed, 3 May 2017 13:22:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate
 command-names
In-Reply-To: <1493769381.29673.39.camel@gmail.com>
Message-ID: <alpine.DEB.2.20.1705031315460.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com>  <alpine.DEB.2.20.1705021741580.3480@virtualbox> <1493769381.29673.39.camel@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5U1OdrTx9wyzjDs3mheyvIPePE4aUhm9BRPC6BuGkW3nXl8rFlu
 OujAwUbzqyCHytm5HUHk8nV6+wNGRQ1WKyLNXRy2W7XVAVH7rmOcdq22GI3YBUWie8rtJS+
 d9p3fzulhQ80VEUzwdu1EYvu4tH6Qyefwepb8xLNA/zM18YZjduTnnO2OMel/StNDQjym27
 rFtEaEAWYbRgKkgGJGFSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MJ4rnhv0miU=:ZJ/q+wddaGeFKoMKxdwKCi
 SlSxj2xFK1nP1YZZf/oce/CeWvFn8rRfcPWakeGMM4DrDG8cDK5/3vnTf8Ll05ukPDLZF6s4+
 uXIhRMeNDMlZt8OVUbKFKpqGafuggF3zg5aIVf6BYHyPv4mWfMvrOzVOVTAXqMS8jLD26lyGQ
 ewqyRWbnwbh5bOrnYzN5fETZLKrM+50W+HQ5kuf9DqgC1b0bEc1iDEsi3NvqzEJwE2KWGqVvu
 N/OK+MvBvqUk0sCQKkUiHGuZslkZxQHErkGkae6HCCSzVcaXquTxfcJ81dDSmYvqAcrGubKFP
 W/5aOv8xEHVPB4zJ9GzRh1ACh0rGKCc2IA4QYyDkxuSdqV/uSgFwZEZcpsV/Lvj6O+a+rVDVn
 vAz82cS7bA3mir6gXr8+SIB0F2ZBJRa2ooDekKBh8CIVBETSG8zJ1EoeeYdY+khD9vyLb7KSo
 JnMtIj8r0gwayAW5ysYPrzuwS12KljR43PgpUM2SqbNn3jeXgWzuTASckZej+ab4g3hQVvvVQ
 tMu9/grZ8FIq4GkUxnoy/WzWE9VMu8lxu66QXRqxhYXt2o/vRQQoxW3ldSZIj2NEwGPOkk2vX
 EnbHZ4zlv4wNp18H8jCbYO0bc2bCvx8CRtTFUoX3HSYDsj5EcMg9dF35atHDKjc6Rie32TCV0
 DYh0hx9R7wVaNDi17U+Lfd55tyzTIliuozfZYYuZ6oc/IA4GIaHx6WUnDEKd25MmCYGY9XGg0
 c2lkisNztaGKAfRnxiUbsYA1GhJUghbO6LpP9VYDPIcqRk+9itCPATvPFNcBRWd7IO46X6dk5
 Okru/5W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 2 May 2017, Liam Beguin wrote:

> On Tue, 2017-05-02 at 17:48 +0200, Johannes Schindelin wrote:
> 
> > I offered a couple of comments, my biggest one probably being that
> > this patch series is crossing paths with my patch series that tries to
> > move more functionality out of the git-rebase--interactive.sh script
> > into the git-rebase--helper that is written in C, closely followed by
> > my suggestion to fold at least part of the functionality into the
> > SHA-1 collapsing/expanding.
> 
> I've seen a few messages about this migration, but I'm not yet sure I
> understand the difference between the shell and the C implementations.
> Is the C version going to replace 'git-rebase--interactive.sh'?

The C version has already started to replace the shell script, yes. In
adding and using git-rebase--helper, there are already parts of the
interactive rebase functionality that are run using C code only. The idea
is to move more and more functionality over (separating out the
--preserve-merges handling into a different shell script, as I have no
plans to convert that code to C, and as far as I can see nobody else wants
to step up to that task, either). Eventually, we may be able to finish
that gigantic task of having git-rebase be all builtin C code.

> > If your patch series "wins", I can easily forward-port your changes to
> > the rebase-i-extra branch, but it may actually make sense to build on
> > top of the rebase-i-extra branch to begin with. If you agree: I pushed
> > the proposed change to the `rebase-i-extra+abbrev` branch at
> > https://github.com/dscho/git.
> 
> If 'git-rebase--interactive.sh' is bound to be replaced, I could
> just shrink this to the Documentation cleanup (patches 4 and 5)
> and rework the rest on top of your new implementation.

I kind of hoped that Junio would chime in with his verdict. That would be
the ultimate deciding factor, I think.

Ciao,
Johannes
