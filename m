From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] graph API: Use horizontal lines for more compact 
 graphs
Date: Tue, 21 Apr 2009 10:13:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904211010410.10279@pacific.mpi-cbg.de>
References: <20090421004027.GA12330@linux.vnet>  <alpine.DEB.1.00.0904210255280.10279@pacific.mpi-cbg.de> <b2e43f8f0904201923hd97f3e3v66addf59daa3956f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1398134432-1240301636=:10279"
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 10:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwB76-0006M0-JJ
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 10:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbZDUIMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 04:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbZDUIMV
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 04:12:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:54873 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751124AbZDUIMV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 04:12:21 -0400
Received: (qmail invoked by alias); 21 Apr 2009 08:12:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 21 Apr 2009 10:12:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18z3ygeqYozx4+eppjkfW4YtpHR7SyszmcaLu+jkJ
	A8D5klA6CiYNO/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <b2e43f8f0904201923hd97f3e3v66addf59daa3956f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117102>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1398134432-1240301636=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 20 Apr 2009, Allan Caffee wrote:

> On Mon, Apr 20, 2009 at 8:56 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Mon, 20 Apr 2009, Allan Caffee wrote:
> >
> >> +                             for (j = (target * 2)+3; j < (i - 2); j += 2)
> >
> > This (target*2)+3 is a bit too magical for me to understand.  But 
> > maybe I am just too tired?
> 
> It is a little magical.  Here target is an index into
> graph->new_columns so we double that to get the actual location of the
> edge in the string for this line.

Ah.  So how about
				 /*
				  * The variable target is the index of the graph
				  * column, and therefore target*2+3 is the actual
				  * screen column of the first horizontal line.
				  */

Hmm?

Ciao,
Dscho
--8323328-1398134432-1240301636=:10279--
