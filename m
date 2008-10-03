From: Jonas Schneider <JonasSchneider@gmx.de>
Subject: Broken index file - any hope?
Date: Fri, 03 Oct 2008 23:51:37 +0200
Message-ID: <48E693E9.708@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 23:53:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klsa7-0007NF-AN
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 23:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbYJCVvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 17:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYJCVva
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 17:51:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:35594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753160AbYJCVva (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 17:51:30 -0400
Received: (qmail invoked by alias); 03 Oct 2008 21:51:28 -0000
Received: from dslb-088-066-013-107.pools.arcor-ip.net (EHLO [192.168.1.33]) [88.66.13.107]
  by mail.gmx.net (mp023) with SMTP; 03 Oct 2008 23:51:28 +0200
X-Authenticated: #19141570
X-Provags-ID: V01U2FsdGVkX18Dj7wnPzUDu2rSaJSJyscflUQtrRyEx/mGqGr4Uf
	gdYPIol+oUOnte
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97455>

Hey guys,

I come from the Ruby on Rails world, where Git is now spreading like ... 
duh, something fast.
Today I sadly lost my complete .git directory, only the working copy was 
left behind.
I reconstructed the directory, but the index file seems to be corrupt, 
every command just tells me about a bad signature.
I hope the rest of the repository is intanct. If it is, is there any 
chance to restore/rebuild that index file from the rest?
I don't have an idea of the internals of git, but I know the objects are 
stored in different files, and maybe on top of that
I could rebuild the index file.

Any hope?
Thanks,
--Jonas Schneider
