From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 12:08:40 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802101207330.11591@racer.site>
References: <200802081828.43849.kendy@suse.cz>  <alpine.LFD.1.00.0802081250240.2732@xanadu.home>  <200802091525.36284.kendy@suse.cz> <e5bfff550802092323u3ec3c9c8uf6e92399395efd27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Holesovsky <kendy@suse.cz>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOAzm-00050t-AO
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYBJMIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751660AbYBJMIo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:08:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:60995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750881AbYBJMIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:08:43 -0500
Received: (qmail invoked by alias); 10 Feb 2008 12:08:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp045) with SMTP; 10 Feb 2008 13:08:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lhTQAfLSlMTBq00fZAxrsmYk0xCnioXNGQTOAAu
	kLOvfbNq4+MH5U
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550802092323u3ec3c9c8uf6e92399395efd27@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73340>

Hi,

On Sun, 10 Feb 2008, Marco Costalba wrote:

> Linux git repository is not very big and can be downloaded with easy. On 
> the other end Linux history spans many more years then the repo does.
> 
> The design choice here is two have *two repositories*, one with recent 
> stuff and one historical, with stuff older then version 2.6.12

I do not think that this is an option: Jan already tried a shallow clone 
(which would amount to something like what you propose), and it was still 
too large.

Ciao,
Dscho
