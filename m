X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Stop telling users we are 'defaulting to local storage
 area'.
Date: Thu, 14 Dec 2006 21:43:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612142141420.18171@xanadu.home>
References: <20061214230902.GA26506@spearce.org>
 <Pine.LNX.4.64.0612142059301.18171@xanadu.home>
 <20061215022543.GL26202@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 02:43:22 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061215022543.GL26202@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34465>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv32a-0004VV-Cw for gcvg-git@gmane.org; Fri, 15 Dec
 2006 03:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965052AbWLOCnN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 21:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbWLOCnN
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 21:43:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:11255 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965052AbWLOCnM (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 21:43:12 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAA00CTGNJX3LD0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 21:43:11 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > On Thu, 14 Dec 2006, Shawn O. Pearce wrote:
> > > It also breaks from our normal behavior of not printing
> > > anything if the command was successful.
> 
> > I really don't think this is a good rule.
> > 
> > NOte that I'm not against commands that are silent by default.  I really 
> > think that git-add should remain silent on success by default when 
> > successful.
> > 
> > But the rule of thumb should be about the importance of the action 
> > performed by the command.
> > But git-init-db is really important.  
> 
> A very reasonable argument, butchered for my evil quoting needs.  :-)
> 
> If we want to keep letting git-init-db output something, then
> the output should be a lot more meaningful to the average English
> speaking new Git user than "defaulting to local storage area".

Absolutely!

> BTW, I almost also submitted a patch to remove the "Committing
> initial tree ..." message in git-commit-tree, but thought twice about
> it as committing an initial tree is sort of an important difference
> from normal activity that we should highlight it somehow...

Please ignore that one.  I'm working on a patch to handle the commit 
case (need to update the tutorial accordingly).


