Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B81C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED0D20728
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 11:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJ3LJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 07:09:49 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:39934 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3LJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 07:09:49 -0400
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 620C33AEFA4
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 10:59:22 +0000 (UTC)
Received: from localhost (unknown [103.82.80.53])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 91DF320000A;
        Fri, 30 Oct 2020 10:59:00 +0000 (UTC)
Date:   Fri, 30 Oct 2020 16:28:56 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-gui: How to configure for use in gigantic projects?
Message-ID: <20201030105856.ctjkxxwmudaeewpa@yadavpratyush.com>
References: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=KpNaPFjMOzXzF382cv1p58nMoOPXAm0MCdA8WZMBznVA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

On 30/10/20 11:16AM, Birger Skogeng Pedersen wrote:
> Hi,
> 
> I would like to use git gui for a project. The problem is that the
> repository directory is really gigantic. Doing a scan (F5) takes a
> couple of minutes to finish.
> 
> I would like the scan to only focus on files that are specifically
> added to the index. In git I do this:
> 
> git config status.showUntrackedFiles no
> 
> git status will then only show status of files that I have
> specifically added. So git status completion is instant.
> 
> But this configuration appears to have no effect on git-gui. The scan
> is just as slow as before.
> 
> Anything I can do to make git-gui only scan files that are
> specifically added, and not look through the whole directory?

Uncheck "Show untracked files" in options. It is controlled by the 
config 'gui.displayuntracked'.

-- 
Regards,
Pratyush Yadav
