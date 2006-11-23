X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: rebase fails but not sure why
Date: Thu, 23 Nov 2006 04:59:46 -0500
Message-ID: <20061123095946.GA32620@coredump.intra.peff.net>
References: <200611230026.58936.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 09:59:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611230026.58936.alan@chandlerfamily.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32130>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnBN2-0001xd-2x for gcvg-git@gmane.org; Thu, 23 Nov
 2006 10:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933429AbWKWJ7t (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 04:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757307AbWKWJ7t
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 04:59:49 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:40859
 "HELO peff.net") by vger.kernel.org with SMTP id S1757306AbWKWJ7s (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 04:59:48 -0500
Received: (qmail 29175 invoked from network); 23 Nov 2006 04:59:53 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 23 Nov 2006 04:59:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Nov
 2006 04:59:46 -0500
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

On Thu, Nov 23, 2006 at 12:26:58AM +0000, Alan Chandler wrote:

> I have now got to a point where the following error occurs during a rebase.
> 
> fatal: empty ident  <alan@chandlerfamily.org.uk> not allowed
> Commit failed, please do not call "git commit"
> directly, but instead do one of the following:

It should be pulling that identity from the old commit (using git-commit
-C). Do you have a commit object with a blank author or committer name
(which shouldn't have been allowed in the first place, but you never
know)? Try running git-log on the range of commits being rebased.

