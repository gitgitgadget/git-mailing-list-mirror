From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: timestamps not git-cloned
Date: Fri, 28 Nov 2008 14:20:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811281418530.30769@pacific.mpi-cbg.de>
References: <87ej0wwptn.fsf@jidanni.org> <200811281358.24592.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 14:14:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L63AV-0006aJ-Hy
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 14:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbYK1NMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 08:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbYK1NMn
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 08:12:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:51182 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750894AbYK1NMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 08:12:42 -0500
Received: (qmail invoked by alias); 28 Nov 2008 13:12:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 28 Nov 2008 14:12:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Msi17x4AM8iEqeEX0Ah0V4HgFTKhOP7qOAsIoIj
	SJ/1HPYKEmm8XN
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200811281358.24592.robin.rosenberg.lists@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101874>

Hi,

On Fri, 28 Nov 2008, Robin Rosenberg wrote:

> I recommend every new Git user to scan the FAQ. It's not just clone,
> it's in everything git does in the file system. There is a very good 
> reason git behaves this way in general, although clone could be
> exception, but then we would have a ton of questions about that
> inconsistency.

No, clone cannot be an exception.  The information is just not stored, and 
for a good reason: a file's timestamp is nothing you want to commit in 
source code management.  It just does not make sense at all.

Ciao,
Dscho
