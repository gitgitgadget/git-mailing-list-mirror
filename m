X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 21:01:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611292059480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
 <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611291234350.9647@xanadu.home> <7vzmaaozi8.fsf@assigned-by-dhcp.cox.net>
 <456DDADC.7030509@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 20:27:39 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <456DDADC.7030509@midwinter.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32663>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpW1i-0004rq-Qv for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967632AbWK2U1R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967641AbWK2U1R
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:27:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:13728 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967632AbWK2U1Q (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:27:16 -0500
Received: (qmail invoked by alias); 29 Nov 2006 20:01:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 29 Nov 2006 21:01:12 +0100
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Steven Grimm wrote:

> Junio C Hamano wrote:
> > After they learn what it means and get used to using it, they
> > will start wondering why we do not default to "-a".
> 
> More likely they will start wondering the instant you tell them to use 
> it the first time. Or at least they'll ask, "If '-a' means commit all 
> files, what's the default?" And then you either have to blow off the 
> question or start telling them about the index.

So what? Tell them that there is a staging area, which makes many 
operations of git very powerful and fast. And this staging area is called 
"the index" in git. And to put some files into it, specify those 
files. If you want _all_ modified files there, use "-a". That's it.

Ciao,
Dscho
