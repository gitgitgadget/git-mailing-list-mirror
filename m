Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A3DC433B4
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 15:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FF861406
	for <git@archiver.kernel.org>; Sat, 24 Apr 2021 15:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhDXPF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Apr 2021 11:05:59 -0400
Received: from marcos.anarc.at ([206.248.172.91]:47854 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233684AbhDXPF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Apr 2021 11:05:57 -0400
Received: by marcos.anarc.at (Postfix, from userid 1000)
        id C1ABE10E237; Sat, 24 Apr 2021 11:05:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
        s=marcos-debian.anarcat.user; t=1619276718;
        bh=KNH9GFq2+GMgNWT9Ft7rP0yzJWwKW4mrQua1PsqAyf4=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=WVePiy9BEgzYtplQjXbNP72DQvGaYV1TzoxJ6lDUdT7pkOFo4eqvJKHJ+8e6QGJog
         /LqpzbuYVZKNddb/CZGr6WvwWSiw6Hp6kBvE/ZTvkaOBzmiuedbtXj/4S3zpzsBtVA
         hzyGdatOxtdBxK1aN1cbing9+mtMUwhjXgRuyRaOHCc6b4tf8NoVCYoSL+EG1IkACW
         LonaTCiq8pCXI8a3e25pnzbdBDeAIXFGngqr5Tmmn8NslogAYasZrEGOMQZvr4o6Jz
         TqVRoml1KJejRN57qbq9WLBF/lFD1lMZw/kkuokxasU2a8PGwFAt5+hggyDRUkbNru
         FPWoyDZKu7OBA==
Received: by angela.anarc.at (Postfix, from userid 1000)
        id 76CCAAC08C; Sat, 24 Apr 2021 11:05:18 -0400 (EDT)
From:   =?utf-8?Q?Antoine_Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Subject: RE: how to rename remote branches, the long way
In-Reply-To: <60839422353fc_10cb9208c7@natae.notmuch>
Organization: Debian
References: <87mttofs5t.fsf@angela.anarc.at> <60836fa129078_ff602089c@natae.notmuch> <87k0osfpt8.fsf@angela.anarc.at> <60839422353fc_10cb9208c7@natae.notmuch>
Date:   Sat, 24 Apr 2021 11:05:18 -0400
Message-ID: <87fszfafkh.fsf@angela.anarc.at>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-04-23 22:44:34, Felipe Contreras wrote:

[...]

Well, that attempt at working with git upstream went about as bad as I
expected. I was afraid I'd get ignored or worse, get dragged into the
naming debate.

Seems I got both, amazingly enough. I guess that I'll take that as a
"no, not welcome here" and move on...

A.
