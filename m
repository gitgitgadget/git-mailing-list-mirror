From: Dirk Koopman <djk@tobit.co.uk>
Subject: Re: [PATCH] cvsserver: fix legacy cvs client and branch rev issues
Date: Sun, 17 Jun 2007 17:53:27 +0100
Message-ID: <46756707.5020805@tobit.co.uk>
References: <11820198064114-git-send-email-djk@tobit.co.uk> <20070617081959.GD1828@planck.djpig.de> <4674FA9B.10806@tobit.co.uk> <20070617103744.GE1828@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Jun 17 18:53:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzy0K-0004LL-BR
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 18:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbXFQQxa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 12:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753560AbXFQQxa
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 12:53:30 -0400
Received: from post.tobit.co.uk ([82.68.205.2]:49546 "EHLO post.tobit.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575AbXFQQxa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 12:53:30 -0400
Received: from dmzgate.tobit.co.uk ([82.68.205.1] helo=[192.168.1.15])
	by post.tobit.co.uk with esmtp (Exim 4.60)
	(envelope-from <djk@tobit.co.uk>)
	id 1Hzy0G-0001Yx-2q; Sun, 17 Jun 2007 17:53:28 +0100
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20070617103744.GE1828@planck.djpig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50359>

Frank Lichtenheld wrote:

> 
> Summary: You're (ab)using cvsserver in very interesting ways that are not
> really beeing thought of in the current design/implementation. There'll
> be dragons ;)
> 

Hmm... I think that is becoming clear. The trouble is that I am not at 
all certain that what I am doing is particularly unusual. After all, 
using git, the whole point is that working on branches or the main line 
should easy and cheap!

If it were me, I might have been inclined to always set Repository to 
'master' (or even to the name of the repository with .git removed), then 
git checkout <tag> <file> each file, one at a time, using the (<tag> || 
'master') from each Entry that is sent. So with no tag, you get the 
master copy, otherwise the <tag>ged copy - this all assuming that the 
git repo is set up correctly.

But as I am CVS read only, what is there does for me so I am not 
complaining :-) The two people that can also commit can start to use git 
and send me patches... Do them good :-)

Dirk
