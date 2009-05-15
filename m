From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Funny error with git gc...
Date: Fri, 15 May 2009 20:02:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 20:04:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51lO-0000iU-32
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763283AbZEOSC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 14:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763234AbZEOSC1
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:02:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:49546 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763324AbZEOSC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:02:26 -0400
Received: (qmail invoked by alias); 15 May 2009 18:02:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 15 May 2009 20:02:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18HmSd5OQkHHcDKmHbAR+46i6oA5xpuVBXzwYMb8z
	QK6ieQBFIAfXSv
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119268>

Hi,

if you need a chuckle, like me, you might appreciate this story: in one of 
my repositories, "git gc" dies with

	unable to open object pack directory: ...: Too many open files

turns out that there are a whopping 1088 packs in that repository...

Ciao,
Dscho
