Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD53EC3F2C6
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8BA20838
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 14:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgCCOWv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:22:51 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:37395 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgCCOWv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 09:22:51 -0500
Received: from [92.30.123.115] (helo=[192.168.1.36])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1j98Rc-0003uQ-Ca; Tue, 03 Mar 2020 14:22:49 +0000
Subject: Re: GIT_WORK_TREE; a recipe for disaster
To:     Phillip Susi <phill@thesusis.net>, git@vger.kernel.org,
        Pratyush Yadav <me@yadavpratyush.com>
References: <875zflh7dw.fsf@vps.thesusis.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <c2cf7919-8a24-0b62-3f99-03bf50dcc659@iee.email>
Date:   Tue, 3 Mar 2020 14:22:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zflh7dw.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03/2020 13:53, Phillip Susi wrote:
> I'm using git for windows version 2.25.0.windows.1.  Yesterday I was in
> a bash command line and changed directories to another project.  I ran
> git status and it complained about basically everything being deleted
> when the files were sitting there just fine.  I thought that maybe it is
> confused since I upgraded git recently and so I ran git checkout -f and
> git clean -xfd to make sure that the working directory would be restored
> to a pristine state.  I later changed back to the first project
> directory where I was horrified to see that all of the files from the
> second project had been checked out, and the changes in that project
> that I had been working on for a few days had been deleted.
>
> It seems the cause of this is that I had opened git bash from the git
> gui menu instead of from the windows explorer menu.  In previous
> releases, this cause GIT_DIR to be set ( I believe ), and so that
> session of git bash was tied to that repoistory even if you changed
> directories to another repository.  I always thought this was rather
> annoying, but things seem to be worse now that I have upgraded, because
> git now uses the index and hisotry log etc from the cwd, but compares
> that index to files elsewhere.  This seems like a recipe for disaster.
> Why does git gui set these environment variables at all, and could it
> please stop?
>
Probably worth including Pratyush Yadav for the git-gui maintenance aspect.
--
Philip
