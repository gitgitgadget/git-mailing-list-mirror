From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 9 Dec 2007 14:55:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712091445470.5349@iabervon.org>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home>
 <475C3E25.30704@saville.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 20:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1SGF-0003vX-6v
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 20:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbXLIT4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 14:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbXLIT4A
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 14:56:00 -0500
Received: from iabervon.org ([66.92.72.58]:52878 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629AbXLITz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 14:55:59 -0500
Received: (qmail 29911 invoked by uid 1000); 9 Dec 2007 19:55:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Dec 2007 19:55:58 -0000
In-Reply-To: <475C3E25.30704@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67657>

On Sun, 9 Dec 2007, Wink Saville wrote:

> Another option I was thinking would work for me would be to use
> submodules. But I'm not sure submodules are ready for
> neophytes and maybe it doesn't do what I want?

I think that submodules do what you want. And they may not be ready for 
neophytes to just use, but they're ready for neophytes to try using and 
tell us where things get confused. That is, I don't think git developers 
know of anything still wrong with submodules, so we need people to try 
using them and say "I can't use submodules now because...". Or, of course, 
the code might be fine now and the discussion just too intimidating.

In any case, if you create a new repository, and fetch stuff into it, and 
don't push stuff back, you can't screw up the original (obviously), so it 
should be safe and possibly informative to play around with submodules.

	-Daniel
*This .sig left intentionally blank*
