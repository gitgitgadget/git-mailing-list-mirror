Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F92320970
	for <e@80x24.org>; Mon, 10 Apr 2017 07:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdDJHCt (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 03:02:49 -0400
Received: from Psilocybe.Update.UU.SE ([130.238.19.25]:53666 "EHLO
        Psilocybe.Update.UU.SE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbdDJHCt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 03:02:49 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Apr 2017 03:02:48 EDT
Received: from localhost (localhost [127.0.0.1])
        by Psilocybe.Update.UU.SE (Postfix) with ESMTP id 692B780366
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 08:56:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at Update.UU.SE
Received: from Psilocybe.Update.UU.SE ([127.0.0.1])
        by localhost (Psilocybe.Update.UU.SE [127.0.0.1]) (amavisd-new, port 10040)
        with ESMTP id gDgWPuwWBbkG for <git@vger.kernel.org>;
        Mon, 10 Apr 2017 08:56:37 +0200 (CEST)
Received: from Samuel-Aslunds-MacBook-Air.local (static-92-33-13-234.sme.bredbandsbolaget.se [92.33.13.234])
        by Psilocybe.Update.UU.SE (Postfix) with ESMTPSA
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 08:56:33 +0200 (CEST)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Samuel_=c3=85slund?= <samuel@update.uu.se>
Subject: Git documentation on branching.
Message-ID: <3563ee7a-1175-2010-7176-0339cd3e60ee@update.uu.se>
Date:   Mon, 10 Apr 2017 08:56:30 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all.

I just started playing around with branching in git.
I have been using it more or less as Subversion until now.

One feature with "git branch xyz" and "git checkout xyz" that is rather 
obvious if you know them but bit me a little since I did not, is that 
uncommitted work in progress is not affected or saved when switching 
between branches. Thus I cleaned up the directory when working with the 
branch and now I'm trying to find a stash where I hopefully have a copy 
of those files.

Would it be possible to add something in the documentation to warn 
others that uncommitted work is not saved or affected by branching?
The first two hits on my google search was very informative about 
branching but I did not see that specific nugget of information (I might 
have been careless reading, but if I did not see it others will probably 
also miss it).

Git - git-branch Documentation
https://git-scm.com/docs/git-branch

Git - Branches in a Nutshell
https://git-scm.com/book/.../Git-Branching-Branches-in-a-Nutsh...

This is my first try to contribute to the Git community, I hope it will 
be useful to somebody.

Regards,
//Samuel
