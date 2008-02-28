From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git-checkout regression?
Date: Thu, 28 Feb 2008 10:11:10 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281010070.19665@iabervon.org>
References: <87wsop188j.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:11:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkQN-0001hv-3n
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757414AbYB1PLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757411AbYB1PLR
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:11:17 -0500
Received: from iabervon.org ([66.92.72.58]:37041 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756557AbYB1PLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:11:17 -0500
Received: (qmail 1375 invoked by uid 1000); 28 Feb 2008 15:11:10 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 15:11:10 -0000
In-Reply-To: <87wsop188j.fsf@wine.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75405>

On Thu, 28 Feb 2008, Alexandre Julliard wrote:

> Since the rewrite in C, "git checkout HEAD file" no longer updates the
> index entry for file, it needs an extra git-update-index --refresh. Is
> that a deliberate change?

Nope, looks like I forgot to rewrite the index file with the new stat info 
from writing the files. I'll have a patch in a little while...

	-Daniel
*This .sig left intentionally blank*
