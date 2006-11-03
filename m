X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Colourise git-branch output
Date: Sat, 4 Nov 2006 00:05:24 +0100
Message-ID: <20061103230524.GA4429@steel.home>
References: <200611031052.16095.andyparkins@gmail.com> <200611031206.12515.andyparkins@gmail.com> <7v3b908h88.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 23:06:02 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b908h88.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-ID: Z6K114ZXwe0Pj+IsY0cEnkuKQevsw2--KfZ-oWRwktgQtMmzN0I4kj
X-TOI-MSGID: d6ce85d8-8427-4449-b4dc-eca19fc2d375
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30894>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg86l-0006Le-1m for gcvg-git@gmane.org; Sat, 04 Nov
 2006 00:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932486AbWKCXFw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 18:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWKCXFw
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 18:05:52 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:57007 "EHLO
 mailout08.sul.t-online.com") by vger.kernel.org with ESMTP id S932486AbWKCXFv
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 18:05:51 -0500
Received: from fwd26.aul.t-online.de  by mailout08.sul.t-online.com with smtp
  id 1Gg86O-0002tQ-01; Sat, 04 Nov 2006 00:05:32 +0100
Received: from tigra.home
 (Z6K114ZXwe0Pj+IsY0cEnkuKQevsw2--KfZ-oWRwktgQtMmzN0I4kj@[84.163.78.84]) by
 fwd26.sul.t-online.de with esmtp id 1Gg86H-1eUI9Q0; Sat, 4 Nov 2006 00:05:25
 +0100
Received: from steel.home (steel.home [192.168.1.2]) by tigra.home (Postfix)
 with ESMTP id 2D5C0277AF; Sat,  4 Nov 2006 00:05:25 +0100 (CET)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian)) id
 1Gg86G-0007hD-66; Sat, 04 Nov 2006 00:05:24 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano, Fri, Nov 03, 2006 20:25:59 +0100:
> > I wanted to have a visual indication of which branches are
> > local and which are remote in git-branch -a output; however
> > Junio was concerned that someone might be using the output in
> > a script.  This patch addresses the problem by colouring the
> > git-branch output - which in "auto" mode won't be activated.
> 
> Yuck.  We are getting more and more color happy.  As long as
> this stays optional I'm Ok with it; we'll see if people find it
> useful soon enough.
> 

As long as the output stays stable one can always colorize it with
an external program, using pseudo terminals, if needed. Wont work
for the other platform though. As usual.
