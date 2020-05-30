Return-Path: <SRS0=ERGy=7M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091F3C433DF
	for <git@archiver.kernel.org>; Sat, 30 May 2020 18:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB0C120721
	for <git@archiver.kernel.org>; Sat, 30 May 2020 18:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgE3SDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 May 2020 14:03:20 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:39317 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgE3SDT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 May 2020 14:03:19 -0400
X-Originating-IP: 106.76.76.152
Received: from localhost (unknown [106.76.76.152])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 902E91BF207;
        Sat, 30 May 2020 18:03:07 +0000 (UTC)
Date:   Sat, 30 May 2020 23:32:59 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Peter Jensen <home.jensen@gmail.com>
Cc:     report.jensen@gmail.com, git@vger.kernel.org
Subject: Re: Git gui freeze on ubuntu 18.04
Message-ID: <20200530180259.yv6vfsv3ysk7yg5c@yadavpratyush.com>
References: <CAHgM7c4PQQvTrfn4fqKy8evQ2ydbO7ggBn4hPUTF5e2G+ApMvQ@mail.gmail.com>
 <76f5b3ff-21a7-bff7-4785-b56c34eda644@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76f5b3ff-21a7-bff7-4785-b56c34eda644@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

On 29/05/20 09:37AM, Peter Jensen wrote:
> strace from the very beginning until crash

git-gui is written in Tcl. So while strace output might give some clues, 
it is not as helpful as I'd hope. And anyway, I'm afraid I just don't 
have the bandwidth to look through it and figure out what's going on.

If you could try the latest master [0], it would be nice. The build is 
pretty simple and quick. Any hints more specific than "something 
crashes" would be much more helpful in figuring out what's going wrong.

[0] https://github.com/prati0100/git-gui/

-- 
Regards,
Pratyush Yadav
