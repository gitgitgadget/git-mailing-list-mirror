From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mmap implementation for mingw.
Date: Fri, 21 Nov 2008 21:51:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811212148550.30769@pacific.mpi-cbg.de>
References: <loom.20081121T024302-370@post.gmane.org>  <49266A59.4010404@viscovery.net> <gg5t5s$qc8$1@ger.gmane.org>  <alpine.DEB.1.00.0811211143550.30769@pacific.mpi-cbg.de> <3e8340490811211225g6e479dcbyeeb793eb0f825441@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Vasyl' Vavrychuk <vvavrychuk@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 21:44:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3crn-0001Hm-Vv
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 21:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYKUUnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 15:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbYKUUnX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 15:43:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:40697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752203AbYKUUnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 15:43:22 -0500
Received: (qmail invoked by alias); 21 Nov 2008 20:43:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp013) with SMTP; 21 Nov 2008 21:43:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MndFwZ1IMdbydb1TsZWdqs1MHDqtM2kbuY6ybyD
	8HNdSenvgqAIX0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3e8340490811211225g6e479dcbyeeb793eb0f825441@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101541>

Hi,

On Fri, 21 Nov 2008, Bryan Donlan wrote:

> I'm not overly familiar with the windows API, but wouldn't passing 
> FILE_SHARE_DELETE | FILE_SHARE_READ in the dwShareMode argument of 
> CreateFile() be enough to allow rename/deletion of the file in question 
> while it is mapped?

A very quick Google research already revealed that your suggestion has any 
meaning _only_ for NTFS.

So that leaves FAT behind.

I could also imagine that Windows 2K does not even bother heeding those 
flags (it speaks volumes about Microsoft's documentation that you cannot 
find out if that is the case spending less than 15 minutes, and possibly 
more than that).

So I think your objection is irrelevant, sorry,
Dscho
