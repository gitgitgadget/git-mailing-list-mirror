From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: "git pull . <branch>" versus "git merge <branch>"
Date: Wed, 11 Jun 2008 13:56:41 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806111340570.19665@iabervon.org>
References: <484F2174.9020508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Rene Herman <rene.herman@keyaccess.nl>
X-From: git-owner@vger.kernel.org Wed Jun 11 19:57:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6UZn-0003Hw-5b
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 19:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765130AbYFKR4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 13:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764254AbYFKR4o
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 13:56:44 -0400
Received: from iabervon.org ([66.92.72.58]:37251 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbYFKR4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 13:56:43 -0400
Received: (qmail 4568 invoked by uid 1000); 11 Jun 2008 17:56:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Jun 2008 17:56:41 -0000
In-Reply-To: <484F2174.9020508@keyaccess.nl>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84629>

On Wed, 11 Jun 2008, Rene Herman wrote:

> Good day.
> 
> The manpages seem to be making somewhat of a point of mentioning "git pull .
> <branch>" as the way to merge a local branch into the current one but a simple
> "git merge <branch>" seems to work well. Is there a difference?

Those manpage sections predate the existance of "git merge <branch>". If 
you're not planning to use git before November 2006, there's no reason to 
use the "git pull ." form. They should probably be replaced with more 
helpful examples at this point.

	-Daniel
*This .sig left intentionally blank*
