From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 21:07:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232105470.8986@racer>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807231817460.8986@racer>
 <7vhcagcsmj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 22:08:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkdC-00016Z-Rh
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 22:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284AbYGWUHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 16:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbYGWUHL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 16:07:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:42062 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755207AbYGWUHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 16:07:09 -0400
Received: (qmail invoked by alias); 23 Jul 2008 20:07:07 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp010) with SMTP; 23 Jul 2008 22:07:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uy81yhiJuAwgZns/t5Lj4sWecXUjhpRJ8uddO6e
	AbTQuP59tD4Lz3
X-X-Sender: gene099@racer
In-Reply-To: <7vhcagcsmj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89764>

Hi,

On Wed, 23 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 23 Jul 2008, Junio C Hamano wrote:
> > ...
> >> If you are on a sane system, you do not even want to pay the price of 
> >> conversion.  Only people on systems with CRLF line endings should pay 
> >> the price (because your aim is to convert on such systems).  Are we 
> >> throwing that out of the window when the project decides to use 
> >> gitattributes?
> >
> > Well, if you do not want that, why do you set crlf in the 
> > gitattributes to begin with?
> 
> It is not _me_ but the project upstream that needs to interact also with 
> Windows people who manages gitattributes.  And me personally knows my 
> editors are not helpful to add CR at the end of lines, so I do not need 
> the conversion.

I know you do.  And I know those users don't.  They do not even know that 
they should set autocrlf = input in their cygwin Git.

Or at least, now they do.  After a few hundred commits that have been 
published _after_ their broken checkins.

Sigh,
Dscho
