From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Allowing override of the default "origin" nickname
Date: Fri, 11 Jan 2008 15:03:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801111501510.31053@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>  <Pine.LNX.4.64.0801111301360.14355@wbgn129.biozentrum.uni-wuerzburg.de>  <30e4a070801110506h19b77488sbfa6ae48701f30f9@mail.gmail.com>  <alpine.LSU.1.00.0801111348230.31053@racer.site>
 <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 16:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDLQ9-0002HD-DG
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 16:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759546AbYAKPDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 10:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759005AbYAKPDR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 10:03:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:37188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759520AbYAKPDR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 10:03:17 -0500
Received: (qmail invoked by alias); 11 Jan 2008 15:03:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 11 Jan 2008 16:03:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NYbN77siNSZR0ud6RFeaIDuIcYMh0ENCKPqoNfQ
	VCztxgFoOIRahO
X-X-Sender: gene099@racer.site
In-Reply-To: <30e4a070801110653n61a826c0y33ed13f95cddf25d@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70165>

Hi,

On Fri, 11 Jan 2008, Mark Levedahl wrote:

> On Jan 11, 2008 8:52 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > IMHO you should optimise the communication by agreeing on one origin, 
> > or alternatively not talk about a server at all (which is made easy by 
> > the global uniqueness of commit names; just say "my tip is ac9b7192").
> 
> We *cannot* agree on one definition of "origin": there is no single 
> server accessible by all, but use of submodules currently *requires* 
> that each repo's upstream be given the nickname "origin". With this 
> change, I can enforce that each server has a unique nickname and that 
> one unique nickname per server is used across the program. Absent this, 
> I cannot and end up having to have everyone translate "origin" into what 
> it means for them.
> 
> SHA-1's are absolutely unique, but what do you do when "origin" does not 
> have acdc101? I want to know that server-x@joe.com doesn't have it, 
> while server-y@mary.org does. This is the frequent problem in 
> conversation, and is the reason we have to be able to talk about the 
> particular upstream server.

Okay, so with your change the user has to either remember or lookup which 
is the default remote.  Without your change, the user has to either 
remember or lookup where origin points to.

I still think your change does not help.

Ciao,
Dscho
