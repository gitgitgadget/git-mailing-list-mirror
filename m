From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 14:02:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281401530.27959@racer.site>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
 <Pine.LNX.4.64.0710260007450.4362@racer.site> <7v3avy21il.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0710261047450.4362@racer.site> <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0711281307420.27959@racer.site> <D7B369D7-B690-4F5B-852F-4EC4B03CEB45@steelskies.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxNUq-0003we-MF
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbXK1OCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXK1OCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:02:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:43058 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751175AbXK1OCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:02:15 -0500
Received: (qmail invoked by alias); 28 Nov 2007 14:02:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 28 Nov 2007 15:02:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wcmc7yPlwhkLGM4fJCH3xwjQ+YpMcd/boO2slxW
	1pADCHO899lan2
X-X-Sender: gene099@racer.site
In-Reply-To: <D7B369D7-B690-4F5B-852F-4EC4B03CEB45@steelskies.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66337>

Hi,

On Wed, 28 Nov 2007, Jonathan del Strother wrote:

> On 28 Nov 2007, at 13:11, Johannes Schindelin wrote:
> 
> > When calling 'git pull' with the '--rebase' option, it performs a
> > fetch + rebase instead of a fetch + pull.
> > 
> > This behavior is more desirable than fetch + pull when a topic branch
> > is ready to be submitted and needs to be update.
> 
> Don't you mean fetch + merge ?

Obviously.

Thanks,
Dscho
