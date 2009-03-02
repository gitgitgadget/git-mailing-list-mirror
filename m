From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8
 encoded.
Date: Mon, 2 Mar 2009 11:56:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903021153520.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <49ABB529.1080500@viscovery.net> <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 02 11:56:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le5pH-000108-Gc
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 11:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZCBKzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 05:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZCBKzT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 05:55:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:56823 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752253AbZCBKzT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 05:55:19 -0500
Received: (qmail invoked by alias); 02 Mar 2009 10:55:16 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 02 Mar 2009 11:55:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+W92FpAx2WM12Ypv4ziwwThbe8eiq1E9a4sYdhXI
	C4N5BhlEsXnn9C
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111929>

Hi,

On Mon, 2 Mar 2009, Peter Krefting wrote:

> Johannes Sixt:
> 
> > I don't think that this assumption is valid.
> 
> Depends on where you are coming from. For the files stored in the Git 
> repositories, I believe all file names are supposed to be UTF-8 encoded 
> (just like commit messages and user names are). That's the assumption I 
> started working from.

No.  As far as Git is concerned, the file names are just as much blobs as 
the file contents.

The fact that Windows messes with this notion just as it messes with the 
file contents (think the endless story whose name is CR/LF) shows only how 
"well" designed the concepts in Windows are.

And as it stands, we have at least two issues on the msysGit issue tracker 
that complain that Git does not work with localized file names properly.

So no, file names are not UTF-8 at all, especially not on Windows.

Do not get me wrong, I really welcome you taking care of the issue, but I 
do not think that forcing UTF-8 is a solution.

Thanks & sorry,
Dscho
