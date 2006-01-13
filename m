From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 22:58:00 -0500
Message-ID: <BAYC1-PASMTP1281924C5151CEB4DECC7CAE260@CEZ.ICE>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112201646.GA3179@steel.home>
	<BAYC1-PASMTP1298D73139F4BE57D59B97AE260@CEZ.ICE>
	<7vek3chj8j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:02:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExG8w-0001p8-Hx
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWAMECX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMECX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:02:23 -0500
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:28139 "EHLO
	BAYC1-PASMTP12.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S964901AbWAMECX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:02:23 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 20:04:47 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 81081644C23;
	Thu, 12 Jan 2006 23:02:21 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060112225800.411a04c1.seanlkml@sympatico.ca>
In-Reply-To: <7vek3chj8j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 04:04:47.0609 (UTC) FILETIME=[7E5D8690:01C617F6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Jan 2006 19:58:20 -0800
Junio C Hamano <junkio@cox.net> wrote:

> sean <seanlkml@sympatico.ca> writes:
> 
> > ...   In fact, it would seem more
> > consistent to tell someone that a From: line will be handled properly
> > whether they use git-am or git-commit. 
> 
> Yuck.
> 
> Somebody using am/applymbox is not writing that "From: " line
> himself.  The person who writes that "From: " line writes that
> into his MUA when sending a patch --- that is "editing an
> email", so there is a consistency between that activity and use
> of word "From: ".
> 
> The editor for commit message does not have anything to do with
> e-mail.  What you are talking about is not consistency, but
> confusion.
> 

I don't imagine that the person "editing" the commit message is
doing so in this case either, rather copy-n-pasting.  If you're
really dead-set against this method, you should at least consider
adding it as a command line option, because having to set this
via environment variables is a much bigger Yuck.

Sean
