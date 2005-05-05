From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: dangling trees
Date: Thu, 5 May 2005 14:17:10 +0100
Message-ID: <20050505141710.B8323@flint.arm.linux.org.uk>
References: <20050505141224.A8323@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 05 15:20:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTgBN-0004O2-L8
	for gcvg-git@gmane.org; Thu, 05 May 2005 15:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVEENUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 09:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVEENUL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 09:20:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24593 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262106AbVEENRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 09:17:17 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DTgE4-0001qb-B8; Thu, 05 May 2005 14:17:12 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DTgE3-0002i9-5i; Thu, 05 May 2005 14:17:11 +0100
To: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050505141224.A8323@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, May 05, 2005 at 02:12:25PM +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 05, 2005 at 02:12:25PM +0100, Russell King wrote:
> In todays 2.6 git repo, I see the following:
> 
> $ fsck-cache
> expect dangling commits - potential heads - due to lack of head information
> dangling commit 897f5ab2cd733a77a2279268262919caa8154b9d
> dangling tree c39ae07f393806ccf406ef966e9a15afc43cc36a
> 
> The dangling commit is the current head - that's fine.  However,
> what's this dangling tree?
> 
> It appears to have come in from Linus' tree on kernel.org this morning.
> 
> (above from cogito 0.8)

As an additional note, the ID does not correspond with any tags or
heads:

.git/refs/heads/master:897f5ab2cd733a77a2279268262919caa8154b9d
.git/refs/heads/origin:897f5ab2cd733a77a2279268262919caa8154b9d
.git/refs/tags/v2.6.11:5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
.git/refs/tags/v2.6.11-tree:5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c
.git/refs/tags/v2.6.12-rc2:9e734775f7c22d2f89943ad6c745571f1930105f
.git/refs/tags/v2.6.12-rc3:0397236d43e48e821cce5bbe6a80a1a56bb7cc3a

-- 
Russell King

