From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Thu, 30 Jul 2009 09:52:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907300950180.4589@intel-tinevez-2-302>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark A Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Thu Jul 30 09:52:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWQRc-0000Z8-70
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 09:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZG3Hwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 03:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbZG3Hws
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 03:52:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:46910 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751045AbZG3Hws (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 03:52:48 -0400
Received: (qmail invoked by alias); 30 Jul 2009 07:52:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp050) with SMTP; 30 Jul 2009 09:52:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19r9PQxuqhrtE+b7xE9RK8CwyAl8wt1iYxMOCHfR8
	8Gk2UnrrFVD1A8
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124448>

Hi,

On Thu, 30 Jul 2009, Mark A Rada wrote:

> I thought I would submit this little patch I made to my gitweb. I am on 
> a relatively slow connection, and so LZMA compression time is less of a 
> concern than bandwidth---I'm guessing that I am not the only person who 
> suffers from slow internet connection syndrome.

That's great!

FWIW on this mailing list, we prefer to have patches inlined so that it is 
easier for reviewers to comment (it is almost impossible to get any patch 
into git.git without review, and because reviewing is such an ungratifying 
job you want to make it easier).

The patch is pretty straight-forward, but I'd love to see some information 
in the commit message about:

- performance numbers on the _server_ (i.e. how does the RAM and CPU load 
  compare to, say, bzip2?)

- how to disable/enable it (yes, it's in the documentation, but you can 
  make things easier still)

- whether it is turned on by default, and why.

Thanks,
Dscho
