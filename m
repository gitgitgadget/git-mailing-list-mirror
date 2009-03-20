From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] Introduce %<branch> as shortcut to the tracked
 branch
Date: Fri, 20 Mar 2009 18:32:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201831420.6865@intel-tinevez-2-302>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de> <20090320004029.GX23521@spearce.org> <20090320004450.GY23521@spearce.org>
 <alpine.DEB.1.00.0903201027450.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903201714020.10279@pacific.mpi-cbg.de> <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, B.Steinbrink@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:34:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkibY-00064J-ON
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 18:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757395AbZCTRcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 13:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757454AbZCTRca
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 13:32:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:51297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755603AbZCTRc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 13:32:29 -0400
Received: (qmail invoked by alias); 20 Mar 2009 17:32:26 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 20 Mar 2009 18:32:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NITtzkUwNuSRXiSniUaXlv6Cpm260HINLUaPj43
	JyoaHyaynihm3J
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v7i2ki0sw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113984>

Hi,

On Fri, 20 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Often, it is quite interesting to inspect the branch tracked by a given
> > branch.  This patch introduces a nice notation to get at the tracked
> > branch: '%<branch>' can be used to access that tracked branch.
> >
> > A special shortcut '%' refers to the branch tracked by the current branch.
> >
> > Suggested by Pasky.
> >
> > Even if a branch name can legally start with a '%' sign, we can use the
> > special character '%' here, as you can always specify the full ref:
> > refs/heads/%my-branch (pointed out by doener on IRC).
> 
> That is not a good argument, as %<name> is (just like name@{-n} is) a
> substitute way to spell the "name" of a branch, not just a random SHA-1,
> and to some commands it makes a difference between <branchname> and
> refs/heads/<branchname>.  The latter is not giving the name of the branch,
> but merely a commit object name.
> 
> An most obvious one is that "git checkout branchname" and "git checkout
> refs/heads/branchname" behave differently.  You cannot checkout a branch
> called %master after this patch goes in.
> 
> Just be honest and say "You may have a branch whose name begins with a '%'
> and you cannot refer to it anymore in certain contexts.  Too bad.  Don't
> do it next time you create a new branch".  I _can_ buy that argument.

Be that as it may, at this point I kick the ball back to the interested 
parties.  I did my duty.

Ciao,
Dscho
