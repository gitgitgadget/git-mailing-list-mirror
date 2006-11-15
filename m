X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 17:28:34 -0500
Message-ID: <BAYC1-PASMTP117DBD278A79F6239D9DA1AEEA0@CEZ.ICE>
References: <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151315291.2591@xanadu.home>
	<20061115184914.GA24122@spearce.org>
	<455B64F7.9040506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 22:29:08 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	cworth@cworth.org, pasky@suse.cz
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061115172834.0a328154.seanlkml@sympatico.ca>
In-Reply-To: <455B64F7.9040506@gmx.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 15 Nov 2006 22:38:07.0656 (UTC) FILETIME=[B8B34A80:01C70906]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTFJ-000705-2t for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162005AbWKOW2i (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162006AbWKOW2i
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:28:38 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:14646 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1162005AbWKOW2h
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:28:37 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Wed, 15 Nov
 2006 14:38:07 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GkSJ8-0004xL-Bx; Wed, 15 Nov 2006 16:28:34 -0500
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006 20:05:27 +0100
Marko Macek <marko.macek@gmx.net> wrote:

> I guess this is the reason that the GIT Tutorial for CVS/SVN users is talking about _cogito_ instead.
> (which is very confusing for someone coming to _git_ home page, trying to learn git).

IMHO this is really bad.  Pasky runs the Git web site and feels
that Cogito comes hand in hand with Git.  When I asked him about
it he mentioned that Junio had approved.  But it's very confusing
to click a link that purports to show you how to use Git and get
shown a bunch of Cogito stuff.

Git is confusing enough for new users without "Git" and "Cogito"
being mixed without comment on the Git webpage.  At the very
least, the links should be changed to "Cogito for CVS/SVN users".

