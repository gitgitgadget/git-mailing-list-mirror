From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Tue, 27 May 2008 14:12:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805271411520.30431@racer>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>  <alpine.DEB.1.00.0805271151430.30431@racer> <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-32547336-1211893966=:30431"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 15:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0yze-0008Qo-NL
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 15:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340AbYE0NMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 09:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757307AbYE0NMl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 09:12:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:43430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757304AbYE0NMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 09:12:40 -0400
Received: (qmail invoked by alias); 27 May 2008 13:12:36 -0000
Received: from R3650.r.pppool.de (EHLO racer.local) [89.54.54.80]
  by mail.gmx.net (mp015) with SMTP; 27 May 2008 15:12:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+aJzd9c0qaF/WsBwOQA3zUeVJEvN/53YhCfISMcs
	kBp9Dp9RFEUwnh
X-X-Sender: gene099@racer
In-Reply-To: <8aa486160805270558v40e7faabh7d4426731693f917@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83010>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-32547336-1211893966=:30431
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 27 May 2008, Santi Béjar wrote:

> On Tue, May 27, 2008 at 12:53 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 27 May 2008, Santi Béjar wrote:
> >
> >> In case you don't know the next step, if it is "git commit", "git 
> >> commit --amend", "git rebase --continue" or something else.
> >
> > We had a patch similar to this already, but I think that the right 
> > approach is _not_ to teach the single commands to explain their state, 
> > but to make a new script guessing the current state.
> 
> I think it belongs to each command to know the state, but I have no 
> problem with the single command approach.
> 
> >  AFAIR we have something like that in the completions already, as an 
> > (optional) prompt.
> 
> Thanks. And they do it a bit different, I'll use it if it is better than 
> mine.
> 
> >
> > However, I think it would make sense to push for that 
> > .dotest,.git/.dotest-merge -> .git/rebase change _before_ having 
> > anything like git-whazzup.sh.
> 
> That's a problem of the single command approach.

Sure it is.  But cluttering up the commands for something that is not 
really proven to be wanted by many is IMO inferior.

Ciao,
Dscho

--8323329-32547336-1211893966=:30431--
