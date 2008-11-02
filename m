From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: libgit2 - a true git library
Date: Sun, 2 Nov 2008 03:30:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811020328070.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081031170704.GU14786@spearce.org> <490CAB6D.90209@op5.se> <20081101204259.GC15463@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 03:25:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwSeg-0004iH-7n
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 03:25:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbYKBCWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 22:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbYKBCWv
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 22:22:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:35844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752448AbYKBCWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 22:22:51 -0400
Received: (qmail invoked by alias); 02 Nov 2008 02:22:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 02 Nov 2008 03:22:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TL1Mr7JnTs7DH40KBxQo9a4y6CM8fbuAlOGEqO7
	L0CzGatDl1vhV4
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081101204259.GC15463@spearce.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99800>

Hi,

On Sat, 1 Nov 2008, Shawn O. Pearce wrote:

> But I was also under the impression that the brilliant engineers who 
> work for Microsoft decided that on their platform special annotations 
> have to be inserted on functions that a DLL wants to export to 
> applications.

Exactly.  This is the "good" old __declspec(dllexport) for you.  It is a 
pain in the butt, but that is what you have to go for if libgit2 is 
supposed to be any more portable than ligit.a.

Ciao,
Dscho
