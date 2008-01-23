From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 23:48:16 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801232346010.5731@racer.site>
References: <20080123212613.GN2230@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Thu Jan 24 00:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHpKy-0001so-SK
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 00:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYAWXs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 18:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbYAWXs0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 18:48:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:41891 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751691AbYAWXsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 18:48:25 -0500
Received: (qmail invoked by alias); 23 Jan 2008 23:48:23 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp009) with SMTP; 24 Jan 2008 00:48:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19yOAJ6Evhy8M0JWqT9vvvrXQo3DSYM270uQmEN2t
	xdQW7IwTI7sDHB
X-X-Sender: gene099@racer.site
In-Reply-To: <20080123212613.GN2230@yugib.highrise.ca>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71576>

Hi,

On Wed, 23 Jan 2008, Aidan Van Dyk wrote:

> I know - openserver, yuch, bla bla bla... Not my choice, but sometimes 
> we have to do things we don't like...

Hehe.  They say: "de mortuis nil nisi bene".

>    snprintf (vsnprintf) behaves like sprintf (vsprintf), except that no
>    more than maxsize characters are placed into the array, including the
>    terminating null character. If more than maxsize characters were
>    requested, the output array will contain exactly maxsize characters,
>    with a null character being the last (when maxsize is nonzero); a
>    negative value is returned.

FWIW we had the same problem in MinGW, and Hannes Sixt solved it:

http://repo.or.cz/w/git/mingw/j6t.git?a=commitdiff;h=b8e84a68f01a2386b2071e1bdc8e24de809a3f6d

That might give you an idea how to solve the issue.  Maybe you even make a 
git patch out of it?  With a Makefile variable BROKEN_SNPRINTF=YesPlease, 
maybe?

Hth,
Dscho
