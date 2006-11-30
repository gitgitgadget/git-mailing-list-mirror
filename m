X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 03:11:20 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611300310520.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net>
 <871wnnwi3k.wl%cworth@cworth.org> <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home> <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
 <87ejrlvn7r.wl%cworth@cworth.org> <7vodqpn3t4.fsf@assigned-by-dhcp.cox.net>
 <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 02:11:39 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk61dn2yj.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32696>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpbOX-0002vg-Ry for gcvg-git@gmane.org; Thu, 30 Nov
 2006 03:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936039AbWK3CLX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 21:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936075AbWK3CLW
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 21:11:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:42453 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936039AbWK3CLW (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 21:11:22 -0500
Received: (qmail invoked by alias); 30 Nov 2006 02:11:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 30 Nov 2006 03:11:20 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 29 Nov 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > ...  Rather,
> > "building your next commit incrementally in the index is the
> > workflow git is designed to support, but you are not required to
> > do that _incrementally_.  Until you encounter a complex
> > situation such as resolving a large conflicting merge, doing
> > that incrementally does not buy you anything as long as you work
> > in a clean working tree.
> 
> Side note.  I think the above "Until..." is an overstatement,
> and maybe the readers of the tutorial can be taught a lot
> earlier how the index can help them.  Maybe the following
> sequence can be added to an early part of the tutorial sequence?
> 
>  $ edit hello.c
>  $ make test
>  $ git diff
>  $ git update-index hello.c; # ok, that is good so far.
>  $ edit hello.c; # hack more
>  $ make test; # oops, does not work
>  $ git diff; # ah, that overeager edit broken what was good
>  $ git checkout hello.c; # get the last good one back

I like it. Sort of a "temporary commit" to check against.

Ciao,
Dscho
