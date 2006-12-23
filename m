From: Nicolas Pitre <nico@cam.org>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 00:29:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612230028360.18171@xanadu.home>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
 <20061223051210.GA29814@segfault.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:30:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxzSL-00053x-MA
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbWLWF37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbWLWF37
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:29:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:56031 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbWLWF36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:29:58 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAP00G2TOLXLCD1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 23 Dec 2006 00:29:57 -0500 (EST)
In-reply-to: <20061223051210.GA29814@segfault.peff.net>
X-X-Sender: nico@xanadu.home
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35270>

On Sat, 23 Dec 2006, Jeff King wrote:

> BTW, is there some explanation why branch.*.merge specifies a _remote_
> head? The following would make much more sense to me:
> 
> [branch "master"]
> remote = origin
> merge = refs/remotes/origin/master
> 
> Because I don't _care_ that the other guy calls it refs/heads/master. I
> care that I'm pulling from refs/remotes/origin/master on my end (and
> however I get stuff into that branch is defined by the remote).

Exactly the point I'm trying to make !

I'm glad I'm not alone to come to this conclusion.


Nicolas
