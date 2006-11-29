X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 21:07:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611292101420.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net>
 <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
 <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org> <456DD76C.4010902@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 20:07:49 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Nicholas Allen <nick.allen@onlinehome.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <456DD76C.4010902@gmx.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32662>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpViU-0001MH-CR for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936100AbWK2UHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936093AbWK2UHJ
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:07:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:42657 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936099AbWK2UHG (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:07:06 -0500
Received: (qmail invoked by alias); 29 Nov 2006 20:07:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 29 Nov 2006 21:07:04 +0100
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Marko Macek wrote:

> Linus Torvalds wrote:
> > So most of the time, when you use git, you can ignore the index. It's 
> > really important, and it's used _all_ the time, but you can still 
> > mostly ignore it. But when handling a merge conflict, the index is 
> > really what sets git apart, and what really helps a LOT.
> 
> Actually, people (at least me) dislike the index because in the most 
> common operations (status, diff, commit), they have to know that the 
> command doesn't actually display all their work but just the 'indexed' 
> part of it.

No. It does display all your work.

However, as Linus pointed out, if there are automatically merged entries 
without conflicts, it will not display them. Which is sane!

And yes, you can hide some modifications by putting the modified file into 
the index. But then you did that very much on purpose.

> For people used to cvs, svn and other systems it would be nicer if diff 
> -a and commit -a (and possibly other commands) were the default.

And what exactly do you think is happening when "cvs add" and "svn add" 
did _not_ really add the file to the repository, but only a subsequent 
"commit" does?

> index is of course necessary during merging, ... and as a speed 
> optimization for applying patches when you know the working copy is 
> clean.

I think that it is one major achievement of git to make clear and sane 
definitions of branches (which are really just pointers 
into the revision graph), and the index (which is the staging area).

Ciao,
Dscho
