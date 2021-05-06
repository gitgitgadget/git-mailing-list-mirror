Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_40,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DB4C433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 13:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1665613F1
	for <git@archiver.kernel.org>; Thu,  6 May 2021 13:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhEFNlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 09:41:18 -0400
Received: from vps.thesusis.net ([34.202.238.73]:46956 "EHLO vps.thesusis.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233853AbhEFNlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 09:41:17 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 09:41:17 EDT
Received: from localhost (localhost [127.0.0.1])
        by vps.thesusis.net (Postfix) with ESMTP id 3280C2F1A7
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:33:41 -0400 (EDT)
Received: from vps.thesusis.net ([127.0.0.1])
        by localhost (vps.thesusis.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EMzIabdr5GVt for <git@vger.kernel.org>;
        Thu,  6 May 2021 09:33:41 -0400 (EDT)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 05D532F1AB; Thu,  6 May 2021 09:33:41 -0400 (EDT)
User-agent: mu4e 1.5.7; emacs 26.3
From:   Phillip Susi <phill@thesusis.net>
To:     git@vger.kernel.org
Subject: git send-email says AUTH is unknown command?
Date:   Thu, 06 May 2021 09:30:41 -0400
Message-ID: <878s4sc7gr.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git send-email prompts for my SMTP password then says:
Command unknown: 'AUTH' at /usr/lib/git-core/git-send-email line 1573.

That line reads:

smtp_auth_maybe or die $smtp->message;

Why is it complaining that it does not know what AUTH means?  It is
connecting to port 25 and /should/ be using STARTTLS.

