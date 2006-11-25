X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: git-format-patch little gripe
Date: Sat, 25 Nov 2006 10:39:49 -0500
Message-ID: <20061125153949.GA11136@coredump.intra.peff.net>
References: <376237.14965.qm@web31805.mail.mud.yahoo.com> <20061103185026.GA28566@coredump.intra.peff.net> <20061125103033.2ea742d3.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 15:40:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061125103033.2ea742d3.seanlkml@sympatico.ca>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32294>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnzdE-0001G1-15 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 16:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966640AbWKYPjx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 10:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757923AbWKYPjw
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 10:39:52 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:9700 "HELO
 peff.net") by vger.kernel.org with SMTP id S1757921AbWKYPjw (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 10:39:52 -0500
Received: (qmail 340 invoked from network); 25 Nov 2006 10:39:57 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 25 Nov 2006 10:39:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Nov
 2006 10:39:49 -0500
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Sat, Nov 25, 2006 at 10:30:33AM -0500, Sean wrote:

> If your mail setup support imap, the patches can be dumped directly into
> it rather than having to go through an mbox.  For instance you can have
> something like this in your ~/.gitconfig:

Sure, I could. But if you have a client which supports mboxes, it's
probably better to use the mbox. With your solution, I send the patch to
the imap server, then fire up the mail client and re-download the
patch, possibly mark it up, and then send it out by smtp. The latency
increase can be noticeable, especially for big patches and slow imap
servers.

> To move all the patches into your imap drafts folder to be accessed
> by whatever email client you use.

Oh come on, Real Men just edit the mbox in vi. :)

