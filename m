X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git blame
Date: Thu, 30 Nov 2006 23:53:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611302350510.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <453F2FF8.2080903@op5.se>
 <200610251146.06116.jnareb@gmail.com> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net>
 <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org> <456D7A76.3080605@webdrake.net>
 <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org> <456F21D6.1060200@webdrake.net>
 <Pine.LNX.4.64.0611301034420.3513@woody.osdl.org> <87d574u2tl.wl%cworth@cworth.org>
 <Pine.LNX.4.63.0611302314320.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64cwh86r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:53:56 +0000 (UTC)
Cc: git@vger.kernel.org,
	Joseph Wakeling <joseph.wakeling@webdrake.net>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v64cwh86r.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32828>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpumb-0001mO-N9 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031614AbWK3Wxb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031615AbWK3Wxb
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:53:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:63369 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031614AbWK3Wxa (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:53:30 -0500
Received: (qmail invoked by alias); 30 Nov 2006 22:53:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 30 Nov 2006 23:53:28 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 30 Nov 2006, Carl Worth wrote:
> >
> >> Here's a crazy idea. How about a "git tutorial" builtin or "git example" 
> >> or something that would create a repository into some useful state for 
> >> demonstrating something.
> >
> > That sounds fine! Actually, it should be very simple to turn the tutorial 
> > into such a script, displaying the command with an explanation, and 
> > executing the command. It could even call gitk from time to time, so the 
> > user can form a mental model of the ancestor graph.
> 
> Doesn't one of our existing t/ scripts do that?

;-) I did not forget... t1200-tutorial.sh

But it serves a different purpose: it makes sure that we did not break the 
commands in the tutorial. (I fear that the script and the tutorial have 
diverged a little bit, though).

git-tutorial should not test that, rather it should show the user what is 
possible, and encourage playing with git.

Ciao,
Dscho
