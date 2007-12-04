From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] Pulling tags no longer works in 1.5.3.4...
Date: Tue, 4 Dec 2007 02:21:36 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712040220270.27959@racer.site>
References: <4754B4AF.8070408@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:22:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNQv-0004Vg-UN
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbXLDCWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbXLDCWa
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:22:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:49783 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbXLDCW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:22:29 -0500
Received: (qmail invoked by alias); 04 Dec 2007 02:22:27 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp042) with SMTP; 04 Dec 2007 03:22:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FUoQEXklFkrETCaWr5rlJG8juAkWvtjNVnDkG3t
	1DcYOcdp5jua3I
X-X-Sender: gene099@racer.site
In-Reply-To: <4754B4AF.8070408@garzik.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66996>

Hi,

On Mon, 3 Dec 2007, Jeff Garzik wrote:

> Using package git-core-1.5.3.3-3.fc7, I can do the following with kernel git
> trees:
> 
> 1) git-clone --reference linux-2.6 linux-2.6 tmp-2.6
> 
> 2) time passes (days or weeks)
> 
> 3)	cd tmp-2.6
> 	git pull ../linux-2.6
> 	git pull --tags ../linux-2.6
> 
> Result:  works as expected.
> 
> 
> 
> Using package git-core-1.5.3.4-1.fc8, step #3 breaks:
> 
> [jgarzik@pretzel misc-2.6]$ git pull --tags ../linux-2.6/
> You asked me to pull without telling me which branch you
> want to merge with, and 'branch.master.merge' in
> your configuration file does not tell me either.  Please
> name which branch you want to merge on the command line and
> try again (e.g. 'git pull <repository> <refspec>').
> See git-pull(1) for details on the refspec.

Oops.

As a workaround, please do "git fetch --tags ../linux-2.6 && git pull 
../linux-2.6/" until it is fixed.

Ciao,
Dscho
