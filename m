From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 12:22:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910201221250.4985@pacific.mpi-cbg.de>
References: <loom.20091019T094924-194@post.gmane.org>  <4ADC2D45.3020803@viscovery.net>  <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>  <7v7hur1a0h.fsf@alter.siamese.dyndns.org>  <vpqy6n6shri.fsf@bauges.imag.fr>  <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
 <81b0412b0910200225g47220cc9wa2e82290a853c85d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-617623483-1256034161=:4985"
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 12:24:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Boq-0001SC-8K
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 12:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbZJTKTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 06:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbZJTKTq
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 06:19:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:35130 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751067AbZJTKTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 06:19:45 -0400
Received: (qmail invoked by alias); 20 Oct 2009 10:19:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 20 Oct 2009 12:19:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182lNIWcwg2AKU8Ah+59ROyO/8jqIBSgqV76fOo59
	PWJxW+TwLnk+NW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0910200225g47220cc9wa2e82290a853c85d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130783>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-617623483-1256034161=:4985
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 20 Oct 2009, Alex Riesen wrote:

> On Tue, Oct 20, 2009 at 08:45, Junio C Hamano <gitster@pobox.com> wrote:
> > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> >>> It probably is also a good idea to add a "--loose" option that does what
> >>> "fsck" currently does without "--full".  It is a good name
> >>
> >> +1 too.
> >
> > Actually, I changed my mind.  I do not think this so big that we need to
> > wait for a major version bump.  Why not shoot for 1.6.6?
> 
> --no-full works

It works.  Technically.  For human users, though, --loose-objects-only 
(with a shortcut "--loose") would be better.

Disclaimer: this email was written by a bot and is valid without signature
--8323328-617623483-1256034161=:4985--
