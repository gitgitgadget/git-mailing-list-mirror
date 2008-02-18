From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for
 format-patch
Date: Mon, 18 Feb 2008 18:00:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181759280.30505@racer.site>
References: <alpine.LNX.1.00.0802171335240.5816@iabervon.org> <alpine.LSU.1.00.0802181238280.30505@racer.site> <alpine.LNX.1.00.0802181229340.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:01:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRAIo-0006xL-Tj
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 19:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbYBRSAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 13:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbYBRSAh
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 13:00:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:59462 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750948AbYBRSAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 13:00:36 -0500
Received: (qmail invoked by alias); 18 Feb 2008 18:00:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 18 Feb 2008 19:00:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/K9TdwCdzKVaMGvep/fceRHBIjwjhZxTo7vKfqYw
	eh7l9MJ59M2gan
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802181229340.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74324>

Hi,

On Mon, 18 Feb 2008, Daniel Barkalow wrote:

> It's sort of like that, in that this *is* the caller,

Sorry, I should have been clearer.  It is all too easy to forget that 
reasoning and use rev_info->message_id in a different way, and then mix 
the code paths.

Ciao,
Dscho
