From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] diff options: Introduce --ignore-submodules
Date: Thu, 15 May 2008 14:58:14 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805151439190.30431@racer>
References: <alpine.DEB.1.00.0805141802480.30431@racer> <alpine.DEB.1.00.0805141803240.30431@racer> <7vbq38oi3j.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805141940460.30431@racer> <7vy76cn1aq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805142308400.30431@racer>
 <7vod78k022.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805150204440.30431@racer> <7v3aokjpxv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 16:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwdzE-0002Xm-CS
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 15:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbYEON6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYEON6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 09:58:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:56147 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754110AbYEON6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 09:58:15 -0400
Received: (qmail invoked by alias); 15 May 2008 13:58:13 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp010) with SMTP; 15 May 2008 15:58:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+BtH1EmFuBpDsAuFKSKmqnK2cYMjU2gCuOyO/4u/
	3Nlax+Oipxeomh
X-X-Sender: gene099@racer
In-Reply-To: <7v3aokjpxv.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82206>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> That's exactly the point.  The option reads "ignore submodules", not 
> >> "special option for use only by stash and rebase".
> >
> > But it also does not read "ignore submodules and those blobs/trees 
> > that happen to replace (or be replaced by) submodules".
> 
> I think "ignore submodules" option, if exists, would mean "ignore 
> changes that involve submodules", and I think everybody would agree with 
> that.
> 
> Because we are talking about an option to "diff", changes involve two
> sides (preimage and postimage).  Logically, you can define the class of
> changes that involve submodules in two ways:
> 
>  * both sides of the change must be a submodule; otherwise the change does
>    not involve a submodule.
> 
>  * either side of the change is a submodule; such a change involve a
>    submodule.
> 
> I am saying that the latter makes much more sense (worse yet, what you 
> did for creation and deletion is inconsistent --- they are void vs 
> submodule and you treat them as "change that involve submodule").

Okay, maybe the introduction, and the intuitive understanding of "ignore 
submodules" is the latter.

But I maintain that there is no sensible operation you would need it 
for.

So, how about --only-non-submodules?

Ciao,
Dscho
