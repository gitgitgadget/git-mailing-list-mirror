From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-export issue -- anyone know if this is a bug or a
 feature?
Date: Mon, 9 Feb 2009 12:17:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902091216220.10279@pacific.mpi-cbg.de>
References: <51419b2c0902082131o512e966l1fb3029c7513b02e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 12:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWU9n-0008Cr-Nv
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 12:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbZBILRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 06:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbZBILRA
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 06:17:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:45562 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752637AbZBILRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 06:17:00 -0500
Received: (qmail invoked by alias); 09 Feb 2009 11:16:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 09 Feb 2009 12:16:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eNXZOEcgembjIdm+xLUty3q6gsUKAn2c+/PICiY
	mG2beBSu/bayw3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <51419b2c0902082131o512e966l1fb3029c7513b02e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109064>

Hi,

On Sun, 8 Feb 2009, Elijah Newren wrote:

> In the source repository, I noticed that 6 of the earliest commits in 
> one root of history looked like:
> 
>      /--E
>     /  /
> A--C--D
>   /
>  B
> 
> In the "mirrored" repository, I notice this history had been modified
> so that it looked like
> 
>         E
>        /
> A--C--D
>   /
>  B
> 
> The latter history seems much more sane to me; since D is a child of
> C, making E a merge of C and D seemed really weird.  I did pour over
> the output of git fast-export --all to see if the merge directives
> were as expected, in order to see whether git fast-export or git
> fast-import were to be credited with the history fix.  It looks to me
> like git-fast-export reports no merge parents for E, so this seems to
> be on the fast-export side.
> 
> Is this, by chance, intentional?  (I'm using git-1.6.0.6, if it matters.)

Nope.

Please try to make a reproduction recipe (preferably as a patch to t9301); 
it seems that you are half-way there already.

Thanks,
Dscho
