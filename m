From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Question about bare repositories
Date: Fri, 16 Mar 2007 13:24:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703161323530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703160947.03833.andyparkins@gmail.com>
 <7vhcslv701.fsf@assigned-by-dhcp.cox.net> <200703161152.37485.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 13:24:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSBUO-0007Sv-Qt
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 13:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbXCPMYw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 08:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbXCPMYw
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 08:24:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:57650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751199AbXCPMYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 08:24:52 -0400
Received: (qmail invoked by alias); 16 Mar 2007 12:24:50 -0000
X-Provags-ID: V01U2FsdGVkX1+uT+JWGcOuw6ZgmZABlUXrpOB9685INKopPuCDF/
	6jdmbnYxkQbdFv
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703161152.37485.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42355>

Hi,

On Fri, 16 Mar 2007, Andy Parkins wrote:

> On Friday 2007 March 16 10:05, Junio C Hamano wrote:
> > Andy Parkins <andyparkins@gmail.com> writes:
> > > Why does a bare repository have/need a HEAD?
> >
> > To mark which branch the repository owner considers the primary
> > branch of the repository.  I think "git pull $URL" (i.e. without
> 
> Interesting.  So it's got a much reduced importance and sounds like it 
> is mainly as guidance for cloners, etc.

It's as much a guidance for cloners, as it is for Git in non-bare repos to 
know which branch gets updated upon commit.

HEAD was never more than a pointer to one (the "current") branch.

Ciao,
Dscho
