X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Wed, 13 Dec 2006 21:31:13 +0100
Message-ID: <200612132131.15081.Josef.Weidendorfer@gmx.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com> <200612130415.59038.Josef.Weidendorfer@gmx.de> <7v1wn4mk9i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 01:23:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <7v1wn4mk9i.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34273>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GufJw-0005cy-6i for gcvg-git@gmane.org; Thu, 14 Dec
 2006 02:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751933AbWLNBXY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 20:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWLNBXY
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 20:23:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:36274 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751933AbWLNBXX
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 20:23:23 -0500
Received: (qmail invoked by alias); 14 Dec 2006 01:23:21 -0000
Received: from p5496A4D6.dip0.t-ipconnect.de (EHLO noname) [84.150.164.214]
 by mail.gmx.net (mp018) with SMTP; 14 Dec 2006 02:23:21 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wednesday 13 December 2006 06:34, Junio C Hamano wrote:
> >> > Just as a sidenote: after deciding to not apply hunks, you
> >> > lose them in this WIP, as you will find nothing in "unstaged" mode
> >> > afterwards :-(
> >> 
> >> I do not understand this part.  You can 'revert' to match the
> >> index to HEAD and run 'patch' to pick what you want again.
> >
> > I lost my changes in the working directory; there was nothing to
> > pick again any more.
> 
> That's worrysome.  By design, "git add" should not touch working
> tree at all (only read from there), so if you find cases that
> violates it that should be fixed; please let me know.

I just tried to reproduce the failure with exact the same hunk I used
the first time. I wasn't able to get any wrong result.
So perhaps I did something wrong the first time.

However, if I see something suspect, I will tell you ;-)

Thanks,
