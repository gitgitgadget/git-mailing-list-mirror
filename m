X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 7 Dec 2006 16:40:53 -0500
Message-ID: <20061207214053.GC31035@fieldses.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net> <20061207195715.GG12143@spearce.org> <7v64cns8nf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 21:41:07 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v64cns8nf.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33636>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsQzD-0000iV-Q4 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 22:41:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163431AbWLGVk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 16:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163433AbWLGVk4
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 16:40:56 -0500
Received: from mail.fieldses.org ([66.93.2.214]:36811 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163431AbWLGVkz (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 16:40:55 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GsQz7-0002KS-DC; Thu, 07 Dec 2006
 16:40:53 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, Dec 07, 2006 at 01:23:00PM -0800, Junio C Hamano wrote:
> Under my suggestion, the new git-checkout -b (and git-branch)
> would:
> 
>  (0) proceed if there is an explicit branch point specified on
>      the command like, just like now;
> 
>  (1) allow omission of branch-point if the current branch has
>      allowbranchbydefault configuration set as in above.  A new
>      branch is created forking off of the current HEAD;
> 
>  (2) allow omission of branch-point if no branch has such
>      configuration; in other words, existing repositories that
>      do not have the allowbranchbydefault configuration anywhere
>      are not affected.  A new branch is created forking off of
>      the current HEAD;
> 
>  (3) otherwise, it barfs if you do not give an explicit
>      branch-point.
> 
> and a newly created repository that is newbie friendly has one
> such configuration automatically set for 'master' (if created
> with git-init) or whatever the primary branch is (if created
> with git-clone).

That makes the default behavior more complicated to explain.  Is there
really sufficient evidence that this a serious problem?

