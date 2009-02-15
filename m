From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sun, 15 Feb 2009 20:41:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902152040350.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de> <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
 <alpine.DEB.1.00.0902142328530.10279@pacific.mpi-cbg.de> <7v1vtzmr9j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:42:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmsF-0008Ca-4V
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbZBOTk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbZBOTk0
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:40:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:34741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345AbZBOTk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:40:26 -0500
Received: (qmail invoked by alias); 15 Feb 2009 19:40:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 15 Feb 2009 20:40:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194QhhbovF4nsxsJ+iPLHZemRkK+yBVInB/V4/LJh
	7BaemfkUrfcXEK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vtzmr9j.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110043>

Hi,

On Sun, 15 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > Or maybe even better: set a variable "ret" and at the end of 
> >> > cmd_config(), "return !!ret;"?
> >> 
> >> Huh? So git commands don't return negative error values?
> >
> > AFAICT an exit status is supposed to be between 0 and 127.
> 
> Are you two talking about the return value from cmd_config()?
> 
> git.c::run_builtin() already knows what to do with status codes from the
> builtins to protect you from (rare) shells that do not cope with a
> negative return that come from the common pattern of doing:
> 
> 	return error("it is wrong in this way")
> 
> So "negative" is not really a problem.

Ooops.  I missed that.

Ciao,
Dscho
