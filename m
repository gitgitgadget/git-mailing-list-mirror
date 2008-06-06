From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Fri, 6 Jun 2008 18:35:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061835130.1783@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer> <alpine.DEB.1.00.0806060006370.21190@racer> <7vve0nw4b7.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806061441120.1783@racer> <7vr6bav8ww.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806061735550.1783@racer>
 <7vej7av7df.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 19:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4fsh-0006ws-LQ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 19:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbYFFRgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 13:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756629AbYFFRgq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 13:36:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:37554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755677AbYFFRgp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 13:36:45 -0400
Received: (qmail invoked by alias); 06 Jun 2008 17:36:43 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 06 Jun 2008 19:36:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/c8Ttmxu3cqaZxB/islAFKaptkF6m62Oa0+0SYeZ
	acpJoQXFcBlvdD
X-X-Sender: gene099@racer
In-Reply-To: <7vej7av7df.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84094>

Hi,

On Fri, 6 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Only in hindsight do I realize that I could have increased the 
> > context,
> 
> Yeah, I was thinking about suggesting that, using -U7 or something 
> before dumping the output to the editor.

Good idea.

Ciao,
Dscho
