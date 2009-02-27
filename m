From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WARNING] Proposed future changes that are backward
 incompatible
Date: Fri, 27 Feb 2009 20:48:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902272046040.6600@intel-tinevez-2-302>
References: <20090227192708.6266.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 20:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8jB-0007Xp-Cb
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803AbZB0Tsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbZB0Tsx
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:48:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:60206 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753339AbZB0Tsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:48:52 -0500
Received: (qmail invoked by alias); 27 Feb 2009 19:48:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp031) with SMTP; 27 Feb 2009 20:48:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ATswoafHAUnXOm5mhWzvKoe8A6NgyGiA5pXg0B6
	l0D6jfFcPnLQbk
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090227192708.6266.qmail@science.horizon.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111704>

Hi,

On Fri, 27 Feb 2009, George Spelvin wrote:

> There's one more change that was suggested that I'd like to propose:
> - Make "git grep" search the whole repository by default; include an
>   explicit "." path limiter to search only the current directory.

I use "git grep" in subdirectories extensively, and I like that it does 
_not_ search the whole repository.

Could you suggest a nice way for me to retain that behavior with an 
option?

After all, since you propose a change in behavior, it is _your_ duty to 
provide ways for those who want the old behavior to get at it easily!

In the alternative, I could suggest "git grep -e <expression> HEAD".

Ciao,
Dscho
