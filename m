From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 16:09:13 +0100
Message-ID: <20090115150913.GE10045@leksak.fem-net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net> <alpine.DEB.1.00.0901151429440.3586@pacific.mpi-cbg.de> <slrngmujc4.sf.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 16:10:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTrm-0004SW-Q0
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648AbZAOPJS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753531AbZAOPJS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:09:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:44280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753356AbZAOPJR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:09:17 -0500
Received: (qmail invoked by alias); 15 Jan 2009 15:09:15 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp071) with SMTP; 15 Jan 2009 16:09:15 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19Vx14Cdq5Vqz436se4nO6iHTJZnHblb1TzD+igRV
	fgjBJ9nTiKXBpu
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNTqL-0001PB-Ub; Thu, 15 Jan 2009 16:09:13 +0100
Content-Disposition: inline
In-Reply-To: <slrngmujc4.sf.sitaramc@sitaramc.homelinux.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105832>

Sitaram Chamarty wrote:
> On 2009-01-15, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > I turned this into a proper test case (to show what would be most helpful 
> > if you report bugs like this in the future).
> 
> Thanks.  I'll keep that in mind.
> 
> What is the significance of test_tick?  I can see what it is
> doing, but am trying to understand why.

When you run the test case a second, third, fourth time, the commit
times would be all different without test_tick. This is bad for
bugfixing when you need to inspect the test case repo a little
further. (When the commit times change, the commit ids change,
too.)
So setting the time and counting it artificially up is nice
to get the same SHAs over and over.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
