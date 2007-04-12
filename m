From: Daniel Barkalow <barkalow@iabervon.org>
Subject: cvsserver and wincvs (cvsgui)
Date: Thu, 12 Apr 2007 18:54:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704121821150.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 00:54:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc8BT-00034y-FW
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 00:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXDLWyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750882AbXDLWyY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 18:54:24 -0400
Received: from iabervon.org ([66.92.72.58]:2537 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbXDLWyY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 18:54:24 -0400
Received: (qmail 31531 invoked by uid 1000); 12 Apr 2007 22:54:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Apr 2007 22:54:22 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44362>

I'm having problems using git-cvsserver to support a wincvs user. It seems 
to be truncating binary files in both directions (e.g., we have a PNG that 
starts, in hex, 89 50 4e 47 0d 0a ..., and it gets truncated between the 
0d and 0a), and it seems to fail up-to-date checks when checking in files 
that are, in fact, up-to-date (and, so far as I can see, haven't been 
modified anywhere else). I haven't tried much with this repository, but at 
least the binary file commit and update worked for me with real cvs.

The user is using WinCvs 1.3.13.2 Beta 13 (Build 2), which seems to be the 
version he could find at the time that would talk to both their local CVS 
server and sourceforge.

The user doesn't have any of these problems talking to a real cvs server.

Anybody got any experience with wincvs and cvsserver, or any idea how 
things could be different between git-cvsserver and real cvs? He's 
presently going to use his own version control and just send us results, 
but it would be nice if this could be magically worked out before we 
started working together closely again in a couple of weeks.

	-Daniel
*This .sig left intentionally blank*
