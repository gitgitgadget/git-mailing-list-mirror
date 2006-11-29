X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 00:53:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611300050180.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
 <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 23:58:20 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87ejrlvn7r.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32680>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpZJd-00052h-Ap for gcvg-git@gmane.org; Thu, 30 Nov
 2006 00:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967685AbWK2X6K (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 18:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967686AbWK2X6J
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 18:58:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:20962 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S967685AbWK2X6G (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 18:58:06 -0500
Received: (qmail invoked by alias); 29 Nov 2006 23:53:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 30 Nov 2006 00:53:10 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Carl Worth wrote:

> [As an aside, the situation of independent changes being mixed in a 
> working tree is not always so lucky as to be cleanly separated into 
> disjoint file sets. When it's not, I have to disentangle them. Now, the 
> index could really help during this operation too, but we would need 
> better tools than update-index which only works on a per-file basis. 
> Something that let me easily select chunks of the patch would be really 
> nice.]

I regularly do something like

	$ git diff [file] > a1.patch
	$ vi a1.patch
	  [edit out the chunks I want to commit]
	$ git apply -R < a1.patch
	$ git commit [file]
	$ git apply < a1.patch

Seems a little bit convoluted, but works...

Hth,
Dscho
