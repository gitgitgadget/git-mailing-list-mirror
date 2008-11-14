From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [MonoDevelop] git integration with monodevelop
Date: Fri, 14 Nov 2008 14:26:10 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811141419520.30769@pacific.mpi-cbg.de>
References: <491AAE6D.8030304@op5.se>  <1226519288.4483.176.camel@erandi.site>  <m33ahwio3v.fsf@localhost.localdomain> <1226540535.4483.203.camel@erandi.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	monodevelop-list@lists.ximian.com,
	Michael Hutchinson <m.j.hutchinson@gmail.com>
To: Miguel de Icaza <miguel@ximian.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:19:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0yaT-0006Tr-1J
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:19:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYKNNSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 08:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbYKNNSe
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 08:18:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:44756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751618AbYKNNSd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 08:18:33 -0500
Received: (qmail invoked by alias); 14 Nov 2008 13:18:30 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 14 Nov 2008 14:18:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7Hfd0Pcf74bXOB5Qyvdpk6Om1HA2LQx7G2G0mR6
	8AvHEdchuM1r1M
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1226540535.4483.203.camel@erandi.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100971>

Hi,

On Wed, 12 Nov 2008, Miguel de Icaza wrote:

> > I assume that results of Mono's Google Summer of Code 2008 projects to 
> > create managed git implementation in C# (git#)[1][2] were not very 
> > successfull?  Taking into account that JGit isn't yet full git 
> > implementation, after much longer development...
> 
> They were a complete disaster, one student was going to focus on the 
> front-end, the other on the back-end.

I kinda followed the last few weeks via your svn repository (which was not 
helped by the commits being a complete mix of the individual projects).

I was a bit disappointed that nobody asked things on the Git mailing list; 
quite a number of very important lessons were learnt during the first 
implementation of jgit, and you guys could have benefitted tremendously by 
hearing them.

By the time I got aware of your effort, it was too late; for example, the 
code already relied on the fact that every blob's contents were read into 
memory at once (IIU the code correctly).

Note: personally, I do not like C# all that much, so I am not that 
interested in the port myself.  However, we get quite a number of 
questions in that direction ("do you support .NET yet?"), so I am quite 
interested to know what's available.

May I suggest respectfully, that the next time communication channels 
between the Mono-mentor and at least one knowledgable Git guy are 
established early in the project?  IIRC there was a GSoC project to 
reimplement Git in C# last year, too, which failed, too.

Ciao,
Dscho
