From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Controversial blob munging series
Date: Mon, 23 Apr 2007 15:50:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231540580.8822@racer.site>
References: <11772221041630-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 15:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfywQ-0004Iy-RJ
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 15:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbXDWNuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 09:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbXDWNuw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 09:50:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:39268 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751690AbXDWNuu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 09:50:50 -0400
Received: (qmail invoked by alias); 23 Apr 2007 13:50:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 23 Apr 2007 15:50:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19c/HN7rFNcTLMUlGWTu7KwED7g13UCcJXG4LcHI4
	f7jwbgEItKT9qx
X-X-Sender: gene099@racer.site
In-Reply-To: <11772221041630-git-send-email-junkio@cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45322>

Hi,

On Sat, 21 Apr 2007, Junio C Hamano wrote:

> This is on top of 'next' I'll push out after I am done with
> v1.5.1.2 I am preparing today.
> 
> [1/2] Add 'filter' attribute and external filter driver definition.
> [2/2] Add 'ident' conversion.

I think this is great work! And it is useful, too. Let me describe a usage 
scenario I have in mind.

Being stuck with Pine, which still does not do Maildir, and wanting 
to be able to read my mails as distributed as I am working on documents 
and software projects, I always dreamt of having all my mail in Git.

With filters, it should be relatively easy to do that. Before checking in, 
the individual mailbox files are split, the contents are put into the 
object database, and the mailbox file is replaced by a text file 
consisting of the SHA1s of the mails.

Ideally, I would eventually not only teach Pine to understand Maildir 
format, but read and store the mails in a Git backend. Alas, I am way too 
lazy for that.

So, with filters I'd do the cheap and easy thing.

You may not be able to appreciate the advantages of my scenario, but this 
kind of flexibility is what makes Git so useful.

Ciao,
Dscho
