From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Enable parallelized tests
Date: Fri, 8 Aug 2008 18:51:07 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081849250.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808080752210.9611@pacific.mpi-cbg.de.mpi-cbg.de> <20080808153624.GA28716@neumann> <20080808160252.GA8541@leksak.fem-net> <alpine.DEB.1.00.0808081829160.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <20080808163341.GA20211@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Aug 08 18:47:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRV7p-0003pv-7U
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 18:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYHHQqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 12:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYHHQqe
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 12:46:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:56314 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751239AbYHHQqd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 12:46:33 -0400
Received: (qmail invoked by alias); 08 Aug 2008 16:46:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp061) with SMTP; 08 Aug 2008 18:46:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZIPl7Z6nZsOEbXC0wmXSv7uQB6RG5qWha68DErI
	DncAAf5wfq8PPW
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080808163341.GA20211@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91693>

Hi,

On Fri, 8 Aug 2008, Stephan Beyer wrote:

> Johannes Schindelin wrote:
> > 
> > On Fri, 8 Aug 2008, Stephan Beyer wrote:
> > 
> > > Hm, another simple(?) solution could be to make the tests that try 
> > > to access the same port/directory/whatever depend on each other.
> > 
> > No.  Because then you cannot run them independently anymore.
> 
> Sorry, I meant, "depend on each other _in the Makefile_".
> 
> So "./t91xy-git-svn-foo.sh" will work independently, won't it? What does 
> not work independently is "make t91xy-git-svn-foo.sh" but is it that 
> bad?

I went out of my way to keep that functionality intact.  But of course, we 
could throw it away.  We could also throw Git away and go back to tarballs 
and patches.

Ciao,
Dscho

P.S.: And I do not think it is clean to say that one test depends on the 
other.  Because they do not.  They depend on not being run concurrently.  
But that could be fixed.
