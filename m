From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Clean up connection correctly if object fetch wasn't
 done
Date: Mon, 4 Feb 2008 20:23:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802042023160.8543@racer.site>
References: <alpine.LNX.1.00.0802041326260.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 21:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM7sQ-0003Vh-5j
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 21:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758505AbYBDUYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 15:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758468AbYBDUYf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 15:24:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:38825 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758313AbYBDUYd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 15:24:33 -0500
Received: (qmail invoked by alias); 04 Feb 2008 20:24:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 04 Feb 2008 21:24:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/591cQqsn5q0r0XNyRYF2XFotnuW+hFuVhBQ4yi7
	zY9MASr+mmoJZP
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802041326260.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72556>

Hi,

On Mon, 4 Feb 2008, Daniel Barkalow wrote:

> Further optimization allowed the fetch_objs call to be skipped if it 
> isn't necessary. However, this leaves the connection in need of cleaning 
> up to avoid getting an error message from the remote end when ssh is 
> used. Fix this.

I _think_ something similar is necessary for ls-remote, too (at least it 
showed the same symptoms today, but I have not had time to investigate 
yet).

Ciao,
Dscho
