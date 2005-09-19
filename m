From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Newbie falls at first hurdle
Date: Mon, 19 Sep 2005 21:09:47 +0200
Message-ID: <20050919190947.GF15165MdfPADPa@greensroom.kotnet.org>
References: <alan@chandlerfamily.org.uk>
 <200509181347.11403.alan@chandlerfamily.org.uk>
 <7vek7m5m0z.fsf@assigned-by-dhcp.cox.net>
 <200509182011.10689.alan@chandlerfamily.org.uk>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 21:12:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHR1y-0002YV-CD
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 21:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVISTJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 15:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVISTJw
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 15:09:52 -0400
Received: from smtp16.wxs.nl ([195.121.6.39]:40844 "EHLO smtp16.wxs.nl")
	by vger.kernel.org with ESMTP id S932590AbVISTJv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 15:09:51 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN20014LVWBA9@smtp16.wxs.nl> for git@vger.kernel.org; Mon,
 19 Sep 2005 21:09:47 +0200 (CEST)
Received: (qmail 20758 invoked by uid 500); Mon, 19 Sep 2005 19:09:47 +0000
In-reply-to: <200509182011.10689.alan@chandlerfamily.org.uk>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Mail-followup-to: Alan Chandler <alan@chandlerfamily.org.uk>,
 git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8897>

On Sun, Sep 18, 2005 at 08:11:10PM +0100, Alan Chandler wrote:
> What I was then trying to do, via various attempts with git diff -p was to 
> extract small chunks of updates (ie limit scope over a few files).  Edit the 
> result to limit the diff to cover a small update and then apply it to a my 
> current stuff to slowly undo some of the mess that I had made. 

Yoy may find my changes to dirdiff useful if you do things like that.
(http://www.liacs.nl/~sverdool/gitweb.cgi?p=dirdiff.git;a=summary)
I've basically changed it to allow "merging" (i.e., commiting) to a branch.

You'd start it like this

girdiff master .

Then you loop through the files with differences, for each
file selecting the changes you want to copy and selecting
Merge/"update master".
Then you fill in a commit message and select File/Commit
from the commit message window.

Only lightly tested so far.
Rediff'ing doesn't work yet, so you'll have to restart
girdiff after each commit for now.

skimo
