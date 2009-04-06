From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 14:33:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904061431020.6619@intel-tinevez-2-302>
References: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Users List <git@vger.kernel.org>
To: Klas Lindberg <klas.lindberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 14:35:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqo2N-00042Z-IL
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 14:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbZDFMdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 08:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbZDFMdJ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:33:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:52389 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752940AbZDFMdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 08:33:06 -0400
Received: (qmail invoked by alias); 06 Apr 2009 12:33:03 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 06 Apr 2009 14:33:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18noysCqrMnyxHlUdVP/d8Brg1Cy88eGt460aitEj
	BtxxFZjHUH1USW
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115812>

Hi,

On Mon, 6 Apr 2009, Klas Lindberg wrote:

> Is there a way to fetch based on SHA id's instead of named references?

No, out of security concerns;  imagine you included some proprietary 
source code by mistake, and undo the damage by forcing a push with a 
branch that does not have the incriminating code.  Usually you do not 
control the garbage-collection on the server, yet you still do not want 
other people to fetch "by SHA-1".

BTW this is really a strong reason not to use HTTP push in such 
environments.

Ciao,
Dscho
