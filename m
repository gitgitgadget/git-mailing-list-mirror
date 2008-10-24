From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 19:44:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810241943470.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <gdok16$vh2$1@ger.gmane.org> <49007623.1060606@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 19:38:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtQc9-0000nk-4G
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 19:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYJXRhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYJXRhH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 13:37:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:42468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754498AbYJXRhG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 13:37:06 -0400
Received: (qmail invoked by alias); 24 Oct 2008 17:37:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp007) with SMTP; 24 Oct 2008 19:37:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pVtJyNSnpiqCWwAfkrqiBnn2QIE1qJv31qNjGuH
	OpVF8gI5W3seQL
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <49007623.1060606@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99044>

Hi,

On Thu, 23 Oct 2008, Johannes Sixt wrote:

> Giuseppe Bilotta schrieb:
> > Zit will create a directory .zit.file to hold a git repository 
> > tracking the single file .zit.file/file, which is just a hard link to 
> > file.
> 
> git breaks hard links, mind you! (Just in case you check out older 
> versions and you wonder why your "real" file is not updated).
> 
> But there's a recent patch by Dscho floating around that takes care of 
> the hard link case.

Yep, I still want to work on it; it breaks on one of Junio's machines.

Ciao,
Dscho
