Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60F562027C
	for <e@80x24.org>; Mon, 29 May 2017 11:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdE2Lz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 07:55:26 -0400
Received: from mail.hashbang.sh ([104.236.46.93]:51836 "EHLO mail.hashbang.sh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750954AbdE2LzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 07:55:25 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 May 2017 07:55:25 EDT
Received: from da1.hashbang.sh (da1.hashbang.sh [104.245.35.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hashbang.sh (Postfix) with ESMTPS id 48D251BAE8
        for <git@vger.kernel.org>; Mon, 29 May 2017 11:45:21 +0000 (UTC)
Received: from macports.org (localhost [IPv6:::1])
        by da1.hashbang.sh (Postfix) with ESMTPS id C3A07E13F9
        for <git@vger.kernel.org>; Mon, 29 May 2017 11:45:19 +0000 (UTC)
Date:   Mon, 29 May 2017 11:45:18 +0000
From:   Zero King <l2dy@macports.org>
To:     git@vger.kernel.org
Subject: [Bug] setup_git_env called without repository
Message-ID: <20170529114518.dwlyayg5kfjjwtpx@macports.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

After upgrading to Git 2.13.0, I'm seeing the following error message
when running `git am -h`.

    $ git am -h
    fatal: BUG: setup_git_env called without repository

And with Git built from the next branch:

    $ git am -h
    BUG: environment.c:172: setup_git_env called without repository
    Abort trap: 6

-- 
Best regards,
Zero King
