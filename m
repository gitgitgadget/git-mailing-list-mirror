From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Enable parallel tests
Date: Fri, 8 Aug 2008 12:26:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081225000.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <alpine.DEB.1.00.0808080754230.9611@pacific.mpi-cbg.de.mpi-cbg.de> <7vvdycf17a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 12:23:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRP7X-00017b-I2
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 12:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbYHHKVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 06:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753891AbYHHKVr
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 06:21:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:53491 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752970AbYHHKVr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 06:21:47 -0400
Received: (qmail invoked by alias); 08 Aug 2008 10:21:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 08 Aug 2008 12:21:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19skUBMLGJs5cpEMZAjUp9g2imWhH+EKp5d5tyyG6
	K6QZqzx0yrE1/4
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vvdycf17a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91648>

Hi,

On Thu, 7 Aug 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Parallel mode also triggers removal of the trash directory in the test 
> > itself if everything went fine, so that the trash directories do not 
> > pile up only to be removed at the very end.
> 
> I think making the tests remove their own mess makes sense regardless.

When I add tests, I first run the appropriate t/t*.sh, then expect what is 
in trash directory, then extend the test.  So at least I need an option to 
keep the directory.

> >  clean:
> > -	$(RM) -r 'trash directory' test-results
> > +	$(RM) -rf 'trash directory' test-results
> 
> This is not needed, I think, as RM is defined with -f already.

Okay, thanks.

Ciao,
Dscho
