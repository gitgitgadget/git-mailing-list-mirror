X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 12:47:15 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141245380.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 17:47:42 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061214114546.GI1747@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34377>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuugG-0003Xu-J6 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 18:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751606AbWLNRri (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 12:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWLNRrh
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 12:47:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:64440 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751078AbWLNRrh (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 12:47:37 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA900H1TYQRWT30@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 12:47:15 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> Andy Parkins <andyparkins@gmail.com> wrote:
> > How's this then:
> > 
> > $ git commit
> > $ git commit
> > $ git commit
> > $ git reset HEAD^^^
> > 
> > "AGGGHHHHHH!  I meant HEAD^^"
> > 
> > At this point I start running "git-prune -n | grep commit" and some liberal 
> > use of git-show to try and find the hash of the object so I can do
> 
> At this point I usually try to politely suggest that users do:
> 
>   git repo-config --global core.logAllRefUpdates true
> 

And this is where I politely say that this option should be true by 
default for everybody.

I don't recall why it isn't so yet.


