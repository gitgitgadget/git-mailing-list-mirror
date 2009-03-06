From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or
	configured
Date: Fri, 6 Mar 2009 14:58:40 +0100
Message-ID: <20090306135840.GA24454@pvv.org>
References: <20090305221529.GA25871@pvv.org> <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com> <200903052322.02098.markus.heidelberg@web.de> <200903052325.44648.markus.heidelberg@web.de> <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com> <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de> <7v4oy7szze.fsf@gitster.siamese.dyndns.org> <20090306114812.GA19534@pvv.org> <alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	John Tapsell <johnflux@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 06 15:00:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfab1-0004O2-UR
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 15:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbZCFN6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 08:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZCFN6s
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 08:58:48 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:48012 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZCFN6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 08:58:47 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LfaZU-00086d-TZ; Fri, 06 Mar 2009 14:58:40 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903061306450.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112438>

On Fri, Mar 06, 2009 at 01:07:56PM +0100, Johannes Schindelin wrote:
> [...]
> 
> Speaking of which, Steffen (who cannot reply right now, since he is AFK 
> for a while) had a patch to install "remote.<branch>.push = HEAD" with 
> clone and remote.  Would that be better?

Are you referring to the patch he suggested in October 2007? I'm
reading the October/November archives now, and it seems these things
have been discussed before... Ok so re-reading the discussion from
October/November 2007, it seems that we are having exactly the same
discussion again! I did not investigate far enough back in time before
firing up this thread again evidently.

Reading the threads almost makes me sad. Steffen had a lot of great
patches and ideas (implementing --current, adding tests, ...), but it
was somehow dropped. After having read through this it would feel
wrong somehow to even post patches on this topic, since I would
effectively just redo what he already did.

The only difference between his approach and what I am suggesting
seems to be that he mostly wanted "git push" to do various useful
tasks depending on configuration (the remote.<branch>.push stuff),
while I mostly want "git push" to do nothing by default. We both agree
that the current "git push" default behavior is very bad for our
workflow (many developers against one or more shared repos).

- Finn Arne
