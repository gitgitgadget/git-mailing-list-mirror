From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RAM consumption when working with the gcc repo
Date: Sat, 8 Dec 2007 11:54:17 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712081153500.27959@racer.site>
References: <9e4733910712071207p750c14f4h7abc5d637da3a478@mail.gmail.com> 
 <Pine.LNX.4.64.0712071323260.12607@asgard.lang.hm> 
 <alpine.LFD.0.99999.0712071529580.555@xanadu.home>
 <e5bfff550712071325k3d4dadf2gf34c069022cc005@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, david@lang.hm,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 12:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0yHB-0006fu-3K
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 12:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbXLHLyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 06:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbXLHLyz
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 06:54:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:38784 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752394AbXLHLyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 06:54:54 -0500
Received: (qmail invoked by alias); 08 Dec 2007 11:54:52 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp038) with SMTP; 08 Dec 2007 12:54:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19R4KB6W75RCC1tcd+XF9uUbp+NxqF1Ut0dyKZJWN
	n7hicJD23erzhe
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550712071325k3d4dadf2gf34c069022cc005@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67546>

Hi,

On Fri, 7 Dec 2007, Marco Costalba wrote:

> On Dec 7, 2007 9:46 PM, Nicolas Pitre <nico@cam.org> wrote:
> >
> > The other 2.3GB is hard to explain.
> 
> BTW does exist a tool to profile memory consumption by each source level 
> struct / vector/ or any other data container?
> 
> Valgrind checks mainly memory leaks, callgrind gives profiling 
> information in terms of call graphs and times/cycles consumed by each 
> function.

Have you looked at Massif (also part of Valgrind)?

Ciao,
Dscho
