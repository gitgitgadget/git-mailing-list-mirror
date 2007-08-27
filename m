From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [RED] git-init: Cannot setup bare repository
Date: Mon, 27 Aug 2007 09:51:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708270949590.28586@racer.site>
References: <20070826204531.11592.36481.stgit@rover>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Aug 27 10:49:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPaHL-00024r-Nd
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 10:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbXH0Isz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 04:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752163AbXH0Isz
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 04:48:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:34804 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751245AbXH0Isy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 04:48:54 -0400
Received: (qmail invoked by alias); 27 Aug 2007 08:48:53 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp022) with SMTP; 27 Aug 2007 10:48:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188cidAGNw8JgNot0Ol7PwrKKA41VT3D/XH7lvwlB
	JZQpQ7s+h4ZsDt
X-X-Sender: gene099@racer.site
In-Reply-To: <20070826204531.11592.36481.stgit@rover>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56789>

Hi,

On Sun, 26 Aug 2007, Petr Baudis wrote:

> git-init is totally broken wrt. setting up bare repository - it thinks 
> no repository is bare (maybe I could coerce it to think some 
> repositories indeed are bare, but I have my doubts).

You were too busy playing Go, probably, so you missed my patch which tried 
to fix this issue.  Alas, it broke more than it fixed, so it was just 
worked around for git-clone --bare.

I'll have a more thorough go at it today.

Ciao,
Dscho
