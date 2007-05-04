From: Nicolas Pitre <nico@cam.org>
Subject: Re: FFmpeg considering GIT
Date: Fri, 04 May 2007 12:40:23 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705041232060.24220@xanadu.home>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503180016.GB21333@informatik.uni-freiburg.de>
 <20070503200013.GG4489@pasky.or.cz> <loom.20070504T143538-533@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Michael Niedermayer <michaelni@gmx.at>
X-From: git-owner@vger.kernel.org Fri May 04 18:40:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk0pe-0000qd-D0
	for gcvg-git@gmane.org; Fri, 04 May 2007 18:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031370AbXEDQkb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 12:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031379AbXEDQkb
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 12:40:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51927 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031370AbXEDQka (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 12:40:30 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHI004V6ZNBDWD0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 04 May 2007 12:40:23 -0400 (EDT)
In-reply-to: <loom.20070504T143538-533@post.gmane.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46189>

On Fri, 4 May 2007, Michael Niedermayer wrote:

> well, my example above was exagerated, noone ever reindented the whole
> ffmpeg or checked in a old version over HEAD. what did and does occasionally
> happen is that people check in several things at once (like a 100k reindenton
> mixed with various functional changes)
> for these we currently copy the last good version of the affected files
> over the current one with svn cp and then apply the changes in nicely
> split manner. (possibly without the reindention if its uneeded ...)
> Another thing that happens occasionally is that complete nonsense is checked
> in like checking in the wrong file or some "private" debuging code
> 
> we never use the svn cp method to revert normal buggy code ...

A big difference between git and svn is that git allows you to commit 
your changes individually to your local repository before pushing them 
out to the world.  With svn you make your changes visible to the world 
as soon as you commit something, including the commit screwups.

With Git you always have the opportunity to look at your commits and 
test them all together before pushing which should make commit mistakes 
obvious before they leave your machine.  If a mistake happened in one of 
those commits you can ammend them, rebase them, etc. and only push when 
they're satisfactory, something that svn doesn't allow.

So I think that something that you got used to with svn simply has no 
serious need for with git.


Nicolas
