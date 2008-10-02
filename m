From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsexportcommit: handle file status reported out of
 order (was Re: [PATCH] Make git-cvsexportcommit "status" each file in
 turn)
Date: Thu, 2 Oct 2008 19:04:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810021745090.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <48E4AB7D.5030705@yahoo.co.uk> <alpine.DEB.1.00.0810021428170.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48E4E3F2.4000401@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu Oct 02 18:59:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlRWU-0003O5-Tx
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 18:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbYJBQ6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 12:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754946AbYJBQ6W
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 12:58:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:52749 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754882AbYJBQ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 12:58:21 -0400
Received: (qmail invoked by alias); 02 Oct 2008 16:58:19 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 02 Oct 2008 18:58:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+0W8pAxhW0t2v4DR3D4LDUKIxnLzgPwiKyrY06pl
	o5jTQvssdtqqvX
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <48E4E3F2.4000401@yahoo.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97361>

Hi,

On Thu, 2 Oct 2008, Nick Woolley wrote:

> Johannes Schindelin wrote:
> 
> > Also, given the fact that you actually verified that it was fixed in 
> > 1.6.0, what exactly is your proposed course of action?  Revert the fix 
> > in 1.6.0 and apply your patch?  Apply your patch to 1.5.6.5, cracking 
> > a release 1.5.6.6 with your patch?
> 
> Neither. At the moment, I can only offer what I have: a patch for 
> 1.5.6.5, representing an idea that may contribute something small to 
> 1.6.0 (using information from CVS on STDERR). It should be simple to 
> adapt if it's useful, if not please ignore it.

Since you did not use the preferred form of a patch, you also do not have 
a commit message describing the idea of your patch.  It is a bit hard to 
find out the intention from reading the source, and I am not motivated 
enough to find out, given that it is fixed with the commit I referred you 
to.

To save you time: the idea of the commit I referred you to is not exactly 
to use the basename, but the trimmed names.  Now only sets of unique names 
(where it is also checked that a name could not be mistaken for another, 
deleted file) are passed to cvs status.

BTW next time you search for some fix in Git's source code, you might want 
to use either "git log -- <file>" or "git bisect" to find the commit in 
question.

Hth,
Dscho
