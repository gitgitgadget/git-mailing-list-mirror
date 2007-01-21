From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --walk-reflogs: actually find the right commit by date.
Date: Sun, 21 Jan 2007 19:14:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701211913060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701201048560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhcum80u4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701202225020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vhcuk500j.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701211152400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac0c39uw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 19:15:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8hDg-00046b-VT
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 19:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXAUSOw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 13:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbXAUSOw
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 13:14:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:33900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751194AbXAUSOv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 13:14:51 -0500
Received: (qmail invoked by alias); 21 Jan 2007 18:14:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 21 Jan 2007 19:14:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac0c39uw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37333>

Hi,

On Sun, 21 Jan 2007, Junio C Hamano wrote:

> By the way, "git log --walk-reflog master@{now}" seems to give me one 
> non-reflog entry output for me at the end (which is I think the parent 
> of the oldest reflog entry which itself does not have the record of 
> being at the tip of the ref in question).  Other than that I think we 
> are Ok.

Yes, I realized that. It might bear some information, but if you don't 
like it, I can change that.

> Also doesn't --walk-reflog sound too long?

Yes. Suggestions? (--reflog is already taken :-( )

Ciao,
Dscho
