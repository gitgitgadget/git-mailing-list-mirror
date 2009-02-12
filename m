From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add 'rm -f' equivalent to 'git rm' example of filter-branch
 --index-filter
Date: Fri, 13 Feb 2009 00:06:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902130005580.10279@pacific.mpi-cbg.de>
References: <AB13D1C5-4464-49B5-8314-FCB1E249BF22@semanticart.com> <1234461670-25657-1-git-send-email-jacob.helwig@gmail.com> <7v4oyzjmqv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 00:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXkeP-0003RB-Bk
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759062AbZBLXF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758243AbZBLXFZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:05:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:40244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756963AbZBLXFY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:05:24 -0500
Received: (qmail invoked by alias); 12 Feb 2009 23:05:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 13 Feb 2009 00:05:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IxVR5z3BIcfb3QiOfh9USPwzr8Vs3EkJRo/SMY2
	+sC57hWv0FI9Lw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v4oyzjmqv.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109677>

Hi,

On Thu, 12 Feb 2009, Junio C Hamano wrote:

> Jacob Helwig <jacob.helwig@gmail.com> writes:
> 
> > Signed-off-by: Jacob Helwig <jacob.helwig@gmail.com>
> > ---
> >  Documentation/git-filter-branch.txt |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> > index 451950b..1fbbbb4 100644
> > --- a/Documentation/git-filter-branch.txt
> > +++ b/Documentation/git-filter-branch.txt
> > @@ -212,6 +212,11 @@ git filter-branch --index-filter 'git rm --cached filename' HEAD
> >  
> >  Now, you will get the rewritten history saved in HEAD.
> >  
> > +As with using `rm filename`, `git rm --cached filename` will fail
> > +if the file is absent from the tree of a commit.  If it is not important
> > +whether the file is already absent from the tree, you can use
> > +`git rm --cached --ignore-unmatch filename` instead.
> > +
> >  To rewrite the repository to look as if `foodir/` had been its project
> >  root, and discard all other history:
> 
> 
> Looks sane to me.  Objections?

Definitely no objections from me.

Ciao,
Dscho
