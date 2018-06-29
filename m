Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB6471F516
	for <e@80x24.org>; Fri, 29 Jun 2018 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755603AbeF2TRP (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 15:17:15 -0400
Received: from mail.cmpwn.com ([45.56.77.53]:49662 "EHLO mail.cmpwn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754012AbeF2TRO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 15:17:14 -0400
X-Greylist: delayed 561 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2018 15:17:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cmpwn.com; s=cmpwn;
        t=1530299452; bh=mE6H44BZiugNWTYUQP4KMKNJi5haJR3UNGI/c+LNJEs=;
        h=Date:From:To:Cc:Subject;
        b=htNWZlrBpA5ZQ/vlulZDK5On5/W1RTO01d9tTBoZcKXQ1cK9KwZqdXDWZgL6AIRIY
         01euGvcu+cnIGYYJRyv++Gk2z0Iv9NzX/rXzM2qAQObeF8DhyCRWG+x6j+WNs/ZHfS
         f/vK+K+r7h4zDoBkocdl4u8w7bQtM5/9jqJGNkBw=
Date:   Fri, 29 Jun 2018 15:07:51 -0400
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     contact@emersion.fr
Subject: send-email: change the default value of sendmail.validate
Message-ID: <20180629190751.GA2559@miku>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GNU:  Terry Pratchett
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of this configuration option is to prevent your emails from
blowing up on SMTP servers (rather than Extended SMTP servers). However,
I find it often confuses people whose patches are otherwise correct, and
they don't know how to solve the issue.

I haven't seen an SMTP server in a very long time which doesn't support
extended SMTP. The default behavior should probably change. If not, the
error message should be more clear about action items to address the
issue.

I'll send a patch around to change this shortly.

--
Drew DeVault
