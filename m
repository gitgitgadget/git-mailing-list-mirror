From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/2] git add --edit
Date: Fri, 6 Jun 2008 14:59:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061458430.1783@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer> <7vr6bbw4a3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4cW8-00052G-Kg
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbYFFOBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 10:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbYFFOBP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:01:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:33484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755010AbYFFOBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 10:01:14 -0400
Received: (qmail invoked by alias); 06 Jun 2008 14:01:12 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 06 Jun 2008 16:01:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qen4pJwOqWjFfH5iAKWL9A345By3MElHM7v9r7C
	Hd39w2XFwJ6bDG
X-X-Sender: gene099@racer
In-Reply-To: <7vr6bbw4a3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84069>

Hi,

On Thu, 5 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Changes relative to v2:
> >
> > - it works now not by chance, but by design,
> 
> Funny.  The old one worked by chance?

Yes, it did.  In my tests, I did not realize that the "line" parameter was 
set just after the second "@@" in the hunk header.  Therefore, the code 
counted a space at the beginning of the hunk header comment as a common 
line.

In my later tests, I finally realized my error, and changed the code.

Ciao,
Dscho
