From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Tue, 18 Aug 2009 19:40:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181936130.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302>
 <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48>
 <alpine.LFD.2.00.0908181246470.6044@xanadu.home>
 <m3fxbpneqe.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
 <alpine.DEB.1.00.0908190022090.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 01:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdYID-0007Qm-Lf
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 01:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752119AbZHRXkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 19:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbZHRXkb
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 19:40:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49517 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbZHRXkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 19:40:31 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOL00BDJJ3FCI40@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 19:40:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0908190022090.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126483>

On Wed, 19 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 18 Aug 2009, Nicolas Pitre wrote:
> 
> > On Tue, 18 Aug 2009, Jakub Narebski wrote:
> > 
> > > There is another way which we can go to implement resumable clone. 
> > > Let's git first try to clone whole repository (single pack; BTW what 
> > > happens if this pack is larger than file size limit for given 
> > > filesystem?).
> > 
> > We currently fail.  Seems that no one ever had a problem with that so 
> > far.
> 
> They just went away, most probably.

Most probably they simply don't exist.  I would be highly surprised 
otherwise.

> But seriously, I miss a very important idea in this discussion: we control 
> the Git source code.  So we _can_ add a upload_pack feature that a client 
> can ask for after the first failed attempt.

Indeed.  So what do you think about my proposal?  It was included in my 
first reply to this thread.


Nicolas
