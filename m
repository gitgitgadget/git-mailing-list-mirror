X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 01:08:03 +0100
Message-ID: <200612170108.04033.Josef.Weidendorfer@gmx.de>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net> <20061216230108.GE12411@admingilde.org> <200612170015.24162.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 00:08:21 +0000 (UTC)
Cc: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.5
In-Reply-To: <200612170015.24162.jnareb@gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34661>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvjZi-0004w6-HU for gcvg-git@gmane.org; Sun, 17 Dec
 2006 01:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422900AbWLQAIP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 19:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422902AbWLQAIP
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 19:08:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:35490 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1422900AbWLQAIP
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 19:08:15 -0500
Received: (qmail invoked by alias); 17 Dec 2006 00:08:13 -0000
Received: from p5496AE8F.dip0.t-ipconnect.de (EHLO noname) [84.150.174.143]
 by mail.gmx.net (mp047) with SMTP; 17 Dec 2006 01:08:13 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sunday 17 December 2006 00:15, Jakub Narebski wrote:
> > I still don't get the advantage of a .gitlink file over an ordinary
> > repository with alternates or a symlink.

Forgot one thing:
To separate the repository files from a checkout, a symlink is not
enough, as you lose the linkage when you move the checkout or the
repository; you could use an absolute symlink target, but that also
has inconveniences.

So you want some kind of smart linking. And this is another
important part of the .gitlink file proposal.

