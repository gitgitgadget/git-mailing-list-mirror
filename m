From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: git-cvsserver commit trouble (unexpected end of file in client)
Date: Wed, 3 Oct 2007 20:42:14 +0200
Message-ID: <200710032042.14842.wielemak@science.uva.nl>
References: <200710031348.50800.wielemak@science.uva.nl> <Pine.LNX.4.64.0710031711070.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 20:55:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id9Nx-0007nx-Dc
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 20:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbXJCSzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbXJCSzp
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 14:55:45 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:1212 "EHLO
	smtp-vbr17.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbXJCSzo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 14:55:44 -0400
X-Greylist: delayed 807 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2007 14:55:44 EDT
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr17.xs4all.nl (8.13.8/8.13.8) with ESMTP id l93IgF6w050246;
	Wed, 3 Oct 2007 20:42:15 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710031711070.28395@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59863>

Dscho,

On Wednesday 03 October 2007 18:11, Johannes Schindelin wrote:
> Hi,
>
> On Wed, 3 Oct 2007, Jan Wielemaker wrote:
> > 2007-10-03 12:25:16 : WARN - error 1 pserver cannot find the current
> > HEAD of module
>
> AFAIR we do not allow committing via pserver protocol.  Might that be your
> problem?

Thanks, but no. I'm using CVS over SSH. I've been looking around in
git-cvsserver source a bit and it aborts quite quickly if you try a
commit through pserver. I get a bit further, but it cannot find the HEAD
revision for some reason and (from later message), if I try to checkout
master instead of HEAD it finds the revision but I get a hash mismatch.

I've tried a bit debugging this, but in 15 years CVS experience I never
really needed to debug the protocol and my GIT experience is only 2
weeks old :-( 

My hope is I'm doing something fundamentally wrong and git-cvsserver
just doesn't give a sensible error. I did setup the git repository using
two different routes, one adviced in the CVS conversion manual. GIT
operations work just fine, so does CVS checkout. I don't think you can
to that much wrong with cvs over ssh clients, especially if checkout
works just fine.

Does anyone out there has a working GIT <-> CVS+SHH setup? Based on
what version of GIT? Using what route to create the repository?

	Thanks --- Jan
