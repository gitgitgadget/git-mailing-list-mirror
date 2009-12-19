From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Query remote repository files, blobs
Date: Sat, 19 Dec 2009 12:02:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912191159280.4985@pacific.mpi-cbg.de>
References: <d16b1c80912182345h4163430bv810adb860575d67a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Shakthi Kannan <shakthimaan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 12:01:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLx4H-0001tA-2I
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 12:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbZLSK5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 05:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZLSK5Q
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 05:57:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:49291 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750800AbZLSK5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 05:57:15 -0500
Received: (qmail invoked by alias); 19 Dec 2009 10:57:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 19 Dec 2009 11:57:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jv1oRvEnjz+DreARj12LdZi7NrgQB2+ft7rJHpe
	5Fp3hE05QKhHsW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <d16b1c80912182345h4163430bv810adb860575d67a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135473>

Hi,

On Sat, 19 Dec 2009, Shakthi Kannan wrote:

> Hi,
> 
> >From git-ls-remote:
> http://www.kernel.org/pub/software/scm/git/docs/git-ls-remote.html
> 
> I am able to query for list of remote heads, and tags. I would like to
> know if it is possible to query for information on remote files, or
> blobs?

This has been discussed a number of times, but we cannot allow that for 
security reasons.  A blob might contain confidential information, in which 
case the branch has to be rewritten and force-pushed.  However, that does 
not make the blob go away, but makes it only unreachable.  Until the next 
garbage collection kicks in, that is (which you typically cannot control).

So: sorry, your feature request cannot be granted.

Ciao,
Dscho
