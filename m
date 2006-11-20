X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 18:25:07 -0500
Message-ID: <20061120232507.GH12285@fieldses.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 23:25:29 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31956>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmIVq-0001Im-5H for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030434AbWKTXZN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWKTXZN
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:25:13 -0500
Received: from mail.fieldses.org ([66.93.2.214]:57007 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1030434AbWKTXZM
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:25:12 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GmIVf-0006so-UW; Mon, 20 Nov 2006
 18:25:07 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Mon, Nov 20, 2006 at 03:05:47PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 20 Nov 2006, Junio C Hamano wrote:
> > 
> > That was shot down by Linus and I agree with him.  "bind" was a
> > bad idea because binding of a particular subproject commit into
> > a tree is a property of the tree, not one of the commits that
> > happen to have that tree.
> 
> Yes. I think it would be a _fine_ idea to have a new tree-entry type that 
> points to a sub-commit, but it really does need to be on a "tree level", 
> not a commit level.

Would it also be possible to allow the "Tree:" line in the commit object
to refer to a commit, or does the root of the project need to be a
special case?

