From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Unclear error message in "git remote update"
Date: Sun, 9 Mar 2008 21:52:32 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803092152150.3975@racer.site>
References: <2008-03-09-13-37-55+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Sun Mar 09 21:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYSW8-0005S0-B6
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 21:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYCIUwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 16:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbYCIUwa
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 16:52:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:37604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753070AbYCIUwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 16:52:30 -0400
Received: (qmail invoked by alias); 09 Mar 2008 20:52:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO [192.168.1.89]) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 09 Mar 2008 21:52:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19M7VFnWyZMdYGoUfMKr8w97/0EY0uMec+swpjE0b
	3lrvyKbcXb8mxy
X-X-Sender: gene099@racer.site
In-Reply-To: <2008-03-09-13-37-55+trackit+sam@rfc1149.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76670>

Hi,

On Sun, 9 Mar 2008, Samuel Tardieu wrote:

> One of my colleague seems to have destroyed one of its head in his
> private repository. When fetching from it through "git remote update"
> using next, the repository name is not output:
> 
> % git remote update
> error: refs/heads/2.0-uobjects points nowhere!
> 
> Using master, I get:
> 
> % git remote update
> Updating core
> Updating matthieu
> error: refs/heads/2.0-uobjects points nowhere!
> Updating origin
> 
> which is IMO much clearer. Also, I like seeing what remote repository
> it is updating from in case anything gets stuck or slow.
> 
> Any objection to reinstating the message as does the following patch?

None from me.

Thanks,
Dscho
