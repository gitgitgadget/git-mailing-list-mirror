From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msysgit corrupting commit messages?
Date: Sat, 7 Mar 2009 03:48:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903070347220.10279@pacific.mpi-cbg.de>
References: <20090306155322.GC12880@zoy.org> <CYOA8Q1cpfGtE1Pp6_ETXfSJevKv9ADmYIuq6_whU0qskk289fiiUw@cipher.nrlssc.navy.mil> <20090306171117.GD12880@zoy.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 03:52:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfmeg-0001cC-UZ
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 03:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbZCGCrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 21:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZCGCrG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 21:47:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:50567 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbZCGCrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 21:47:03 -0500
Received: (qmail invoked by alias); 07 Mar 2009 02:47:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 07 Mar 2009 03:47:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/2u/UtUxH20709Gog18A6sTXfS515OGFNe08ZE8E
	4aMRtzYu0ypHL8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090306171117.GD12880@zoy.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112506>

Hi,

On Fri, 6 Mar 2009, Sam Hocevar wrote:

> On Fri, Mar 06, 2009, Brandon Casey wrote:
> 
> > I get the impression that you do not intend for the comments above to be
> > part of the commit message.  If that is true, then they should be placed
> > further down after the '---' and before the diff-stat, or in some other
> > way partitioned from the commit message (maybe using --->8--- notation).
> > Otherwise they will _become_ part of the commit message if Junio applies
> > this patch as-is.
> 
>    Okay. I'm definitely having a problem with git on MSYS. Is anyone
> else seeing it butcher commits it exports? They appear fine in git log
> or git log -p, but not in git format-patch. I've never had the problem
> on a Linux system.

I have never had problems with msysGit's format-patch.  From Brandon's 
description however, it appears as if the offending changes were done 
manually...

Note: I missed the original message.

Ciao,
Dscho
