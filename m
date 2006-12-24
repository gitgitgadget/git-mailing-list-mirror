From: Nicolas Pitre <nico@cam.org>
Subject: Re: confusion over the new branch and merge config
Date: Sun, 24 Dec 2006 15:49:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612241544250.18171@xanadu.home>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
 <7vd56cam66.fsf@assigned-by-dhcp.cox.net>
 <20061223051210.GA29814@segfault.peff.net>
 <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
 <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 21:50:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyaIU-0002SO-Ed
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 21:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbWLXUtw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 15:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbWLXUtw
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 15:49:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27144 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbWLXUtv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 15:49:51 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAS00GBWPV2K2J2@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 24 Dec 2006 15:49:50 -0500 (EST)
In-reply-to: <7vbqlvrldk.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35374>

On Sat, 23 Dec 2006, Junio C Hamano wrote:

> If you (or other people) use branch.*.merge, with its value set
> to remote name _and_ local name, and actually verify that either
> form works without confusion, please report back and I'll apply.

This is nice, thanks.

What would be nice as well is to be able to provide only the _name_ of 
the tracking branch without the refs/remotes/$origin/ prefix.  Since 
there is already a 'branch."blah".remote = $origin' entry, then having 
'branch."blah".merge = $foo' could mean "refs/remotes/$origin/$foo" when 
$foo contains no slash.


Nicolas
