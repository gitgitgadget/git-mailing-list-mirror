Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36717202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932661AbdJ3R2Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:28:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:56822 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932356AbdJ3R2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:28:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0PdN-1dJKf83g0z-00udSJ; Mon, 30
 Oct 2017 18:28:19 +0100
Date:   Mon, 30 Oct 2017 18:28:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
In-Reply-To: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710301827000.6482@virtualbox>
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a0tnBTPiIDWvJSboi1d2DtNNgJvSvu/aA475Ii5LN2xOtw+Va3h
 Am00jTkr9V6kVvrtDz6LcY2y0PbessSnN8ufi9AvQ5TTVW+87cXLQwrQgzFtQ6AV12gvWj6
 yeS1olxCw8oPR588LwLTgRMUb7zXFwgWjxw7wgz7v4O/te9GbjEeUv+t8w3zP5f0qGyEzxj
 feGMNvCPBh/AQxiouKTAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pMUcT0I1O/c=:yy03lf9ymC9WbYK1oHVutS
 Tcy5fB4VRox4fVo9dN/BPcHFm8+iai2eIX8nZgsoyN4B1hZgTcYpiYe2J5+DVOM7zM75ZSTWf
 XFqgmaO5+X+S5lVLG88To+XSTYXXvbqjovZHQfuogwfsSMAeD5a/6dJK+velGzciRk/nbpyyW
 G015Hx3hkisQ8UUMnLPbktBS5QJ2+TwdHmA9k5HUcr1tGkPba3BPeoC8ZLK8M9hJvUPbSHN/m
 j/IXxP/CmIhNK2d/10qxzPIBl3NWX3nURKPR2aItV5sUlKGYEtHdb5CJy//j+7W6mvtFb9fbP
 EHIOEP3b84LR4K9kyx4+bmUqqvqjpOT6spfwbJKmWGkIM5n44UvQ0B23gk+6/ZQrJhEtOXfEE
 rJvyAsjsn8YVqsuIqT8CbDGVbsOFv1msby0S/d8SIK2ORZ4vWx1CpZKzkSKj5TliHL9dqtq2u
 K5LukcaflTAw2XOaJH4iDfjfCN91YE4wvyj580l4+DLiHdTnH8OFkImxSyMweqhuf1RPBfaIc
 eDWuu+BPecbl3hWzm4HuqnwPRYH1NNeW2N/F4kp+wN+uIyqN6PUlae66AJs7waR9xXmyPJn+h
 BeKboAg8r1ZhHcQUGsWOX3vsKp0vyFozfJ6AUIGgcDz9pOj6k4oWjBHMCgbdracmj23W+QHH0
 bPROvEpCbvitDI8nr6lRp1lIR5qcEs/w5xqcKRthjvWPsw/smE5XpxAuepjGKcOAMhlzWyAvB
 4t11txV83B0tCxTBPEoIIQlDOvuvZqoNZ88f5lB6RZh4nci76AcAgCYjaZs1N+Zl17txIkNnd
 35uSMG6cK0o2zQlEyFqc2HxQHAWBszOqQaVphQF9QosdHtFrCQIAgh6JoPvzeNgVpNYP8aJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 30 Oct 2017, Junio C Hamano wrote:

> * jc/branch-name-sanity (2017-10-14) 3 commits
>   (merged to 'next' on 2017-10-16 at 174646d1c3)
>  + branch: forbid refs/heads/HEAD
>  + branch: split validate_new_branchname() into two
>  + branch: streamline "attr_only" handling in validate_new_branchname()
> 
>  "git branch" and "git checkout -b" are now forbidden from creating
>  a branch whose name is "HEAD".

Question: should we respect core.ignoreCase and if it is true, compare
case-insensitively? Or should we just keep the comparison
case-sensitively, in preparation for a (hopefully near) refs backend that
does not inherit filesystems' case-insensitivity?

Ciao,
Dscho
