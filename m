From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Add support for GIT_CEILING_DIRS
Date: Fri, 16 May 2008 11:21:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161120500.30431@racer>
References: <482C85C8.90804@facebook.com> <7vej83gxjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805152131390.30431@racer> <482D31B8.8000707@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 16 12:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwx4b-00017U-Sd
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbYEPKVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbYEPKVL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:21:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:36118 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752741AbYEPKVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:21:10 -0400
Received: (qmail invoked by alias); 16 May 2008 10:21:06 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp023) with SMTP; 16 May 2008 12:21:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wnjZomUxw6jALA/KhGb+bns91ZLYtZH065sUm77
	zBkI1WdSGNGaU5
X-X-Sender: gene099@racer
In-Reply-To: <482D31B8.8000707@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82266>

Hi,

On Fri, 16 May 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Thu, 15 May 2008, Junio C Hamano wrote:
> > 
> >> David Reiss <dreiss@facebook.com> writes:
> >> How well would this colon separated list work with msys folks?
> > 
> > Not well at all.  At least for the moment, I think setting this variable 
> > would fail (since it would be rewritten into a Windows-PATH-style string).  
> > Though honestly, I have no idea what getcwd() does on MinGW.
> 
> We would have to use ';' instead of ':' in longest_prefix(). Then it will
> work automatically. Except that it does not ignore case in path names and
> drive letters. Hence, the user must set this environment variable to the
> precise path name(s).

Yes, good point.

> > Steffen is working on that rewriting stuff, so maybe it will be a 
> > non-issue, eventually.
> 
> This will not matter. When we change the code to use is_path_separator()
> instead of hard-coded c == ':', then it will work automatically. We do
> that already for GIT_ALTERNATE_OBJECT_DIRECTORIES.

You are right, of course.

Ciao,
Dscho
