From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 20:46:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901112044230.3586@pacific.mpi-cbg.de>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no> <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de> <86iqol8wql.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Sun Jan 11 20:47:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6HK-0000nX-9U
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 20:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZAKTp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 14:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbZAKTp6
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 14:45:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:42334 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbZAKTp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 14:45:58 -0500
Received: (qmail invoked by alias); 11 Jan 2009 19:45:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 11 Jan 2009 20:45:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CLQAKpfkC8XHgmYaXjGC/L5/dU3hPPq3MztVyQx
	WFic1nU7pBnRiZ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <86iqol8wql.fsf@broadpark.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105202>

Hi,

On Sun, 11 Jan 2009, Kjetil Barvik wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 11 Jan 2009, Kjetil Barvik wrote:
> >
> >> :100644 100644 ae96c64... e6d1d2b... M	diff-lib.c
>
> [...]
>
> kjetil@localhost ~/git2 $ git clone -q git://git.kernel.org/pub/scm/git/git.git
> kjetil@localhost ~/git2 $ cd git/
> kjetil@localhost ~/git2/git $ git show e6d1d2b34147a13aadb5019e0c8336ef5f56ee39
>      outputs => 
>             fatal: bad object e6d1d2b34147a13aadb5019e0c8336ef5f56ee39

Your patch has not been applied yet.  So no surprise there: your version 
of diff-lib.c is not there.  You'll have more luck with ae96c64, I 
guess...

My question was more: why do you do additional work and put a git diff 
--raw between the commit message and the diffstat when that information is 
in the patch already?

Ciao,
Dscho
