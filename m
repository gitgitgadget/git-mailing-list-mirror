From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] series headers
Date: Tue, 10 Jul 2007 14:56:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707101452250.4047@racer.site>
References: <Pine.LNX.4.64.0707100126250.6977@iabervon.org>
 <7vejjgsq3y.fsf@assigned-by-dhcp.cox.net> <20070710132401.GJ2343@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 10 16:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8GKR-0006X8-5v
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 16:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbXGJOEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 10:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbXGJOEc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 10:04:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:38384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751691AbXGJOEb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 10:04:31 -0400
Received: (qmail invoked by alias); 10 Jul 2007 14:04:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 10 Jul 2007 16:04:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189lZhZcGA9rW5JAOKCbXryXl2/pe5x1POAEj19p5
	FRO3Yhmae8xVX8
X-X-Sender: gene099@racer.site
In-Reply-To: <20070710132401.GJ2343@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52074>

Hi,

On Tue, 10 Jul 2007, Theodore Tso wrote:

> In general a patch series goes through multiple cycles of
> improvements, where people send it out for review/comment, and then it
> gets fixed up, etc. etc.   So you don't want to just do this:
> 
> On Mon, Jul 09, 2007 at 11:57:21PM -0700, Junio C Hamano wrote:
> 
> >  $ work work work, commit commit commit, reorder and perfect
> >  $ git format-patch --with-cover origin..HEAD
> >  ... which notices --with-cover, and perhaps does
> >  ... $ git-shortlog origin..HEAD
> >  ... $ git diff --stat --summary origin..HEAD
> >  ... $ echo "*** BLURB HERE ***"
> >  ... to create 0/N which it did not do so far in
> >  ... 0000-cover-letter.txt
> >  $ $EDITOR 0000-cover-letter.txt
> >  $ git-send-email 0*.txt
> 
> Because you'll be sending out the 0000-cover-letter.txt multiple
> times, refining it (and the patches) as you go along.

And what is so wrong with

[insert before format-patch] $EDITOR my-cover-letter.txt

[replace $EDITOR 0000-cover-letter.txt] $EDITOR my-cover-letter.txt 
	0000-cover-letter.patch

and paste the changed text?

Of course, you can still hand roll something with a commit.  Probably a 
squash merge of your patch series.

Ciao,
Dscho
