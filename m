Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA6BC4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 15:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5BB60F9D
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 15:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhG1PiJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 11:38:09 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:62734 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhG1PiH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 11:38:07 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m8ldD-00064N-9A
        for git@vger.kernel.org; Wed, 28 Jul 2021 16:38:04 +0100
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.email>
Subject: Using two-dot range notation in `git rebase`?
Message-ID: <b3b5f044-8c76-ec71-45d6-1c7fea93c519@iee.email>
Date:   Wed, 28 Jul 2021 16:38:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a reasonable way to use the two-dot range notation in git
rebase, particularly in an  --onto situation?

In my case I have a short series that depends on both some existing Git
for Windows (GfW) patches (`main` branch), and some patches now in
`git/master`. I'm now able to rebase it onto the GfW `shears/master`
branch which contains both sets of patches (and one that was in the last
git release).

It felt that it ought to be possible to use a simple two dot range to
extract my series, rather than identifying the individual end points in
a similar manner to that used in the description"set of commits .. shown
by `git log <upstream>..HEAD`".

Or is this something that could be a project?
--

Philip


