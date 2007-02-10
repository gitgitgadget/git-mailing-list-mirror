From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 13:51:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702101329320.1757@xanadu.home>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
 <Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702101049480.1757@xanadu.home>
 <7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702101131070.1757@xanadu.home>
 <Pine.LNX.4.64.0702100913020.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 10 19:51:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFxJa-0006mI-Hn
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 19:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbXBJSvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 13:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbXBJSvK
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 13:51:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30987 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbXBJSvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 13:51:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD900FPIGD8RY00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Feb 2007 13:51:08 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702100913020.8424@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39252>

On Sat, 10 Feb 2007, Linus Torvalds wrote:

> It is *not* a read-only operation. The index is too important to be 
> considered "just a technical issue". 

There is just a semantic issue that you seem to overlook completely.

According to the dictionarry, "status" is a synonym to a "state".  It is 
_not_ an action.

So, from a _user_ perspective, the git-status command should give back a 
"status".  Of _course_ the user will benefit from the index updating 
business, but as important as this update might be (and I do agree that 
it is fundamental for GIT's performance), this is still a by-product of 
the "status" command.

Therefore, the fact that the index isn't writable should not prevent 
git-status from providing the very result for which its name was chosen.  
The index might as well be brought up to date on disk the next time the 
file system is writable.


Nicolas
