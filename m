Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD9C2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD7720658
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 23:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfL3XNv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:13:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:45330 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbfL3XNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 18:13:51 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0782E1F463;
        Mon, 30 Dec 2019 23:13:51 +0000 (UTC)
Date:   Mon, 30 Dec 2019 23:13:50 +0000
From:   Eric Wong <e@80x24.org>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: "gmane:" search undocumented on lore.kernel.org/git
Message-ID: <20191230231350.GA16499@dcvr>
References: <03879A6A-2E8B-45D9-A06E-51926AC949F9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03879A6A-2E8B-45D9-A06E-51926AC949F9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> wrote:
> Hello all,
> 
> I just noticed that the help page on lore.kernel.org/git does not mention the possibility of searching for messages using Gmane id’s, as the public-inbox.org/git help page does. 
> 
> The search works though, it’s just undocumented, so I thought I’d share; I don’t know how much control we have on the lore.kernel.org public-inbox installation. 

+Cc Konstantin who runs lore.

Unless you're getting load-balanced to differently configured
instances, I think it's luck that the "gmane:" queries you tried
work.

gmane:  doesn't seem configured on lore at all.  Compare:

	https://lore.kernel.org/git/?q=gmane:1
	https://public-inbox.org/git/?q=gmane:1
