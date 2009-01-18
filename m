From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date: Sun, 18 Jan 2009 22:10:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901182210190.3586@pacific.mpi-cbg.de>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <alpine.DEB.1.00.0901182005230.3586@pacific.mpi-cbg.de>
 <20090118191928.GA23108@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOewE-0002ZS-W8
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbZARVKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755488AbZARVKr
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:10:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:35088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755388AbZARVKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:10:47 -0500
Received: (qmail invoked by alias); 18 Jan 2009 21:10:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 18 Jan 2009 22:10:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1920UBSeAx2lXA9sY3+83JnUIxP5m0CdSsiA+YgP5
	HwUec6jzUWWdOU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090118191928.GA23108@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106282>

Hi,

On Sun, 18 Jan 2009, Mike Hommey wrote:

> On Sun, Jan 18, 2009 at 08:06:17PM +0100, Johannes Schindelin wrote:
> 
> > You cannot http_cleanup() here, as http-push calls that function, but 
> > continues to want to use curl.
> 
> Are you really sure? It doesn't seem so, to me.

Nope, sorry.  It was http clone.

Ciao,
Dscho
