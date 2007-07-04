From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: efficient way to filter several branches with common history?
Date: Wed, 4 Jul 2007 15:28:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041527050.4071@racer.site>
References: <652B0F85-D0E4-4BF0-8DFC-212B6C0650AF@zib.de> <468B5C4B.26F5E90B@eudaptics.com>
 <6DC0E50A-CAD3-453E-BD9C-73E51EDD5785@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 16:28:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I65qG-00089Z-I3
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 16:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760517AbXGDO2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 10:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759529AbXGDO2Z
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 10:28:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:47443 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758750AbXGDO2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 10:28:25 -0400
Received: (qmail invoked by alias); 04 Jul 2007 14:28:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 04 Jul 2007 16:28:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/cRwZBUrHc021veNalqfLDgYzCg5j/Hoxfcn3ofi
	k2TbUvCFsVidSP
X-X-Sender: gene099@racer.site
In-Reply-To: <6DC0E50A-CAD3-453E-BD9C-73E51EDD5785@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51615>

Hi,

On Wed, 4 Jul 2007, Steffen Prohaska wrote:

> On Jul 4, 2007, at 10:37 AM, Johannes Sixt wrote:
> 
> > Steffen Prohaska wrote:
> > > 
> > > Is there an efficient way to filter several branches at once
> > > through git-filter-branch?
> > 
> > That feature is not yet implemented.
> > 
> > In the meantime do it this way:
> > 
> > [...]
> 
> Thanks for your explanation. The following is the template I used
> to build my fully automated version of what you proposed:
> 
> [...]

Since you seem quite proficient in shell, why not implement this feature 
in filter-branch (which is a shell script) to begin with?

Ciao,
Dscho
