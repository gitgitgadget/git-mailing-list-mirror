From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 10:58:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081012183855.GA5255@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 10:52:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpJAI-0008Iz-OK
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 10:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbYJMIvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 04:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754907AbYJMIvW
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 04:51:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:45538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754879AbYJMIvV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 04:51:21 -0400
Received: (qmail invoked by alias); 13 Oct 2008 08:51:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 13 Oct 2008 10:51:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+iOd1Ds5ailXrELKIh55awyRzncNWW77DP4wpeYM
	WLdzE3flBuyeKZ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081012183855.GA5255@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98096>

Hi,

On Sun, 12 Oct 2008, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > When a tracked file was hard linked, we used to break the hard link
> > whenever Git writes to that file.  Make that optional.
> 
> Why would anyone want to do this?
> 
> I cannot fathom why a user wants this much rope to hang themselves 
> with...

The question is not so much why anyone want to do this, but _if_.

And the answer is: yes.

Ciao,
Dscho
