From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Fri, 22 Jan 2010 01:59:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001220158381.4985@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 01:53:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY7ma-0003rT-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 01:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab0AVAx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 19:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754536Ab0AVAx1
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 19:53:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:60343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752370Ab0AVAxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 19:53:25 -0500
Received: (qmail invoked by alias); 22 Jan 2010 00:53:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 22 Jan 2010 01:53:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IXmd3/gDIXn+7VqQ8Mke46dWUEOrUnwlRFP8Cje
	yaWsuI5FJ265bX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v636vj7c2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137710>

Hi,

On Thu, 21 Jan 2010, Junio C Hamano wrote:

> By the way, do you think anybody still uses "git merge-trees"?

IMO this is the only viable way to a non-broken merge-recursive.  Removing 
it would be counterproductive.

Ciao,
Dscho
