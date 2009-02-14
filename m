From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation: pruning recipe for destructive
 filter-branch
Date: Sat, 14 Feb 2009 06:46:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902140642520.10279@pacific.mpi-cbg.de>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch> <20090214025115.615119bf@perceptron>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-887539245-1234590379=:10279"
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Feb 14 06:46:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYDMe-0004Ed-8F
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 06:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbZBNFp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 00:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZBNFp2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 00:45:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:56699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751076AbZBNFp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 00:45:28 -0500
Received: (qmail invoked by alias); 14 Feb 2009 05:45:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 14 Feb 2009 06:45:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/h7yMBmAjhw5SlmATHVts+tZ0+zYFgKr66qMUfLJ
	7mqCS9tqWJlreb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090214025115.615119bf@perceptron>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109823>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-887539245-1234590379=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Feb 2009, Jan Krüger wrote:

> On Fri, 13 Feb 2009 18:14:39 +0100, Thomas Rast <trast@student.ethz.ch>
> wrote:
> 
> > Add a section about how to shrink a repository's size after running
> > git-filter-branch to remove large blobs from history.
> 
> Good idea.

Indeed.  It is funny when some people ask, but reading it several times a 
week in #git makes that fun go away real quick.

> > +* Expire all reflogs with `git reflog expire \--expire=now \--all`.
> > +
> > +* Repack to remove packed objects with `git repack -ad`.
> > +
> > +* Prune unpacked unreferenced objects with `git prune \--expire=now`.
> 
> Is the --expire=now actually needed for prune? The way I read it
> git-prune(1), it defaults to pruning everything anyway.

I hope not.  IIRC I set the default to 2 weeks.

*goes to read the source* Ah, that default is only set in "git gc", and 
"git prune" still prunes everything.  So you're absolutely correct.

But maybe we do not want to direct the user to use "prune" here, but 
rather "gc"?

Ciao,
Dscho

--8323328-887539245-1234590379=:10279--
