From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 00:28:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908190022090.8306@pacific.mpi-cbg.de>
References: <1250509342.2885.13.camel@cf-48> <alpine.DEB.1.00.0908171430010.4991@intel-tinevez-2-302> <vpqskfphe2k.fsf@bauges.imag.fr> <1250578735.2885.40.camel@cf-48> <alpine.LFD.2.00.0908181246470.6044@xanadu.home> <m3fxbpneqe.fsf@localhost.localdomain>
 <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 00:28:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdX9v-0002WR-J7
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 00:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbZHRW1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 18:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZHRW1g
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 18:27:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:53541 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750872AbZHRW1f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 18:27:35 -0400
Received: (qmail invoked by alias); 18 Aug 2009 22:27:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp034) with SMTP; 19 Aug 2009 00:27:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Ymv11lxJYenCdK54apodam2Sq/Cb+XMFDbrI867
	sEExz957qlmQbG
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0908181537360.6044@xanadu.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126473>

Hi,

On Tue, 18 Aug 2009, Nicolas Pitre wrote:

> On Tue, 18 Aug 2009, Jakub Narebski wrote:
> 
> > There is another way which we can go to implement resumable clone. 
> > Let's git first try to clone whole repository (single pack; BTW what 
> > happens if this pack is larger than file size limit for given 
> > filesystem?).
> 
> We currently fail.  Seems that no one ever had a problem with that so 
> far.

They just went away, most probably.

But seriously, I miss a very important idea in this discussion: we control 
the Git source code.  So we _can_ add a upload_pack feature that a client 
can ask for after the first failed attempt.

Ciao,
Dscho
