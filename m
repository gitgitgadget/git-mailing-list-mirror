From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 21:46:42 -0500
Message-ID: <BAYC1-PASMTP1298D73139F4BE57D59B97AE260@CEZ.ICE>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112201646.GA3179@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 03:51:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExF20-0004fM-6c
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 03:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161450AbWAMCvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 21:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161455AbWAMCvH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 21:51:07 -0500
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:52655 "EHLO
	BAYC1-PASMTP12.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1161450AbWAMCvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 21:51:05 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP12.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 18:53:29 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 7D3AA644C23;
	Thu, 12 Jan 2006 21:51:03 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Message-Id: <20060112214642.3c88282c.seanlkml@sympatico.ca>
In-Reply-To: <20060112201646.GA3179@steel.home>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 02:53:29.0531 (UTC) FILETIME=[886EA0B0:01C617EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Jan 2006 21:16:46 +0100
Alex Riesen <raa.lkml@gmail.com> wrote:

> > Use the author name and email information given as the 
> > first line of the commit message in the form of:
> > 
> > From: name <email>
> > 
> Isn't this what git-am expect (as a part of mbox) and handle?
> 

Hi Alex,

Yes it is, but not everyone is processing patches in mbox format.   If 
this facility is good enough for the mbox users, it seems like it would
be good enough for non-mbox users.   In fact, it would seem more
consistent to tell someone that a From: line will be handled properly
whether they use git-am or git-commit. 

Sean
