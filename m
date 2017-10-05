Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42C102036B
	for <e@80x24.org>; Thu,  5 Oct 2017 09:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbdJEJLG (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 05:11:06 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:36088 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdJEJLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 05:11:05 -0400
Received: from [::1] (port=34912 helo=cpanel2.indieserve.net)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1e02BM-0005Pv-J4
        for git@vger.kernel.org; Thu, 05 Oct 2017 05:11:04 -0400
Received: from 158.116.144.29 ([158.116.144.29]) by crashcourse.ca (Horde
 Framework) with HTTPS; Thu, 05 Oct 2017 05:11:04 -0400
Date:   Thu, 05 Oct 2017 05:11:04 -0400
Message-ID: <20171005051104.Horde.8J0J7-XC6jD4AOgtYrou3Na@crashcourse.ca>
From:   rpjday@crashcourse.ca
To:     git@vger.kernel.org
Subject: couple questions about git "logical variables" and "git var"
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

   i just ran across "git var" for the first time, and it seems a bit weird.
it refers to the (apparently) four git "logical variables":

  - GIT_AUTHOR_IDENT
  - GIT_COMMITTER_IDENT
  - GIT_EDITOR
  - GIT_PAGER

first question -- what is it about precisely those four variables that makes
them "logical" variables in git parlance? just those four? no others?

   also, the man page "man git-var" seems wrong:

"OPTIONS
   -l
     Cause the logical variables to be listed. In addition, all the variables
     of the Git configuration file .git/config are listed as well."

no, if i run "git var -l", i see not only the logical variables, but i
see *all* of the available config settings (system and global), not just
those in .git/config (unless i'm misreading what that is supposed to mean).

   thoughts?

rday

p.s. yes, i realize this command is deprecated in favour of "git config -l",
but as long as it's available, it should work as described in the man page.





