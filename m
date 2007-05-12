From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/3] Remotes library, take 4
Date: Sat, 12 May 2007 12:27:22 -0700
Message-ID: <7vfy61zvtx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705121137400.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 12 21:27:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxFY-0004DS-EX
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100AbXELT1Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756451AbXELT1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:27:24 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55121 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755684AbXELT1X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:27:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512192724.EBHS26353.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 15:27:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yKTM1W0091kojtg0000000; Sat, 12 May 2007 15:27:22 -0400
In-Reply-To: <Pine.LNX.4.64.0705121137400.18541@iabervon.org> (Daniel
	Barkalow's message of "Sat, 12 May 2007 11:45:48 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47075>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Updated for recent review. If remote section name starts with '/', it is 
> ignored (like in 1.5.0). If a remote section option has no value, it is 
> also ignored (so it doesn't crash, and to be forward-compatible if we 
> introduce a boolean option later).
>
> The struct refspec field and associated variables are spelled "dst".
>
> Part 3 is unchanged.

It cannot be left unchanged as it is affected by the dest stuff.

I'll push out a fixed-up one on 'pu' soonish.  Let's stabilize
this a bit without too many resends.
