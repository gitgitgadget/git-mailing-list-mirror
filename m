Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9645C433EF
	for <git@archiver.kernel.org>; Sun, 22 May 2022 22:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbiEVWCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 May 2022 18:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiEVWCr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 May 2022 18:02:47 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFBB2EA2B
        for <git@vger.kernel.org>; Sun, 22 May 2022 15:02:45 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nstes-0001ql-FS;
        Sun, 22 May 2022 23:02:43 +0100
Message-ID: <f3814646-4763-62e1-b64e-d1aab3fdbbc8@iee.email>
Date:   Sun, 22 May 2022 23:02:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Git commands version documentation
Content-Language: en-GB
To:     Hrushikesh Rao <hrushikesh20thegreat@gmail.com>,
        git@vger.kernel.org
References: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/05/2022 19:41, Hrushikesh Rao wrote:
> Hey,
>
> I am working on git maintenance project in Jenkins. We are using
> git-maintenance to improve the performance of the git commands further
> improving the build speed. Git maintenance was added in git version
> 2.30.0. The aim of the project is to also support systems having git
> version < 2.30.0. Few git maintenance tasks very available before the
> maintenance command was introduced i.e gc,commit-graph,gc and
> incremental repack. 

> Is there a way for me to find out in which version these commands have
> been introduced? Based on this we can support legacy git version.

One manual method is to look at the history (blame) for the respective
man pages to see when the man page was initially committed, and when
appropriate options were added.

Maybe use one of the hosting providers GUI if that is your choice e.g.
https://github.com/git/git/blame/master/Documentation/git-gc.txt

--
Philip
