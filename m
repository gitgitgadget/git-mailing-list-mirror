From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [JGIT PATCH 09/21] Remember how a Ref was read in from disk and
 created
Date: Sun, 29 Jun 2008 15:17:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806291516540.9925@racer>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org> <1214726371-93520-9-git-send-email-spearce@spearce.org> <1214726371-93520-10-git-send-email-spearce@spearce.org> <200806291551.06201.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1916846965-1214749075=:9925"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 16:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxlo-0003it-ON
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 16:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759866AbYF2OTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 10:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759864AbYF2OTw
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 10:19:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:54604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759845AbYF2OTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 10:19:52 -0400
Received: (qmail invoked by alias); 29 Jun 2008 14:19:50 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp020) with SMTP; 29 Jun 2008 16:19:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ONuM6HXZOIp7046AcyJpHJChyTsHTANefu83iHj
	VGgx8No6arSGfG
X-X-Sender: gene099@racer
In-Reply-To: <200806291551.06201.robin.rosenberg@dewire.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86806>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1916846965-1214749075=:9925
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 29 Jun 2008, Robin Rosenberg wrote:

> söndagen den 29 juni 2008 09.59.19 skrev Shawn O. Pearce:
> > To efficiently deleted or update a ref we need to know where it came 
> > from when it was read into the process.  If the ref is being updated 
> > we can usually just write the loose file, but if it is being deleted 
> > we may need to remove not just a loose file but also delete it from 
> > the packed-refs.
> 
> One could argue that we should not normally just delete a ref, but mark 
> it as deleted and let git gc delete it when it expires, just like any 
> old ref, but then we should try to get C Git to do the same. There was a 
> thread relating to this recently.

... but it petered out, so you should consider any ideas in that thread 
rejected.

Ciao,
Dscho
--8323329-1916846965-1214749075=:9925--
