X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 23:25:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611302324370.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611291859070.3513@woody.osdl.org> <456EBBE7.8030404@op5.se>
 <Pine.LNX.4.64.0611300749560.3513@woody.osdl.org> <20061130164046.GB17715@thunk.org>
 <Pine.LNX.4.64.0611300903080.3513@woody.osdl.org> <Pine.LNX.4.64.0611301229290.9647@xanadu.home>
 <87irgwu6e6.wl%cworth@cworth.org> <87hcwgu5t1.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611301132350.3513@woody.osdl.org> <Pine.LNX.4.64.0611301521320.9647@xanadu.home>
 <Pine.LNX.4.64.0611301253380.3513@woody.osdl.org> <eknhjr$nce$1@sea.gmane.org>
 <878xhsty3t.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:26:24 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <878xhsty3t.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32815>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuLs-0005Wq-NC for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031567AbWK3WZz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031568AbWK3WZz
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:25:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:8136 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031567AbWK3WZy (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:25:54 -0500
Received: (qmail invoked by alias); 30 Nov 2006 22:25:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp034) with SMTP; 30 Nov 2006 23:25:52 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Carl Worth wrote:

> It might even make sense to invent one more name for the case where
> the user wants to inform git that a file has been edited and that git
> should accept the new contents. It's the sort of "note that file is
> edited" operation that could be recommended to the user with "add; fix
> typo; commit" confusion.

I suggest "commit". How about this: after editing the file, you tell git 
that you finished editing it by doing

	git commit the-edited-file.txt

Hmmm?

Ciao,
Dscho
