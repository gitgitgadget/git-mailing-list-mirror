From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rollback index if git-commit is interrupted by a
 signal
Date: Thu, 29 May 2008 15:42:36 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805291541430.13507@racer.site.net>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org> <alpine.DEB.1.00.0805291341290.13507@racer.site.net> <483EAD69.9090001@gnu.org> <alpine.DEB.1.00.0805291456030.13507@racer.site.net> <483EBF1F.9000809@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git mailing list <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 29 16:49:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1jMr-0005R2-M8
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 16:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752924AbYE2Onq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 10:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbYE2Onq
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 10:43:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:37842 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752507AbYE2Onp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 10:43:45 -0400
Received: (qmail invoked by alias); 29 May 2008 14:43:43 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp022) with SMTP; 29 May 2008 16:43:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YjZVoynZYnUZcl95oinbwl3yO/JeSO006v62Cp9
	kU+ztDYpiu7L9G
X-X-Sender: gene099@racer.site.net
In-Reply-To: <483EBF1F.9000809@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83206>

Hi,

On Thu, 29 May 2008, Paolo Bonzini wrote:

> > IMO it would make much more sense to _guarantee_ that the 
> > commity_style variable is set before the index is locked.  It is 
> > feasible, and there is no good reason not to do that.
> 
> No, it's not possible because the COMMIT_PARTIAL case first creates the 
> index_lock and then the false_lock.

So why don't you fix _that_?

> It would be curious at least to set the commit_style to COMMIT_NORMAL 
> after creating the index_lock, and upgrade it to COMMIT_PARTIAL later 
> on.  I contemplated that, and my patch is the simplest code that's 
> needed and works.

As I said, I think it is a regression, because you change code.  Your 
argument as to why leaves me desiring another solution.

Nuff said,
Dscho
