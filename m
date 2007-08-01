From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Wed, 1 Aug 2007 01:41:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708010138070.14781@racer.site>
References: <46AFCF3E.5010805@alum.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, users@cvs2svn.tigris.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 01 02:42:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG2I1-0008BP-Pv
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158AbXHAAlm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 20:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758421AbXHAAlm
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:41:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:38766 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751340AbXHAAll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:41:41 -0400
Received: (qmail invoked by alias); 01 Aug 2007 00:41:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 01 Aug 2007 02:41:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FSAoivjNFIBzps52gnhok0lAgZxl0XOcsZwUFpx
	mXsikjRkbMPCmV
X-X-Sender: gene099@racer.site
In-Reply-To: <46AFCF3E.5010805@alum.mit.edu>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54389>

Hi,

On Wed, 1 Aug 2007, Michael Haggerty wrote:

> 2. Check out the current trunk version of cvs2svn:
> 
>     svn co http://cvs2svn.tigris.org/svn/cvs2svn/trunk cvs2svn-trunk
>     cd cvs2svn-trunk
>     make check # ...optional

FWIW I tried to clone it with "git svn", and needed to prefix the url with 
"guest", i.e.

	$ git clone http://guest@cvs2svn.tigris.org/svn/cvs2svn/trunk

and it still did not work at once.  Somehow I managed to get the 
"Username" prompt, input "guest", and left the password empty.  Even then, 
only the second attempt succeeded (I guess somehow that "password" got 
stored in $HOME/.subversion/auth/...

Ciao,
Dscho
