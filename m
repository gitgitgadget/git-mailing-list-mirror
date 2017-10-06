Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6CA2036B
	for <e@80x24.org>; Fri,  6 Oct 2017 10:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751983AbdJFKOh (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 06:14:37 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:37932 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbdJFKOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 06:14:35 -0400
Received: from [::1] (port=55464 helo=cpanel2.indieserve.net)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e0PeM-0008Cn-Up
        for git@vger.kernel.org; Fri, 06 Oct 2017 06:14:34 -0400
Received: from 158.116.144.29 ([158.116.144.29]) by crashcourse.ca (Horde
 Framework) with HTTPS; Fri, 06 Oct 2017 06:14:34 -0400
Date:   Fri, 06 Oct 2017 06:14:34 -0400
Message-ID: <20171006061434.Horde.16MqZ-fejqXm6BLpL7prK1K@crashcourse.ca>
From:   rpjday@crashcourse.ca
To:     git@vger.kernel.org
Subject: is there a truly compelling rationale for .git/info/exclude?
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday@crashcourse.ca
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

   currently having a discussion with ben straub of "pro git" notoriety,
and he and i seem to agree that there's not much value in registering
ignore patterns in a repo-specific .git/info/exclude file.

   on the one hand, the .gitignore files that come with a repo would
represent (in ben's terminology, which i really like) the "intrinsic"
patterns to be ignored that are related to the basic content of the repo.

   at the other end, users are certainly welcome to add extra patterns
to be ignored, based purely on the way they work -- perhaps based on
their choice of editor, they might want to exclude *.swp files, or
if working on a Mac, ignore .DS_Store, and so on, using a
core.excludesFile setting.

   and in this funny grey area in between, we have .git/info/exclude,
to be used for ... what, exactly? the one argument i've come up with
is the situation where you discover that a repo you've cloned has an
incomplete set of .gitignore patterns, and while you submit a patch
for that to the maintainer, you can temporarily add that pattern
to .git/info/exclude, and as soon as the patch is accepted, you can
toss it.

   but even that isn't a really compelling reason. so what's it for?

rday


