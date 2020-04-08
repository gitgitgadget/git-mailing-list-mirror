Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283FCC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F112F2075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 18:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgDHSIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:08:06 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:53129 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDHSIG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 14:08:06 -0400
Received: from localhost (unknown [42.109.209.207])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id EA522200007;
        Wed,  8 Apr 2020 18:08:01 +0000 (UTC)
Date:   Wed, 8 Apr 2020 23:37:53 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Jordan <jordan.az@samsung.com>
Cc:     git@vger.kernel.org
Subject: Re: Installing git questions I can't find an answer to.
Message-ID: <20200408180753.j4sa7iahszp3kljn@yadavpratyush.com>
References: <CGME20200407231201epcas2p1a72ef517da1e0bff4d481a57dc593ab1@epcas2p1.samsung.com>
 <000001d60d31$f1b41d80$d51c5880$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d60d31$f1b41d80$d51c5880$@samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/04/20 08:12AM, Jordan wrote:
> Hello,
> I have searched the internet and can find no answer to my dilemma. I am
> trying to install a local copy of git on a Linux machine that is not
> connected to the internet and I don't have root privileges on. I can
> download and transfer things to this machine, but that is it. I think this
> should be possible, but have had no luck with the things I have tried.
> Thanks you for any advice.

Are you able to build Git from source? Do you have all the dependencies 
already installed? If so, I have sometimes used the Git binary in the 
build folder when testing a new feature I was working on because I 
didn't want to install an unstable version on my system. It worked fine 
for the most part, though I admit I didn't really use a whole lot of 
things other than commit and some worktree commands. Maybe something 
like that would work for you? You can download a tarball from kernel.org 
[0].

If you can't, maybe you can try building Git on a machine you _do_ have 
internet and root access on, and then copy over the binaries? Again, I 
haven't played around a whole lot with something like this so I can't 
say if it'll work. Something to try I guess.

[0] https://mirrors.edge.kernel.org/pub/software/scm/git/

-- 
Regards,
Pratyush Yadav
