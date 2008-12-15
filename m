From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Interactive rebase encoding
Date: Mon, 15 Dec 2008 16:54:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812151652400.30769@pacific.mpi-cbg.de>
References: <85647ef50812150442n48609eadl4f3e47fcc715e643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 16:47:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCFek-0008NZ-CA
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 16:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbYLOPpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 10:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbYLOPpb
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 10:45:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:41797 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751165AbYLOPpb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 10:45:31 -0500
Received: (qmail invoked by alias); 15 Dec 2008 15:45:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 15 Dec 2008 16:45:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VOblDVyrVkSJGGNssK9KIYNMZ+AZTAyTDXLyz01
	l1fvi8gOt16C70
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <85647ef50812150442n48609eadl4f3e47fcc715e643@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103173>

Hi,

On Mon, 15 Dec 2008, Constantine Plotnikov wrote:

> The interactive rebase command builds a text file and passes it to 
> editor specified as environment variable or as configuration parameter. 
> However the man page for rebase operation says nothing about which 
> encoding will be used for that file. Apparently i18n.logoutputencoding 
> is used.

As rebase -i does nothing else than piping the output of git log into a 
file (at least this is the first step), I thought it would be obvious that 
it uses the output encoding preferred by the user.

Indeed, I cannot think of any scenario where it might make sense to have a 
different encoding in git rebase -i than in git log.

Ciao,
Dscho
