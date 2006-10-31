X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Allow '-' in config variable names
Date: Tue, 31 Oct 2006 10:49:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0610311047250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
 <7vodrtv2wy.fsf@assigned-by-dhcp.cox.net> <7vfyd5rxvg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 31 Oct 2006 09:50:15 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfyd5rxvg.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30576>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeqG0-0002vK-PO for gcvg-git@gmane.org; Tue, 31 Oct
 2006 10:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423037AbWJaJt6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 04:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423045AbWJaJt6
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 04:49:58 -0500
Received: from mail.gmx.de ([213.165.64.20]:8603 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1423037AbWJaJt5 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 04:49:57 -0500
Received: (qmail invoked by alias); 31 Oct 2006 09:49:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 31 Oct 2006 10:49:55 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 30 Oct 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> > Linus Torvalds <torvalds@osdl.org> writes:
> >
> >> I need this in order to allow aliases of the same form as "ls-tree", 
> >> "rev-parse" etc, so that I can use
> >>
> >> 	[alias]
> >> 		my-cat=--paginate cat-file -p
> >>
> >> to add a "git my-cat" command.
> >
> Seconds?

I personally dislike any name with "_" or "-" in it, since I am stuck with 
different keyboard layouts and keep mistyping them. I even often find 
myself hitting <TAB> just to complete a _single_ "-", since the position 
of the <TAB> key is not wildly jumping around between different keyboard 
layouts.

So I can live without it.

Ciao,
Dscho
