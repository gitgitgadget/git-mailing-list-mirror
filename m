From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] series headers
Date: Tue, 10 Jul 2007 16:23:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101617520.4047@racer.site>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
 <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net> <20070710132401.GJ2343@thunk.org>
 <Pine.LNX.4.64.0707101452250.4047@racer.site> <20070710144808.GA27033@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 10 17:31:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8HgG-0003HY-RX
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 17:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbXGJPax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 11:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754543AbXGJPax
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 11:30:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:38778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754563AbXGJPaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 11:30:52 -0400
Received: (qmail invoked by alias); 10 Jul 2007 15:30:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 10 Jul 2007 17:30:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/x0at/kXvxHTjvSK9ZFxNLxnC69VStrA2WmWg1jY
	PV9/YExDtlp12y
X-X-Sender: gene099@racer.site
In-Reply-To: <20070710144808.GA27033@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52084>

Hi,

On Tue, 10 Jul 2007, Theodore Tso wrote:

> On Tue, Jul 10, 2007 at 02:56:48PM +0100, Johannes Schindelin wrote:
> > And what is so wrong with
> > 
> > [insert before format-patch] $EDITOR my-cover-letter.txt
> > 
> > [replace $EDITOR 0000-cover-letter.txt] $EDITOR my-cover-letter.txt 
> > 	0000-cover-letter.patch
> > 
> > and paste the changed text?
> 
> Nothing is *wrong* with it per-se, but if you have multiple things that 
> you are working on at the same-time, you might not want to keep 
> 0000-cover-letter.patch in your working directory.

Ah, but then maybe you want to be able to say

	git format-patch --cover-letter=<my-cover-letter> [...]

Where your cover-letter file looks something like this:

	My patch series which will rule the world

	Here is the body, and I explain what the world should look like,
	and that they should accept me as the chosen one president of the
	united geekheads of this world.

IOW the file contents to produce what is produced with my patch would look 
like this:

	*** SUBJECT HERE ***

	*** BLURB HERE ***
Ciao,
Dscho
