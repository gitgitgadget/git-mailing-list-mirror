Return-Path: <SRS0=hy0J=4K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B07C35671
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 07:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80D2208C3
	for <git@archiver.kernel.org>; Sat, 22 Feb 2020 07:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zom.bi header.i=@zom.bi header.b="fyCLZQqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgBVHUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Feb 2020 02:20:52 -0500
Received: from zom.bi ([78.46.176.20]:59642 "EHLO mx.zom.bi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbgBVHUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Feb 2020 02:20:52 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Feb 2020 02:20:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=zom.bi; s=dkim;
        t=1582355622; bh=prE7FO99mHxI2Tixdv4PT0jupOn2GitqgDIudSDe58s=;
        h=From:To:Cc:Subject:Date:From;
        b=fyCLZQqVfgaF6CMBeFrMk+IguDZKZt6TukUKkJzDblDxiL5S/CKIourUbV0tEG/tt
         ZBMsvkwjqgRswxhfcAUAcqg4KTCW6b9P3cJTzjY0NIpaa8aggtVXXSky67iaop93y6
         5DX0LCZsztQxsYHKg61b6E++5D0mTPGEUyBwxRxs=
From:   Rasmus Jonsson <wasmus@zom.bi>
To:     git@vger.kernel.org
Cc:     Rasmus Jonsson <wasmus@zom.bi>
Subject: [GSoC][PATCH 0/1] Introduction & microproject
Date:   Sat, 22 Feb 2020 08:13:34 +0100
Message-Id: <20200222071335.27292-1-wasmus@zom.bi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good morning, 

I intend to apply to git for this year's Google Summer of Code. I am a
Computer Science student at Gothenburg University working toward a 
master's degree. Last year I completed GSoC with LibreOffice [1].

Working on git appeals to me due to its widespread usage and the number
of people who will benefit from my contributions.

I read the introductory material, picked a microproject, looked at
previous commits and produced the patch below.

It appears that some of the listed project ideas[2] are "taken" or at
least being looked at, so I'm also looking at issues on GitGitGadget with
the label possible-gsoc-project.

Regards, 
Rasmus

Rasmus Jonsson (1):
  t1050: clean up checks for file existence

 t/t1050-large.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.20.1

