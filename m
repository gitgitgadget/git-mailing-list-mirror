From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Wed, 14 May 2008 23:09:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805142308400.30431@racer>
References: <alpine.DEB.1.00.0805141802480.30431@racer> <alpine.DEB.1.00.0805141803240.30431@racer> <7vbq38oi3j.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805141940460.30431@racer> <7vy76cn1aq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:10:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwPAy-0002yO-Tg
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 00:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757327AbYENWJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 18:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbYENWJK
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 18:09:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:46370 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756794AbYENWJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 18:09:08 -0400
Received: (qmail invoked by alias); 14 May 2008 22:09:06 -0000
Received: from R2b68.r.pppool.de (EHLO racer.local) [89.54.43.104]
  by mail.gmx.net (mp033) with SMTP; 15 May 2008 00:09:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19g6vkCSaBg4jGiwivFDYe0BGMl7ZkYGbNRyBEoKp
	XnQVYmvrGsjZRZ
X-X-Sender: gene099@racer
In-Reply-To: <7vy76cn1aq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82151>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > The point is: for the sake of a script (which wants to ignore 
> > submodules) asking if there is a diff, I think it makes sense to not 
> > ignore those changes.  IOW I think my patch is enough for the purpose 
> > of getting stash/rebase to behave.
> 
> But the patch is not about stash/rebase but affects all diff users, 
> doesn't it?

Does it?  I thought I hid all that special handling behind the 
--ignore-submodules options.

Ciao,
Dscho
