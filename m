Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URI_HEX shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9CCD1F991
	for <e@80x24.org>; Sun,  6 Aug 2017 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdHFR7O (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Aug 2017 13:59:14 -0400
Received: from mwork.nabble.com ([162.253.133.43]:52120 "EHLO mwork.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751331AbdHFR7O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Aug 2017 13:59:14 -0400
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Aug 2017 13:59:14 EDT
Received: from mjim.nabble.com (unknown [162.253.133.84])
        by mwork.nabble.com (Postfix) with ESMTP id 1985559AEA5BD
        for <git@vger.kernel.org>; Sun,  6 Aug 2017 10:53:50 -0700 (MST)
Date:   Sun, 6 Aug 2017 10:53:50 -0700 (MST)
From:   prateekrungta <prateek86400@gmail.com>
To:     git@vger.kernel.org
Message-ID: <1502042030108-7657477.post@n2.nabble.com>
Subject: git checkout's stderr v stdout usage
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

```
  git checkout -b new_branch 
```

Git does what's asked except that Git's success response ("Switched to a new
branch 'new_branch'"), goes to to stderr instead of stdout. 

This feels against standard unix conventions of what to output to stderr v
stdout. It's an extra jump that people scripting `Git` keep running into
when they encounter this behaviour. For e.g. other users have complained
about this as far back as 2010:
http://git.661346.n2.nabble.com/Bugreport-Git-responds-with-stderr-instead-of-stdout-td4959280.html

I'd like to suggest changing informational messages to stdout, and erroneous
ones to stderr. May I submit a patch to change this behaviour? 






--
View this message in context: http://git.661346.n2.nabble.com/git-checkout-s-stderr-v-stdout-usage-tp7657477.html
Sent from the git mailing list archive at Nabble.com.
