From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5] autoconf: Test FREAD_READS_DIRECTORIES
Date: Thu, 6 Mar 2008 12:13:24 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061213000.15786@racer.site>
References: <200803061141.09050.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXE33-0001As-KI
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758367AbYCFLN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758524AbYCFLN0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:13:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:49538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764787AbYCFLNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:13:25 -0500
Received: (qmail invoked by alias); 06 Mar 2008 11:13:23 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp057) with SMTP; 06 Mar 2008 12:13:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18RY8cZDnYR/9IS4I4Z052reHMrbk049o/xxiRdmZ
	A1JDEx3WQaU/2K
X-X-Sender: gene099@racer.site
In-Reply-To: <200803061141.09050.michal.rokos@nextsoft.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76373>

Hi,

On Thu, 6 Mar 2008, Michal Rokos wrote:

> Add test for FREAD_READS_DIRECTORIES to detect when fread() reads fopen'ed 
> directory.
> 
> Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>
> Tested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Umm... technically, you are correct, but because of that libsocket bug, it 
did not work...

Ciao,
Dscho
