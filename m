X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: why fetching files is so slow
Date: Fri, 24 Nov 2006 11:16:09 -0800
Message-ID: <20061124191609.GA32506@localdomain>
References: <loom.20061124T143148-286@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 19:16:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <loom.20061124T143148-286@post.gmane.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GngX1-00034l-Rr for gcvg-git@gmane.org; Fri, 24 Nov
 2006 20:16:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935014AbWKXTQN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935016AbWKXTQM
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 14:16:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37848 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S935014AbWKXTQM (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 14:16:12 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 135287DC098; Fri, 24 Nov 2006 11:16:10 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Nov 2006
 11:16:09 -0800
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Pazu <pazu@pazu.com.br> wrote:
> ... compared to the standalone svn client. I'm working with repositories over
> the internet, using not-so-fast links, but still, a svn checkout takes somewhere
> around 5 to 10 minutes, while git-svn fetch takes at least 10 times that just to
> fetch the initial revision. Later fetches also take *a lot* more time than a svn
> update would.

git-svn transfers full files, and not deltas.  I'll hopefully have a
chance to look into improving the situation for slow links this weekend.

-- 
