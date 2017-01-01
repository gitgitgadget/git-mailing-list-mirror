Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E03F20968
	for <e@80x24.org>; Sun,  1 Jan 2017 08:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbdAAIm4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 03:42:56 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:21197 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753230AbdAAImz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 03:42:55 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3trty53ntfz5tlG;
        Sun,  1 Jan 2017 09:42:53 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 13ED52824;
        Sun,  1 Jan 2017 09:42:51 +0100 (CET)
Subject: Re: Rebasing multiple branches at once
To:     Mike Hommey <mh@glandium.org>
References: <20161231081433.3zo6lrsjsu2qho4u@glandium.org>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3f29bd56-6f63-c035-71d3-9b2f2577b998@kdbg.org>
Date:   Sun, 1 Jan 2017 09:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20161231081433.3zo6lrsjsu2qho4u@glandium.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.12.2016 um 09:14 schrieb Mike Hommey:
> Hi,
>
> I've had this kind of things to do more than once, and had to do it a
> lot today, so I figured it would be worth discussing whether git-rebase
> should be enhanced to support this, or if this should go in a separate
> tool or whatever.
>
> So here is what I'm trying to do in a not-too painful way:
>
> I'm starting with something like this:
> A---B---C---D---E
>             \---F
>
> where A is master, and E and F are two local topics with a common set of
> things on top of master.
>
> The next thing that happens is that master is updated, and I want to
> rebase both topics on top of the new master.
>
> So I now have:
>
> A---G
> \---B---C---D---E
>             \---F
>
> If I do the dumb thing, which is to do `git rebase master E` and `git
> rebase master F`, I end up with:
>
> A---G---B'---C'---D'---E'
>     \---B"---C"---D"---F'
>
> That is, I just lost the fast that E and F had common history.

Git garden shears, perhaps?

https://public-inbox.org/git/alpine.DEB.2.20.1609111027330.129229@virtualbox/

-- Hannes

