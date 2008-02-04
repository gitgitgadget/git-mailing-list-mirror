From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Mon, 4 Feb 2008 17:21:23 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041714560.7372@racer.site>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>  <alpine.LSU.1.00.0802041512140.7372@racer.site> <e1dab3980802040724l5ef12528y69f1d572b7ac8d54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gi mailing list <git@vger.kernel.org>, Nicolas Pitre <nico@cam.org>
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:23:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM51h-0004o8-3g
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbYBDRWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbYBDRWD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:22:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:37049 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753877AbYBDRWB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:22:01 -0500
Received: (qmail invoked by alias); 04 Feb 2008 17:21:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 04 Feb 2008 18:21:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IfKZTQqrIqDuzi5yPnAbfRQL9TrTC7sMggLJ838
	j55CbFautfg1iG
X-X-Sender: gene099@racer.site
In-Reply-To: <e1dab3980802040724l5ef12528y69f1d572b7ac8d54@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72528>

Hi,

On Mon, 4 Feb 2008, David Tweed wrote:

> In response to this and to Nico's earlier mail, I _think_ the usage with 
> repack is completely safe.

It would have been nicer of you to defend that, instead of sending me off 
to look for myself.  Having looked for myself, I am not convinced at all.

And it would have been surprising: if your patch would play nicely with a 
repack in progress, then it would fail to remove the temporary packs left 
by a crashed repack.

Ciao,
Dscho
