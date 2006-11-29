X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 19:54:36 +0100
Message-ID: <456DD76C.4010902@gmx.net>
References: <45357CC3.4040507@utoronto.ca> <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com> <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com> <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr> <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com> <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org> <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org> <Pine.LNX.4.63.0611291149440.300
 04@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 18:59:00 +0000 (UTC)
Cc: Nicholas Allen <nick.allen@onlinehome.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #420190
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
Original-Newsgroups: gmane.comp.version-control.git,gmane.comp.version-control.bazaar-ng.general
In-Reply-To: <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32657>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpUdp-0004mS-N5 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 19:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967543AbWK2S6m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 13:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967553AbWK2S6m
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 13:58:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:49099 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967543AbWK2S6l (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 13:58:41 -0500
Received: (qmail invoked by alias); 29 Nov 2006 18:58:40 -0000
Received: from BSN-77-244-202.dial-up.dsl.siol.net (EHLO [192.168.2.7])
 [193.77.244.202] by mail.gmx.net (mp032) with SMTP; 29 Nov 2006 19:58:40
 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> So most of the time, when you use git, you can ignore the index. It's 
> really important, and it's used _all_ the time, but you can still mostly 
> ignore it. But when handling a merge conflict, the index is really what 
> sets git apart, and what really helps a LOT.
 
Actually, people (at least me) dislike the index because in the most common
operations (status, diff, commit), they have to know that the command doesn't actually
display all their work but just the 'indexed' part of it. 

For people used to cvs, svn and other systems it would be nicer if diff -a
and commit -a (and possibly other commands) were the default.

index is of course necessary during merging, ... and as a speed optimization
for applying patches when you know the working copy is clean.

