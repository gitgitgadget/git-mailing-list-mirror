X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 23:55:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611302354060.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <7vac28h898.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:56:16 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, Theodore Tso <tytso@mit.edu>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vac28h898.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32829>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpuoc-00028x-Ds for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031619AbWK3Wzf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031620AbWK3Wzf
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:55:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:9677 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031619AbWK3Wze (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:55:34 -0500
Received: (qmail invoked by alias); 30 Nov 2006 22:55:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 30 Nov 2006 23:55:33 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > ...
> > So yes, you very much ARE talking about CVS braindamage. The reason why
> >
> > 	git add file.c
> > 	echo New line >> file.c
> > 	git commit
> >
> > commits the _old_ content, is very much because git is ALL ABOUT THE 
> > CONTENT. It has _never_ been about filenames. And it _shouldn't_ be about 
> > filenames, because that would be BUGGY AND BROKEN.
> 
> I think this pretty much sums up and closes the current topic,
> by declaring "expecting to give behaviour consistent to the
> 'filename is what the user tells the SCM to track' mental model
> CVS instilled is a lost cause".

I think this is so important, that I vote for including this email as 
Documentation/howto/explain-why-git-is-better-than-cvs.txt

Ciao,
Dscho
