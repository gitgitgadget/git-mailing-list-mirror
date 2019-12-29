Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74348C2D0C0
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 20:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB352071E
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfL2UeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 15:34:20 -0500
Received: from sdaoden.eu ([217.144.132.164]:59786 "EHLO sdaoden.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbfL2UeU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 15:34:20 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Dec 2019 15:34:19 EST
Received: by sdaoden.eu (Postfix, from userid 1000)
        id 4499016057; Sun, 29 Dec 2019 21:29:15 +0100 (CET)
Date:   Sun, 29 Dec 2019 21:29:13 +0100
From:   Steffen Nurpmeso <steffen@sdaoden.eu>
To:     git@vger.kernel.org
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>
Subject: 2.24.1: git cherry-pick --edit fails
Message-ID: <20191229202913.LE_3R%steffen@sdaoden.eu>
Mail-Followup-To: git@vger.kernel.org,
 Steffen Nurpmeso <steffen@sdaoden.eu>
User-Agent: s-nail v14.9.15-262-g449d711c
OpenPGP: id=EE19E1C1F2F7054F8D3954D8308964B51883A0DD;
 url=https://ftp.sdaoden.eu/steffen.asc; preference=signencrypt
BlahBlahBlah: Any stupid boy can crush a beetle. But all the professors in
 the world can make no bugs.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again.

  P.S.: i can confirm the surroundings are fixed in 2.25.0-rc0!

Looking into the archives it could be addressed for upcoming
release already, please ignore then.  But with 2.24.1, if i do

  git cherry-pick --allow-empty --edit SHA1 SHA1...

i end up with

  [topic/anonymous-1 746c421c] include/mx: new-style headers: add forgotten struct forwards
   Date: Fri Aug 23 16:49:53 2019 +0200
   15 files changed, 43 insertions(+), 2 deletions(-)
  On branch topic/anonymous-1
  Cherry-pick currently in progress.

  nothing to commit, working tree clean
  The previous cherry-pick is now empty, possibly due to conflict resolution.
  If you wish to commit it anyway, use:

      git commit --allow-empty

  and then use:

      git cherry-pick --continue

  to resume cherry-picking the remaining commits.
  If you wish to skip this commit, use:

      git cherry-pick --skip

I.e., i edit the commit message, the commit message has been
modified and the valid is ok, but the above appears.


--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)
