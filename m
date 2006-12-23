From: Nicolas Pitre <nico@cam.org>
Subject: Re: author/commit counts
Date: Sat, 23 Dec 2006 00:06:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612230001590.18171@xanadu.home>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:07:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxz5z-0002ZW-SS
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbWLWFGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbWLWFGl
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:06:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47490 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbWLWFGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:06:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAP0010QNJ3RKS1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 23 Dec 2006 00:06:39 -0500 (EST)
In-reply-to: <20061222181030.d733deb3.rdunlap@xenotime.net>
X-X-Sender: nico@xanadu.home
To: Randy Dunlap <rdunlap@xenotime.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35263>

On Fri, 22 Dec 2006, Randy Dunlap wrote:

> Hi,
> 
> Someone asked me a few days ago about their patches being merged yet
> (e.g., how to see their commits in a git tree).

See the --author=<string> option to git log.

> Someone else asked (in general) about commit or author counts.
> 
> I pointed the first person to "git log" and/or gitweb.
> For the second, there are probably lots of scripts out there
> but I didn't find them.  Where are they?

Try git shortlog -s.  If you combine the two like:

	git log --author=<blah> | git shortlog -s

then you'll have a commit count for <blah> only.


Nicolas
