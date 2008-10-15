From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Wed, 15 Oct 2008 11:07:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810151104400.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081012183855.GA5255@spearce.org> <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0810131611470.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7vhc7g9z7s.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0810131950140.22125@pacific.mpi-cbg.de.mpi-cbg.de> <7v63nw9xor.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 11:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq2Ga-0006d3-MM
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 11:02:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYJOJAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 05:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYJOJAv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 05:00:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:39328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751468AbYJOJAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 05:00:51 -0400
Received: (qmail invoked by alias); 15 Oct 2008 09:00:48 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 15 Oct 2008 11:00:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18lC+9BH3olNxhRCEfmiiXhYVADrfSSe6UGAt9N6E
	+4Y79KhCAmUwac
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7v63nw9xor.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98261>

Hi,

On Mon, 13 Oct 2008, Junio C Hamano wrote:

> You could have said something like "The users may want to have a 
> checkout, and keep the same contents always appear elsewhere i.e. 
> 'installing by hardlinking'.  In such a setup, editing the source with 
> an editor configured not to break hardlinks would still work fine, but 
> git-checkout will unconditionally break such links, which is 
> undesirable.  Such a setup would want a configuration variable like 
> this."

Sounds very nice.  Sorry for being grumpy, and not being able to come up 
with such a beautiful description.

> The documentation update needs to warn about the Shawn's scenario.  I also
> do not know what this should do when you have two tracked paths with
> identical contents hardlinked to each other.

When the user does that, it's the user's wish.  I'd not let Git play cute 
games with that.

> It also raises another question.  Don't you want this to be an attribute 
> for paths, not all-or-nothing configuration per repository?

I'd rather not have it as an attribute, because it is not so much about 
file types that should show this behavior.  It is more like an option that 
I fully expect to be set in $HOME/.gitconfig.

Ciao,
Dscho
