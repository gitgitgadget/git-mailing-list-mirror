X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: git-format-patch little gripe
Date: Fri, 3 Nov 2006 18:16:47 -0500
Message-ID: <20061103231647.GB6970@coredump.intra.peff.net>
References: <7vwt6cbwzq.fsf@assigned-by-dhcp.cox.net> <20061103195253.9244.qmail@web31814.mail.mud.yahoo.com> <7v3b905fqi.fsf@assigned-by-dhcp.cox.net> <87velwupk6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 23:16:59 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87velwupk6.wl%cworth@cworth.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30895>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg8HN-0000MN-FN for gcvg-git@gmane.org; Sat, 04 Nov
 2006 00:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932492AbWKCXQu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 18:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWKCXQu
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 18:16:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3973 "HELO
 peff.net") by vger.kernel.org with SMTP id S932492AbWKCXQu (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 18:16:50 -0500
Received: (qmail 8578 invoked from network); 3 Nov 2006 18:15:51 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 3 Nov 2006 18:15:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov
 2006 18:16:47 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Fri, Nov 03, 2006 at 02:35:05PM -0800, Carl Worth wrote:

> I mean, git show is fine for displaying something to just read it, but
> if the results are to be fed back into git at some point, then
> git-show is pretty useless, (throws away commit message, author,
> timestamp, etc.).

Try
  git-show --pretty=email
or even
  git-show --pretty=email --stat -p

