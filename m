Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D11C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 08:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78C620721
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 08:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389003AbgDCI15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:27:57 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46675 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387544AbgDCI14 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 04:27:56 -0400
X-Originating-IP: 42.109.205.134
Received: from localhost (unknown [42.109.205.134])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 444921BF26E;
        Fri,  3 Apr 2020 08:27:52 +0000 (UTC)
Date:   Fri, 3 Apr 2020 13:57:44 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Sonu Mittal <sonumittal.mittal44@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Can not logout from github account on git bash
Message-ID: <20200403082744.wvxudaiwjlw7f2fb@yadavpratyush.com>
References: <CAPk=7ZrTBkxHzN82223=3r+fcUU+kRW-LMbgOSDFw+Bb4yQn6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPk=7ZrTBkxHzN82223=3r+fcUU+kRW-LMbgOSDFw+Bb4yQn6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sonu,

On 02/04/20 07:08PM, Sonu Mittal wrote:
> I am beginner and new to GitHub and git bash, I experimented with git
> bash to clone a repository onto my system. Was successful in cloning
> .Now i don't want to clone any more repositories and want to logout of
> my GitHub account.
> After using internet help i had successfully removed the git
> credentials from windows credentials manager but then too when my
> again using git bash i am able to clone repositories without even
> entering my credentials of GitHub account (I tried restarting and
> doing again but wasn't successful in accomplishing to logout of my
> GitHub account from git bash and other terminals).
> Please help me so that i can logout from my GitHub account from the terminal .

It is possible to clone public repositories on GitHub without needing to 
enter a username/password. It is not possible to push however. So, can 
you try making a test commit and pushing to your repo? If it fails, or 
asks your username/password, then you have "logged out".

-- 
Regards,
Pratyush Yadav
