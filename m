From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsserver: added support for update -p
Date: Wed, 10 Oct 2007 20:27:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102025390.4174@racer.site>
References: <200710101316.03633.jan@swi-prolog.org> <200710101626.53303.jan@swi-prolog.org>
 <Pine.LNX.4.64.0710101740400.4174@racer.site> <200710101927.38949.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Wielemaker <jan@swi-prolog.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:27:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfhDf-00081b-L3
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755128AbXJJT1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755122AbXJJT1f
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:27:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:40880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755046AbXJJT1e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 15:27:34 -0400
Received: (qmail invoked by alias); 10 Oct 2007 19:27:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 10 Oct 2007 21:27:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Bi294056B51LjpUYEET1UFi7tPIbhOt3dDzOxX6
	0Ze9UHt4tpMHvo
X-X-Sender: gene099@racer.site
In-Reply-To: <200710101927.38949.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60530>

Hi,

On Wed, 10 Oct 2007, Jan Wielemaker wrote:

> > On Wed, 10 Oct 2007, Jan Wielemaker wrote:
> > > Is there a test suite for git-cvsserver?
> >
> > Yes: t/t9400-git-cvsserver-server.sh
> 
> Thanks.  B.t.w. from the main directory:
> 
> gollem (git) 21_> make check

make check is to check with the static code analyzer "sparse".

To test, try "make test".  Since this is so commonly used to test 
packages (for example, the vast majority of Perl packages have it), I do 
not see the need to put a message pointing to "make test" in the "check" 
target.

Ciao,
Dscho
