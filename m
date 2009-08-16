From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to stop sharing objects between repositories
Date: Sun, 16 Aug 2009 10:43:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908161042210.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jon Jensen <jon@endpoint.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 10:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McbJz-00053j-7x
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 10:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbZHPIm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 04:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbZHPIm0
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 04:42:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:59986 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752686AbZHPIm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 04:42:26 -0400
Received: (qmail invoked by alias); 16 Aug 2009 08:42:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 16 Aug 2009 10:42:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pRCwHeS5p9AMHo38UxKh2/UvpSgmthujgfKL/DA
	JoSd9suNa9aGHO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0908151756150.29215@nhtr.ovalna.fjrygre.arg>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126053>

Hi,

On Sat, 15 Aug 2009, Jon Jensen wrote:

> If there's a better or built-in way to do this with Git tools, I'd like 
> to learn it, and I'd be happy to update the wiki accordingly.

I think what you need is done by

	git repack -l

(I agree it is not well documented, and I'd welcome a documentation 
patch.)

Ciao,
Dscho
