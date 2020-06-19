Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25183C433E1
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0845E21532
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 15:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392604AbgFSPTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:19:21 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:55857 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392428AbgFSPPg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 11:15:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49pMnK4RMdz1qs3X
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 17:15:33 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49pMnK4LK2z1r57B
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 17:15:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id nynEHZAEe7xx for <git@vger.kernel.org>;
        Fri, 19 Jun 2020 17:15:33 +0200 (CEST)
X-Auth-Info: qWZl/hK33/QQ5qFUhBeMI1yeqrS/3g5jEZelX1xih5Sh/F+LH+Wu2+qmKAop8XMP
Received: from igel.home (ppp-46-244-176-157.dynamic.mnet-online.de [46.244.176.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 17:15:32 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 684EE2C0B01; Fri, 19 Jun 2020 17:15:32 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     git@vger.kernel.org
Subject: Bogus error from git log --full-diff
X-Yow:  I LIKE Aisle 7a.
Date:   Fri, 19 Jun 2020 17:15:32 +0200
Message-ID: <87h7v7xf1n.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you have log.follow=true, then git log --full-diff doesn't work any
more, giving a bogus error:

$ ./git -c log.follow=true log --full-diff .
fatal: --follow requires exactly one pathspec

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
