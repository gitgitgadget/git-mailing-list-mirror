From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Thu, 30 Jul 2009 10:43:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca> <m3r5vy1siq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 10:46:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWRF4-0005QO-1C
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 10:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZG3Inz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 04:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZG3Inz
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 04:43:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:49349 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751245AbZG3Iny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 04:43:54 -0400
Received: (qmail invoked by alias); 30 Jul 2009 08:43:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 30 Jul 2009 10:43:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19RrnJCfLhRlsyLErvCaN49B1kbRLWIOsCJ0P1ubL
	a7Jqax3FvGJZLI
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <m3r5vy1siq.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124456>

Hi,

On Thu, 30 Jul 2009, Jakub Narebski wrote:

> BTW. I wonder if it would be good idea to add support for this format
> directly to git-archive...  OTOH it would mean additional dependency.

I don't think it would be a good idea; we do not have bzip2 support 
either.

The only reason we have inbuilt gzip and zip support is because the format 
is so similar to Git's own compression.

Ciao,
Dscho
