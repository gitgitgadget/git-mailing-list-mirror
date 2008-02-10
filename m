From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fetching a single commit from remote repo
Date: Sun, 10 Feb 2008 16:45:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101644540.11591@racer.site>
References: <1530970.y9vPlhFxz8@yoush.homelinux.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Nikita V. Youshchenko" <yoush@debian.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:46:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOFK2-00029U-Qk
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYBJQp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 11:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbYBJQp4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:45:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:37197 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751320AbYBJQpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 11:45:55 -0500
Received: (qmail invoked by alias); 10 Feb 2008 16:45:53 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 10 Feb 2008 17:45:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hBqU71MOhGo6wLo7tv4PYePOlTaBLu7JX7vhfL+
	+U/OTO3xRWOfYL
X-X-Sender: gene099@racer.site
In-Reply-To: <1530970.y9vPlhFxz8@yoush.homelinux.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73371>

Hi,

On Sun, 10 Feb 2008, Nikita V. Youshchenko wrote:

> I'm looking for a way to fetch a single snapshot, without history, from
> remote git repository.
> 
> I've found how to do it with a head (clone --depth 1, or fetch --depth 1).
> 
> Is it possible to do the same with non-head and non-tagged commit, if only
> sha1 name of the commit is known?
> Looks like fetch and fetch-pack only take ref names :(

Yes, for security reasons.  If you pushed some code you were not allowed 
to push, you have to have a way to undo the error by force-rewinding.

Ciao,
Dscho
