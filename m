X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Enable reflogs by default in any repository with a working directory.
Date: Thu, 14 Dec 2006 18:42:53 -0500
Message-ID: <20061214234253.GD5147@fieldses.org>
References: <7v1wn243mu.fsf@assigned-by-dhcp.cox.net> <20061214224117.GA26374@spearce.org> <20061214231038.GC5147@fieldses.org> <20061214231832.GF26202@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 23:43:06 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061214231832.GF26202@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34441>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0EC-0003Bs-Jy for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751997AbWLNXm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbWLNXm5
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:42:57 -0500
Received: from mail.fieldses.org ([66.93.2.214]:49160 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751997AbWLNXmz (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:42:55 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gv0E1-0002mJ-8z; Thu, 14 Dec 2006
 18:42:53 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, Dec 14, 2006 at 06:18:32PM -0500, Shawn Pearce wrote:
> "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > Stupid question--I assume a mention in the reflog doesn't count as a
> > real reference to an object, so they won't save you in the case when you
> > pruned recently?
> 
> Not a stupid question.  Your assumption is correct, its not a real
> reference, so prune will remove things that the log mentions but
> that refs don't currently mention.

OK, thanks.  So we just need to make sure that's documented someplace.

