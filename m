From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ignore duplicated slashes in git-log
Date: Sat, 9 Feb 2008 13:24:56 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802091323550.11591@racer.site>
References: <20080209125457.GA5686@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 14:25:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNphu-0005WL-7N
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 14:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbYBINYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 08:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbYBINYw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 08:24:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:42887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754307AbYBINYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 08:24:51 -0500
Received: (qmail invoked by alias); 09 Feb 2008 13:24:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp015) with SMTP; 09 Feb 2008 14:24:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196mco+aQ96sVZ9F73/3Uvw/CBM1FAOP6se8ZVgjn
	R4s/BtE6XZtyxL
X-X-Sender: gene099@racer.site
In-Reply-To: <20080209125457.GA5686@basil.nowhere.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73225>

Hi,

On Sat, 9 Feb 2008, Andi Kleen wrote:

> When I use git-log ... path/name I seem to regularly typo path/name as 
> path//name (with duplicated slashes) The normal kernel ignores these 
> duplicated slashes according to POSIX so it's typically no problem, but 
> git fails and cannot find the correct file name when this happens.

This is only one case you want to fix.  There are absolute paths, too, and 
series of "../".

Alas, Junio was quicker than you:

http://repo.or.cz/w/git.git?a=commitdiff;h=d089ebaad5315325d67db30176df1bbd7754fda9

Hth,
Dscho
