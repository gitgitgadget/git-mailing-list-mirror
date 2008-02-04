From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] git-commit: Refactor creation of log message.
Date: Mon, 4 Feb 2008 16:48:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041646461.7372@racer.site>
References: <2885c7896ba72adee6bc5c9e2210a8881904f601.head.git.bonzini@gnu.org> <14fc1ba3f94a773ab2e5b8cdf0c230962f32180d.1200933409.git.bonzini@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:50:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM4WF-0000R6-9F
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 17:50:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbYBDQte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 11:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbYBDQte
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 11:49:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:60902 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752111AbYBDQtd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 11:49:33 -0500
Received: (qmail invoked by alias); 04 Feb 2008 16:49:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 04 Feb 2008 17:49:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AQNFD9rgA7Jyr/HGLBAOY+udsM4LmJgJ1OfiBYC
	azQXcXD22qAYYu
X-X-Sender: gene099@racer.site
In-Reply-To: <14fc1ba3f94a773ab2e5b8cdf0c230962f32180d.1200933409.git.bonzini@gnu.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72523>

Hi,

On Mon, 21 Jan 2008, Paolo Bonzini wrote:

> This means that: 1) the commit may be aborted after editing the message
> if there is a problem writing out the tree object (slight disadvantage);

I consider this more than a slight disadvantage.  I regularly take ages 
coming up with a good commit message, because I think that the overall 
time balance is better with me spending more time on the message, but 
every reader spending less time to guess what I meant.

So I would be quite annoyed to edit a message, only to find out that for 
whatever reason the commit was not successful.

Are you _sure_ you need 3/4 for 4/4?

Ciao,
Dscho
