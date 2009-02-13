From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] How to review patches: Documentation/ReviewingPatches?
Date: Fri, 13 Feb 2009 12:05:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902131200380.10279@pacific.mpi-cbg.de>
References: <200902130045.59395.jnareb@gmail.com> <alpine.DEB.1.00.0902130055370.26370@racer> <49952728.2080404@trolltech.com> <7vocx6bu9r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 12:07:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXvsI-0005CP-2K
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 12:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbZBMLE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 06:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbZBMLE5
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 06:04:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:56670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751473AbZBMLE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 06:04:56 -0500
Received: (qmail invoked by alias); 13 Feb 2009 11:04:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 13 Feb 2009 12:04:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pTtV9eNkpxvzyI8itYjnAz+MgNiK5M7+IZSk5JC
	JFb9eitKaqrQTb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocx6bu9r.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109740>

Hi,

On Fri, 13 Feb 2009, Junio C Hamano wrote:

> Marius Storm-Olsen <marius@trolltech.com> writes:
> 
> > One thing I've wondered about though when sending patches, is how to 
> > send the fixups. Lets say I have a patch serie with 8 patches, do I 
> > send the whole serie each time, or do I just send an update to each 
> > individual patch? Do I attach it to the previous thread, or start a 
> > new one?
>
>  * Resending the whole series would help, especially if their earlier
>    round did not hit 'pu'.

Note that I chose to do it differently quite a number of times.  When I 
feel that a particular part of the patch series is in deep discussion 
mode, I will reply to the discussions with updates to that particular 
patch, often only as an interdiff.

When I feel that the result is in a shape that could be applied, or when I 
feel that people are substantially confused as to what is the current 
state, I send out a whole updated series.  This is to avoid sending 
v1..v99 of an 18-strong patch series, and basically dominate the volume of 
the list.

> Subsytem maintainers like Paulus for gitk, Shawn for git-gui and bash
> completion, Eric for git-svn, and Alexandre for emacs really have helped,

... and Jakub for gitweb, Simon for git-p4, Hannes for mingw.git, the New 
Zealand gang for cvsserver/cvsimport, not to forget Shawn for 
fast-import...  It is really great to see all that development going on!

Ciao,
Dscho
