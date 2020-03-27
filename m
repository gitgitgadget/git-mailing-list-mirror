Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946B5C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 12:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC4C2072F
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 12:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0M7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:59:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51301 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgC0M7S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 08:59:18 -0400
X-Originating-IP: 42.109.203.119
Received: from localhost (unknown [42.109.203.119])
        (Authenticated sender: me@yadavpratyush.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 781E920008;
        Fri, 27 Mar 2020 12:59:15 +0000 (UTC)
Date:   Fri, 27 Mar 2020 18:29:13 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     James Yeoman <james.yeoman@appsbroker.com>
Cc:     git@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: Bug Report
Message-ID: <20200327124140.643uxbt2kvjwfxri@yadavpratyush.com>
References: <CAJ+U58yrKi=4VHRCAw68yAste=j3vzrvd2DoEW6QL-_sRWO2Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+U58yrKi=4VHRCAw68yAste=j3vzrvd2DoEW6QL-_sRWO2Aw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

On 27/03/20 11:53AM, James Yeoman wrote:
> gitk and git-gui are both not respecting git config.
> 
> When I set the diff.algorithm global config to patience, the command
> line git respects the config. However, both gitk and git-gui don't.
> When I use "git status -vv" to get a diff of the working directory,
> the diff produced respects the algorithm choice. The diff of the
> working directory in gitk and git-gui both still use the default diff
> algorithm, rather than the algorithm from the config.
 
Thanks for reporting. Can you please send steps to produce a simple 
scenario where the diff from two algorithms is different so I can test 
why git-gui is not respecting the config. Make them as minimal as 
possible.

Also, +Cc Paul, the gitk maintainer.

-- 
Regards,
Pratyush Yadav
