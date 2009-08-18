From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Windows & executable bit
Date: Tue, 18 Aug 2009 14:59:18 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181458450.4680@intel-tinevez-2-302>
References: <45321.77.61.241.211.1250588523.squirrel@hupie.xs4all.nl>    <alpine.DEB.1.00.0908181213590.4680@intel-tinevez-2-302>    <200908181223.48291.trast@student.ethz.ch> <4262.77.61.241.211.1250594232.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Ferry Huberts <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Aug 18 14:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOHw-0000KG-KY
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 14:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911AbZHRM7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 08:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758907AbZHRM7V
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 08:59:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:44026 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758908AbZHRM7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 08:59:20 -0400
Received: (qmail invoked by alias); 18 Aug 2009 12:59:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 18 Aug 2009 14:59:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188O7Aa8uo8j0QZg4cw7d2JvtJH3C0uZqbNO3ehBH
	OEPje5hSrL3PTS
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4262.77.61.241.211.1250594232.squirrel@hupie.xs4all.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126391>

Hi,

On Tue, 18 Aug 2009, Ferry Huberts wrote:

> > Isn't that core.filemode ?
> 
> yep. works
> 
> however, the man page says that you'll have to configure it in this way 
> when you're on a broken filesystem like FAT. We're on NTFS however.... 
> NTFS is also broken then?

It is more a question of the ACLs not being properly mappable to POSIX 
permissions.  So we cannot trust the file mode.

Ciao,
Dscho
