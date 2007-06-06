From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Wed, 6 Jun 2007 16:00:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706061600060.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
   <Pine.LNX.4.64.0706041711500.4046@racer.site> <46643F2D.7C896CBC@eudaptics.com>
  <Pine.LNX.4.64.0706041850350.4046@racer.site> <46650A58.4934C07C@eudaptics.com>
 <Pine.LNX.4.64.0706051537360.4046@racer.site> <466665AD.CF5B85DF@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 17:02:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvx29-0003Hj-5s
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 17:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402AbXFFPCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 11:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758636AbXFFPCi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 11:02:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:50219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756402AbXFFPCh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 11:02:37 -0400
Received: (qmail invoked by alias); 06 Jun 2007 15:02:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 06 Jun 2007 17:02:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HH5QpJtrHS8u5cFWfrq/mMGQbcN9qWH6Y0IrfuB
	3dkSUjpMFmOIcE
X-X-Sender: gene099@racer.site
In-Reply-To: <466665AD.CF5B85DF@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49291>

Hi,

On Wed, 6 Jun 2007, Johannes Sixt wrote:

> It is more natural (for git users) to specify revision ranges like 
> 'master..next' instead. This makes it so. If no range is specified it 
> defaults to 'HEAD'.
> 
> As a consequence, the new name of the filtered branch must be the first
> non-option argument. All remaining arguments are passed to 'git rev-list'
> unmodified.

I was really close to do this myself. But I thought there was a 
problem to infer the correct source branch.

But you're right, this is more gittish. (Consider that an ACK from me.)

Of course, it would be even more so if the target branch name was 
"filtered", overrideable by "--target <name>".

Ciao,
Dscho
