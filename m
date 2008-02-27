From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn messing with timezones
Date: Wed, 27 Feb 2008 10:40:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802271039220.22527@racer.site>
References: <20080226124748.GH31792@mail.stoakes.net> <20080227073244.GB24316@soma> <20080227102631.GJ30300@mail.stoakes.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Wed Feb 27 11:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUJjS-0000Wv-Ft
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 11:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbYB0KlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 05:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbYB0KlM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 05:41:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:58638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753813AbYB0KlL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 05:41:11 -0500
Received: (qmail invoked by alias); 27 Feb 2008 10:41:09 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 27 Feb 2008 11:41:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kiiNlqNrkJmzPtgCctDpJRUahxM4W4VU5EznVTz
	2vXVw/IzUDQ331
X-X-Sender: gene099@racer.site
In-Reply-To: <20080227102631.GJ30300@mail.stoakes.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75221>

Hi,

On Wed, 27 Feb 2008, Tim Stoakes wrote:

> Ah indeed, `git-svn log` does show the correct TZ. How annoying!

Note: if all you want is such a strange behaviour as svn's (I mean, why 
does it insist to show the dates as if they were done in _your_ 
timezone?):

	git log --date=local

> Is it documented anywhere?

AFAICT it waits to be written.  By you.

Ciao,
Dscho
