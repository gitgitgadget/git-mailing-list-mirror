From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git with https and client cert asks for password repeatedly
Date: Thu, 26 Feb 2009 11:17:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902261113340.6258@intel-tinevez-2-302>
References: <ca433830902241911x10b08a4fg8e790000a5cf9f3b@mail.gmail.com> <20090225214224.GB4573@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Thu Feb 26 11:18:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcdKL-0006fG-Lv
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 11:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZBZKRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 05:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbZBZKRV
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 05:17:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:47475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751634AbZBZKRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 05:17:19 -0500
Received: (qmail invoked by alias); 26 Feb 2009 10:17:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp003) with SMTP; 26 Feb 2009 11:17:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aIpht+/KawmR6jrlHx1fA3dmRJyMqzgd3H1ZZsS
	6wYansamQK3O8X
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090225214224.GB4573@raven.wolf.lan>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111547>

Hi,

[Josef, it is extremely annoying that you culled the Cc: list; I do not 
know if Mark will get this mail, and my time is too scarce to undo your 
mistake.]

On Wed, 25 Feb 2009, Josef Wolf wrote:

> On Tue, Feb 24, 2009 at 10:11:40PM -0500, Mark Lodato wrote:
> 
> > Finally, is there interest in refactoring the http code to make it a 
> > little cleaner?  That is, make a wrapper library around curl so that 
> > you can just call GET or POST or whatever and not worry about how to 
> > invoke curl?
> 
> As I mentioned above, I figured that implementing the callback method in 
> curl-lib would probably be easier than understanding the usage of curl 
> within git.  So I'd say refactoring would be an improvement.  But I bet 
> the git gurus will flame me for saying that =:-S

To the contrary.  I have been waiting for over one year for Mike Hommey to 
submit his refactoring patches.

A very quick list search would find you his patch series, I am sure.

Status quo: the series needs polishing, and we need http-fetch tests (if I 
saw it correctly, Peff started something like this).

Ciao,
Dscho
