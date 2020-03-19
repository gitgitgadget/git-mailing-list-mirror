Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03DAC4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1472072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 06:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCSGoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 02:44:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40136 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSGoH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 02:44:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 2F5F11F619;
        Thu, 19 Mar 2020 06:44:07 +0000 (UTC)
Date:   Thu, 19 Mar 2020 06:44:07 +0000
From:   Eric Wong <e@yhbt.net>
To:     Timothee Cour <timothee.cour2@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git makes it impossible to ignore or override global gitconfig,
 needs `GITCONFIGFILE`
Message-ID: <20200319064407.GA26408@dcvr>
References: <CANri+Ey71QbWxNH+RhMfYuUSDEpYtv28ushUhK8Tt0xWUAU9iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANri+Ey71QbWxNH+RhMfYuUSDEpYtv28ushUhK8Tt0xWUAU9iw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Timothee Cour <thelastmammoth@gmail.com> wrote:
> git makes it impossible to ignore global gitconfig. This is
> essentially what's being asked here:
> https://stackoverflow.com/questions/23400449/how-to-make-git-temporarily-ignore-gitconfig
> 
> ## proposal:
> add an environment variable (like for tig and other programs), eg:
> `GITCONFIGFILE=~/.gitconfig_temp git diff`
> seems like an easy change that would make it easy for users to ignore
> or override their gitconfig

You can use GIT_CONFIG for that, and there's also
GIT_CONFIG_NOSYSTEM.  They're both documented in the
git-config(5) manpage.

> ## note:
> I've asked here:
> https://groups.google.com/forum/#!topic/git-users/1ehWsItL8vE but got
> 0 response after 6 months

Oh well...  I don't pay any attention to that list, and not too
much to this one, either.  I was just working on the archives
and noticed this was the latest message on this list :>
