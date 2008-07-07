From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-svn sucks when it should not
Date: Mon, 7 Jul 2008 18:18:48 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807071818250.18205@racer>
References: <alpine.DEB.1.00.0807070135450.7342@eeepc-johanness>  <20080707094438.GA5964@untitled>  <alpine.DEB.1.00.0807071242180.18205@racer> <32541b130807070929q65e9a0d8g788cdb8c28ef28b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:22:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFuPH-0000jO-SM
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 19:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYGGRUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753627AbYGGRUo
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 13:20:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:46168 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752927AbYGGRUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 13:20:43 -0400
Received: (qmail invoked by alias); 07 Jul 2008 17:20:41 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp059) with SMTP; 07 Jul 2008 19:20:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pQi52HB4pljhI66vvozyIQkEwVbZFn9xTb9SfiZ
	trK1jm/IRVuXAO
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807070929q65e9a0d8g788cdb8c28ef28b9@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87633>

Hi,

On Mon, 7 Jul 2008, Avery Pennarun wrote:

> On 7/7/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >  # It heavily relies on curl being able to screen-scrape the 
> >  # directories, in other words, it wants an HTTP on the other side 
> >  # that has directory listings enabled.
> 
> I wrote a similar script myself, although it makes assumptions about the 
> meaning of /branches and /tags rather than using the dirs vs. files 
> trick.
> 
> Rather than relying on screen scraping with curl, you might prefer to 
> use "svn ls" instead, since it'll work with any svn-compatible 
> repository type and (I presume) doesn't require special web server 
> settings.

Good to know!  At least if you want to use svn more often ;-)

Thanks,
Dscho
