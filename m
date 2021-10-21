Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1582EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BF76124D
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 21:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbhJUVYe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 17:24:34 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:24663 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230272AbhJUVY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 17:24:28 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hb0mg2zTyz6R
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 23:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1634851331; bh=bf1e1kPmwe4hZyRIOS1zursXczoFR2vFRAy7ik6UkcY=;
        h=Date:From:To:Subject:From;
        b=ms0L6oNZS2Dd/itSplC61gATF5J9Jsyw7OUgfh2SPnUNQwrhHJdCFpJLFRWL09hhk
         jMIysPjvWqYWN5qld5RIDqwObSXuO463NgSfvATbdweVsasPe3N+MXCJ+yHluE7tdZ
         Gl1HIEGUIplkuQsLRbGyxejzG0JXmR/pIOPkCdzBstOT2cztFOVjLGvBSmPCdVvb67
         0hcBnK9K8ynM+MCBp3xbaENnPcIdCURzRAYpukVfopvPJfv286nxXrLkIaSWL8bfxK
         4+7NjQqA9NZ9eGQ1gWK6J5H3KYd5oQfQG96d58WCL/rWNbAm0igN8Wh15d0GDe9M2C
         YHiGokhXCtzrg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Thu, 21 Oct 2021 23:22:10 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     git@vger.kernel.org
Subject: git format-patch --signoff
Message-ID: <YXHaAu2G51vy5H8z@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I just noticed that `git format-patch --signoff` adds the 'Signed-off-by'
line even if the exact same line is already present in the commit message.
Could this be avoided in the tool?

git version 2.30.2

Best Regards
Micha³ Miros³aw
