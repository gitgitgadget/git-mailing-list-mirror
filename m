Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E11520248
	for <e@80x24.org>; Mon, 15 Apr 2019 14:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfDOOkt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 10:40:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:54543 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbfDOOks (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 10:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555339230;
        bh=KlC5r7wCLDvDUpyZrZ7h3mKMhEknkc7tyfyLxhv2fFw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZThAikPuAT/3lkigljGNXKwb4Eb/q5o3pevsZlGzP/3++RBDs+DDkJaa1/ClkDQym
         sJO8Od6LpoxVWRWWZ3P+yzzXMCskI49S9LQpP8RMLq4U3HOPI5N4ZPt4pgugMBPHWJ
         EOT9KPYWHkZ4VudxanBCe4Qgk5H9ENgjJ9ojISkg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MELdk-1h54QX3lIu-00FRUX; Mon, 15
 Apr 2019 16:40:30 +0200
Date:   Mon, 15 Apr 2019 16:40:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "Robin H. Johnson" <robbat2@gentoo.org>
cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: regression AGAIN in output of git-pull --rebase --recurse-submodules=yes
 --quiet
In-Reply-To: <robbat2-20190412T063235-859985527Z@orbis-terrarum.net>
Message-ID: <nycvar.QRO.7.76.6.1904151635320.12614@tvgsbejvaqbjf.bet>
References: <robbat2-20180120T054223-685328376Z@orbis-terrarum.net> <robbat2-20190410T062730-540884809Z@orbis-terrarum.net> <20190410111834.GA25638@ash> <robbat2-20190412T063235-859985527Z@orbis-terrarum.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lcGYdOIwgZsJBhcFDXPaHlKbt0yZbntqSXVTZgFhJ1Ph6wGBwUS
 yijcOoSQfP8zDs+0DsdDXniVGl0TJ95ndRBfBx+NT9FNv2I/dOC4CtvZymXQ5j+F3rE2sUN
 XsA2zyx5NCvIT4hvXsBb6gattwmQNv/FhIQyi9qO/Uc0L/0yoIYabqL2yRoeMfHLrqvk6Zx
 9+ljk2Byu2pwKVF+5OBwg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SDPvVZ8BNtA=:o+PgPkRNDppadseGKEfUkO
 xjYxOJq8cLgEGihiGlM9RrX/2fERs+iC6xFj7Hl3dV7QZtk6NEHUYOmXoEv2gU/iYw5AUAoVO
 +53Tp6Cb0cYE7MDoB0tD6T6aVTsjERs97MhJ3YGwhNL3IGLINkR87a8viVS3a/PnLDHTY2816
 8ZqIyjAX/kr4Ff7l9uTcJZUU0u/5M/l0TglVBZuOBUNv5KCmrFpWLn55eKqGkVQsye417PDig
 jCatnZQqI57BDezkC/SCK75aVvjSzqvr5oO7s7mRKO5CRyypf1pYFWwhMklmPWaDMUsQV+jIX
 oHJ0ps6q36wyqi55Z9Pnclm6KJRq/byeX2sR65p8SHnBQCDD5Cl6UusTU4osK+hK7p+l9hi76
 /zOGp2Nk9r8S7q2c2RGIEvP4HgEWHavwXDFnI28o/A2i0FK6Kqkk8VbX4YulnKELTUCJZaSQU
 irXtcEDLBzI+o1hY1acGGBDUdt2mF5g2Wiwne9KTGL2bGxhcG3a7oRZ0lq/ac49QAfQdnNMnn
 7j2yBBGIRR/ASV85L4zOgZvc+JXEWLcWg2ZMJNR2KSN+hjbi2Dn5aOebmLG2ExzRLAYfMKPyp
 rjlqpxipYLEZEg6JTzo+hyjb6lKweM83DCeP/vsqeFeaAZRO6js3MMHLiiX2tY1fMwXycVYSZ
 4KW8PJxJiIeqmc/wB/XTzwY09MwVaLManApJSoJnNKzWIXIkIDkZAx4T9/y/sDUbgJO/XHVPv
 7IdXP0tPyVfZRoSUwHCtG0T7Xnun3HkiRdA3bU/gpjbcYVNs1cwdOk4us6sXIjPuJ5ZdJQmEZ
 TJxJmKACR+Md3a1vPAYyjkiP4HhJvFycb8Y/2lgXznyI7mYKT3E95DzM72U2YfuCzGqpvtKcw
 PZn8sECCDKdUTL7LEq0ZJCaugTV8zwqNFodrNOzY7+/0Y7OEM4hTZ3Y+RXnY3C0WPzNX/6oLi
 1euGtkjkgRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robin,

On Fri, 12 Apr 2019, Robin H. Johnson wrote:

> Looking at git-rebase--preserve-merges.sh for this message, I think that
> should be a separate patch to make it respect --quiet.

Please note that `git rebase --preserve-merges` will be deprecated as of
the next Git version (see https://github.com/gitgitgadget/git/pull/158 for
details).

So I don't think it is worth the bother to fix that mode with respect to
--quiet.

Ciao,
Johannes
