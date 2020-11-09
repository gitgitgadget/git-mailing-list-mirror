Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A11AC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 09:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503A720719
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 09:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKIJUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 04:20:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:46178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgKIJUo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 04:20:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6DBDABAE
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 09:20:42 +0000 (UTC)
Date:   Mon, 9 Nov 2020 10:20:41 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Git List <git@vger.kernel.org>
Subject: git gc ineffective
Message-ID: <20201109092041.GV29778@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello,

I am running git 2.29.1

I noticed I am running out of disk space, and one repository taking up
about 38G. Did git gc --aggressive, and the used space *raised* to 42G,
and git would report it does gc after every commit. Did gc without
--aggressive, and the used space almost *doubled* to 75G (about 1G is
checkout and some utracked files).

The expected size is about 20G. Is there some way to debug gc to figure
out what went wrong?

Thanks

Michal
