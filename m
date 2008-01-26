From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Pyrite project.
Date: Sat, 26 Jan 2008 17:50:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801261749000.23907@racer.site>
References: <5d46db230801260127pf6f7a2fwfc8f35884a6322e@mail.gmail.com>  <alpine.LSU.1.00.0801261311380.23907@racer.site>  <5d46db230801260842i89db074u29657c22f6dbedef@mail.gmail.com>  <alpine.LSU.1.00.0801261654410.23907@racer.site>
 <5d46db230801260937w3a514842t3943d0bd7c8dfb70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <blix@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 18:51:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIpBi-0000tk-Gz
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 18:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbYAZRus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 12:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbYAZRus
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 12:50:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:55365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751101AbYAZRur (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 12:50:47 -0500
Received: (qmail invoked by alias); 26 Jan 2008 17:50:45 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp055) with SMTP; 26 Jan 2008 18:50:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/5PUsLGFv5ETFCkSB35XbfKIo8IYcVIy+DFUXy1U
	BCoSfA4oPt/5cg
X-X-Sender: gene099@racer.site
In-Reply-To: <5d46db230801260937w3a514842t3943d0bd7c8dfb70@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71785>

Hi,

On Sat, 26 Jan 2008, Govind Salinas wrote:

> On 1/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > On Sat, 26 Jan 2008, Govind Salinas wrote:
> >
> > > On 1/26/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > > Govind wrote:
> > > >
> > > > >  3. Start stripping away non-performance-critical C code and 
> > > > >     convert it to python code to help interoperate with 
> > > > >     extensions and GUIs
> > > >
> > > > I am absolutely no fan of "extensions".  You keep breaking other 
> > > > people's code if your core introduces changes; see for example the 
> > > > libgit.a issue with cgit.
> > >
> > > The nice thing about extensions is that you don't have to use them 
> > > if you don't want to.
> >
> > I know what the nice thing about extensions is.  My point was that 
> > there is also a pretty nasty side.  One that I am not prepared to 
> > accept easily.
>
> There is another benefit too.  Have a bit of code that might be 
> dangerous? Put it in an extension and it can be tested in isolation, 
> without the need to rebuild the project (for people that offer to test 
> for you).  Once it is ready and tested for general use, it can 
> beincorporated into the standard.

We have branches for that.  We don't even need an extension mechanism.

Ciao,
Dscho
