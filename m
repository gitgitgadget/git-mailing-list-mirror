X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] xdl_merge(): fix and simplify conflict handling
Date: Tue, 5 Dec 2006 23:24:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612052320320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk> <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
 <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac22glzz.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612052209030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvekqf0yh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 22:24:51 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvekqf0yh.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33378>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GriiV-0006el-KY for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936182AbWLEWYo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936571AbWLEWYo
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:24:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:50370 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S936182AbWLEWYn
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 17:24:43 -0500
Received: (qmail invoked by alias); 05 Dec 2006 22:24:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 05 Dec 2006 23:24:41 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Junio C Hamano wrote:

> Looking at some other cases after applying your patch, I noticed that I 
> really like one thing that your version does over what RCS merge does.

Gee, thanks!

Actually, this was what I intended to do first when somebody submitted a 
builtin merge: Be clever about what is a conflict and what not.

Speaking about a builtin merge: I like the fact that git-apply also works 
outside of git repositories. It makes life easier to have a sane patcher 
around.

Now, I'd like the same with git-diff, and an RCS merge replacement... Of 
course, what with all those porcelainish commands we should not add new 
commands, but enhance existing ones. Any ideas which ones?

Ciao,
Dscho
