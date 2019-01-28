Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289371F453
	for <e@80x24.org>; Mon, 28 Jan 2019 02:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfA1Cwo (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 21:52:44 -0500
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:48870 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbfA1Cwo (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Jan 2019 21:52:44 -0500
X-Greylist: delayed 659 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jan 2019 21:52:43 EST
Received: from MTA-06-3.privateemail.com (mta-06.privateemail.com [68.65.122.16])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 94F7280AB5
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 21:41:43 -0500 (EST)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
        by MTA-06.privateemail.com (Postfix) with ESMTP id 3578A60045
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 21:41:42 -0500 (EST)
Received: from MacMini.local.mail (unknown [10.20.151.217])
        by MTA-06.privateemail.com (Postfix) with ESMTPA id C2F486003D
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 02:41:41 +0000 (UTC)
Date:   Mon, 28 Jan 2019 03:41:39 +0100
From:   Sebastian Gniazdowski <psprint@zdharma.org>
To:     git@vger.kernel.org
Message-ID: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org>
Subject: There should be a `.gitbless; file, protecting files from git
 clean
X-Mailer: Airmail (528)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
Keepiing repo clean with `git clean -dxf' is a very pleasant experience. However, ability to use it ends when one gets untracked but *wanted* files in the repo, like an untracked TODO.

Could a .gitbless file be a solution? I would list in it, e.g.:

TODO

and this way be able to use `git -dxf' again. What do you think?

-- 
Sebastian Gniazdowski 
News: https://twitter.com/ZdharmaI
IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin
Blog: http://zdharma.org

